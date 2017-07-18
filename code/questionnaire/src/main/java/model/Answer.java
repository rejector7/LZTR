package model;

import java.util.Date;

public class Answer {
	private int id;
	private int quesid;
	private Date time;
	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	public int getQuesid() {
		return quesid;
	}
	public void setQuesid(int quesid) {
		this.quesid = quesid;
	}
	public Date getTime() {
		return time;
	}
	public void setTime(Date time) {
		this.time = time;
	}
	public Answer(int quesid, Date time) {
		super();
		this.quesid = quesid;
		this.time = time;
	}
	public Answer() {
		super();
	}
}
