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
	      update.set("content",ques.getContent());
	      mongoTemplate.updateFirst(query, update, QuestionnaireQuestions.class);
	}
	
	public QuestionnaireQuestions getQuestionnaireById(int id){
		Criteria criteria = Criteria.where("quesid").is(id);
	      Query query = new Query(criteria);
	      List<QuestionnaireQuestions> questionnaires=mongoTemplate.find(query, QuestionnaireQuestions.class);
	      if(!(questionnaires==null||questionnaires.isEmpty())){
	    	  return questionnaires.get(0);
		  }
	      else {
	    	  return null;}
	}
}
