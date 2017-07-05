package dao.impl;

import java.util.List;

import org.springframework.data.mongodb.core.MongoTemplate;
import org.springframework.data.mongodb.core.query.Criteria;
import org.springframework.data.mongodb.core.query.Query;
import org.springframework.data.mongodb.core.query.Update;

import dao.QuestionnaireQuestionsDao;
import model.QuestionnaireQuestions;

public class QuestionnaireQuestionsDaoImpl implements QuestionnaireQuestionsDao{
	MongoTemplate mongoTemplate;

	public void setMongoTemplate(MongoTemplate mongoTemplate) {
		this.mongoTemplate = mongoTemplate;
	}
	
	public void addQuestionnaire(QuestionnaireQuestions ques){
		mongoTemplate.save(ques);
	}
	
	public void deleteQuestionnaire(QuestionnaireQuestions ques){
		mongoTemplate.remove(ques);
	}
	
	public void updateQuestionnaire(QuestionnaireQuestions ques){
		Criteria criteria = Criteria.where("quesid").is(ques.getQuesid());
	      Query query = new Query(criteria);
	      Update update = new Update().set("quesid", ques.getQuesid());
	      mongoTemplate.updateFirst(query, update, QuestionnaireQuestions.class);
	      update.set("questions", ques.getQuestions());
	      mongoTemplate.updateFirst(query, update, QuestionnaireQuestions.class);
	}
	
	public QuestionnaireQuestions getQuestionnaireById(String Id){
		Criteria criteria = Criteria.where("quesid").is(Id);
	      Query query = new Query(criteria);
	      List<QuestionnaireQuestions> questionnaires=mongoTemplate.find(query, QuestionnaireQuestions.class);
		  QuestionnaireQuestions questionnaire = new QuestionnaireQuestions();
	      if(!(questionnaires==null||questionnaires.isEmpty())){
	    	  questionnaire=questionnaires.iterator().next();
		  }
	      else return null;
	      return questionnaire;
	}
}
