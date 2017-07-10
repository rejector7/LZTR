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
	private String content;
	
	public QuestionnaireQuestions() {
		super();
	}
	public QuestionnaireQuestions(String content) {
		super();
		this.content = content;
	}
	public QuestionnaireQuestions(int quesid, String content) {
		super();
		this.quesid = quesid;
		this.content = content;
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
	public String getContent() {
		return content;
	}
	public void setContent(String content) {
		this.content = content;
	}
	
}
