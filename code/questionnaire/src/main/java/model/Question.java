package model;

public class Question {
	private int id;		//The id of the question in a questionnaire
	private String stem; //The content of the question
	private String type; 
	//Type of question,including multiple choice,user information blanks,subjective question
	private boolean isMust;//Judges if the problem must be solved

	public Question(){
		
	}
	public Question(int id, String stem, String type, boolean isMust) {
		super();
		this.id = id;
		this.stem = stem;
		this.type = type;
		this.isMust = isMust;
	}
	
	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	public String getStem() {
		return stem;
	}
	public void setStem(String stem) {
		this.stem = stem;
	}
	public String getType() {
		return type;
	}
	public void setType(String type) {
		this.type = type;
	}
	
	public boolean isMust() {
		return isMust;
	}
	public void setMust(boolean isMust) {
		this.isMust = isMust;
	}
}
