package model;

import org.springframework.data.mongodb.core.mapping.Document;

@Document(collection="AnswerSheets")
public class AnswerSheet {
	private int id;
	private int answerid;
	private int userid;
	private String content;
	public AnswerSheet() {
		super();
	}
	public AnswerSheet(int answerid, String content) {
		super();
		this.answerid = answerid;
		this.content = content;
	}
	public AnswerSheet(int answerid, int userid, String content) {
		super();
		this.answerid = answerid;
		this.userid = userid;
		this.content = content;
	}
	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
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
