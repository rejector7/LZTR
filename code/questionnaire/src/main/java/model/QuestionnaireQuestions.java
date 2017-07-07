package model;

import java.util.ArrayList;
import java.util.List;

import org.springframework.data.annotation.Id;
import org.springframework.data.mongodb.core.mapping.Document;
/**
 * Model of a questionnaire's content, including all questions in it and its introduction,
 * can be identified by its questionnaireid.
 * @author LZTR
 *
 */
@Document(collection="QuestionnaireQuestions")
public class QuestionnaireQuestions {
	private String id;
	private int quesid;
	private List<Question> questions=new ArrayList<Question>();
	private String introduction;
	
	public QuestionnaireQuestions() {
	}
	public QuestionnaireQuestions(int quesid, List<Question> questions,String introduction) {
		super();
		this.quesid = quesid;
		this.questions = questions;
		this.introduction = introduction;
	}
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public int getQuesid() {
		return quesid;
	}
	public void setQuesid(int quesid) {
		this.quesid = quesid;
	}
	public List<Question> getQuestions() {
		return questions;
	}
	public void setQuestions(List<Question> questions) {
		this.questions = questions;
	}
	public String getIntroduction() {
		return introduction;
	}
	public void setIntroduction(String introduction) {
		this.introduction = introduction;
	}
	
	
}
