package model;

import java.util.Date;

public class Answer {
	private int id;
	private int quesid;
	private Date time;
	private String ip;
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
	public String getIp() {
		return ip;
	}
	public void setIp(String ip) {
		this.ip = ip;
	}
	public Answer(int quesid, Date time, String ip) {
		super();
		this.quesid = quesid;
		this.time = time;
		this.ip=ip;
	}
	public Answer() {
		super();
	}
}
