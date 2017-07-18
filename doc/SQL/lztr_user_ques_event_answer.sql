/*
Navicat MySQL Data Transfer

Source Server         : My DB
Source Server Version : 50717
Source Host           : localhost:3306
Source Database       : lztr

Target Server Type    : MYSQL
Target Server Version : 50717
File Encoding         : 65001

Date: 2017-07-18 10:49:27
*/

SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
-- Table structure for answer
-- ----------------------------
DROP TABLE IF EXISTS `answer`;
CREATE TABLE `answer` (
  `id` int(11) NOT NULL,
  `quesid` int(11) NOT NULL,
  `time` datetime DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for questionnaire
-- ----------------------------
DROP TABLE IF EXISTS `questionnaire`;
CREATE TABLE `questionnaire` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `userid` int(11) NOT NULL,
  `title` varchar(255) NOT NULL,
  `status` varchar(255) NOT NULL DEFAULT 'unp' COMMENT 'unp, pub, end, ban',
  `isPublic` int(1) unsigned zerofill DEFAULT '1' COMMENT 'public(1) or private(0)',
  `releaseTime` datetime DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP,
  `endTime` datetime DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for user
-- ----------------------------
DROP TABLE IF EXISTS `user`;
CREATE TABLE `user` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `username` varchar(255) NOT NULL,
  `password` varchar(255) NOT NULL,
  `age` int(11) DEFAULT NULL,
  `sex` varchar(11) DEFAULT 'male' COMMENT 'male or female',
  `email` varchar(255) DEFAULT NULL,
  `country` varchar(255) DEFAULT NULL,
  `city` varchar(255) DEFAULT NULL,
  `mobile` varchar(255) DEFAULT NULL,
  `qq` varchar(255) DEFAULT NULL,
  `wechat` varchar(255) DEFAULT NULL,
  `role` varchar(11) NOT NULL DEFAULT 'user' COMMENT 'user表示一般用户，admin表示管理员',
  `job` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Procedure structure for status_change
-- ----------------------------
DROP PROCEDURE IF EXISTS `status_change`;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `status_change`()
BEGIN
	UPDATE questionnaire
	SET questionnaire.`status` = 'end'
	WHERE CURDATE() > questionnaire.endTime;
END
;;
DELIMITER ;

-- ----------------------------
-- Event structure for questionnaire_status_autochange
-- ----------------------------
DROP EVENT IF EXISTS `questionnaire_status_autochange`;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` EVENT `questionnaire_status_autochange` ON SCHEDULE EVERY 1 DAY STARTS '2017-07-12 10:51:56' ON COMPLETION NOT PRESERVE DISABLE DO CALL status_change()
;;
DELIMITER ;
