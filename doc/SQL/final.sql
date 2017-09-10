CREATE DATABASE `questionnaire` /*!40100 DEFAULT CHARACTER SET utf8 COLLATE utf8_bin */;
-- ----------------------------
-- Table structure for user
-- ----------------------------
DROP TABLE IF EXISTS `user`;
CREATE TABLE `user` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `username` varchar(255) NOT NULL,
  `password` varchar(255) NOT NULL,
  `role` varchar(11) DEFAULT 'user' COMMENT 'user表示一般用户，admin表示管理员',
  `sex` varchar(8) DEFAULT NULL,
  `age` int(4) DEFAULT NULL,
  `email` varchar(255) DEFAULT NULL,
  `country` varchar(255) DEFAULT NULL,
  `city` varchar(255) DEFAULT NULL,
  `mobile` varchar(11) DEFAULT NULL,
  `qq` varchar(32) DEFAULT NULL,
  `wechat` varchar(255) DEFAULT NULL,
  `job` varchar(255) DEFAULT NULL,
  `status` int(11) DEFAULT NULL,
  `createDate` datetime DEFAULT NULL,
  `activateTime` bigint(20) DEFAULT NULL,
  `token` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for questionnaire
-- ----------------------------
DROP TABLE IF EXISTS `questionnaire`;
CREATE TABLE `questionnaire` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `userid` int(11) NOT NULL,
  `status` varchar(255) NOT NULL DEFAULT 'unp' COMMENT 'unp, pub, end, ban',
  `range` varchar(255) DEFAULT 'public' COMMENT 'public or private',
  `releaseTime` datetime DEFAULT NULL,
  `endTime` datetime DEFAULT NULL,
  `isPublic` int(11) DEFAULT NULL,
  `title` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL,
  `allowDup` int(1) DEFAULT '1',
  PRIMARY KEY (`id`,`title`)
) ENGINE=InnoDB AUTO_INCREMENT=48 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for answer
-- ----------------------------
DROP TABLE IF EXISTS `answer`;
CREATE TABLE `answer` (
  `id` int(10) NOT NULL AUTO_INCREMENT,
  `quesid` int(10) NOT NULL,
  `time` datetime DEFAULT NULL,
  `ip` varchar(16) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `quesid` (`quesid`),
  CONSTRAINT `answer_ibfk_1` FOREIGN KEY (`quesid`) REFERENCES `questionnaire` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=49 DEFAULT CHARSET=latin1;

-- ----------------------------
-- Procedure structure for status_change_end
-- ----------------------------
DROP PROCEDURE IF EXISTS `status_change_end`;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `status_change_end`()
BEGIN
	UPDATE questionnaire
	SET questionnaire.`status` = 'end'
	WHERE CURDATE() >= questionnaire.endTime AND questionnaire.endTime != null AND questionnaire.`status` = 'pub';
END
;;
DELIMITER ;

-- ----------------------------
-- Procedure structure for status_change_pub
-- ----------------------------
DROP PROCEDURE IF EXISTS `status_change_pub`;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `status_change_pub`()
BEGIN
	UPDATE questionnaire
	SET questionnaire.`status` = 'pub'
	WHERE CURDATE() >= questionnaire.releaseTime AND questionnaire.endTime != null AND questionnaire.`status` = 'unp';
END
;;
DELIMITER ;

-- ----------------------------
-- Event structure for status_end
-- ----------------------------
DROP EVENT IF EXISTS `status_end`;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` EVENT `status_end` ON SCHEDULE EVERY 1 DAY STARTS '2017-09-06 00:00:00' ON COMPLETION PRESERVE ENABLE DO CALL status_change_end()
;;
DELIMITER ;

-- ----------------------------
-- Event structure for status_pub
-- ----------------------------
DROP EVENT IF EXISTS `status_pub`;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` EVENT `status_pub` ON SCHEDULE EVERY 1 DAY STARTS '2017-09-06 00:00:00' ON COMPLETION PRESERVE ENABLE DO CALL status_change_pub()
;;
DELIMITER ;