package model;

import org.springframework.data.mongodb.core.mapping.Document;
/**
 * Model for answer sheet, including the default id created by mongodb, the id of the answer sheet, 
 * the id of the user who gave the answers(if he/she was logged on), and the answers he/she gave
 * @author LZTR
 *
 */
@Document(collection="AnswerSheets")
public class AnswerSheet {
	private int answerid;
	private int userid;
	private String content;
	public AnswerSheet() {
	}
	/**
	 * Create answersheet with specific content, usually used when a new answersheet, which is 
	 * done by a unregistered user, is being saved for the first time
	 * the firsttime
	 * @param content
	 */
	public AnswerSheet(String content) {
		super();
		this.content = content;
	}
	/**
	 * Create answersheet with specific answerid and content,usually used when answerid is known
	 * @param answerid
	 * @param content
	 */
	public AnswerSheet(int answerid, String content) {
		super();
		this.answerid = answerid;
		this.content = content;
	}
/**
 * Create answersheet with specific answerid, userid and content,usually used when answerid is known
 * and there exists a userid
 * @param answerid
 * @param userid
 * @param content
 */
	public AnswerSheet(int answerid, int userid, String content) {
		super();
		this.answerid = answerid;
		this.userid = userid;
		this.content = content;
	}
	public int getUserid() {
		return userid;
	}
	public void setUserid(int userid) {
		this.userid = userid;
	}
	public int getAnswerid() {
		return answerid;
	}
	public void setAnswerid(int answerid) {
		this.answerid = answerid;
	}
	public String getContent() {
		return content;
	}
	public void setContent(String content) {
		this.content = content;
	}
}
