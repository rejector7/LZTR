package dao;

import java.util.List;

import org.springframework.data.mongodb.core.query.Criteria;
import org.springframework.data.mongodb.core.query.Query;

import model.QuestionnaireQuestions;

public interface QuestionnaireQuestionsDao {

	void addQuestionnaire(QuestionnaireQuestions ques);

	void deleteQuestionnaire(QuestionnaireQuestions ques);

	void updateQuestionnaire(QuestionnaireQuestions ques);

	QuestionnaireQuestions getQuestionnaireById(String Id);

}