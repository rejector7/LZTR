package model;

public class Answer {
	private int id;
	private int quesid;
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
	public Answer(int quesid) {
		super();
		this.quesid = quesid;
	}
	public Answer() {
		super();
	}
}
