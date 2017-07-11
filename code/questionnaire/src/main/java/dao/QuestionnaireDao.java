package dao;

import java.util.List;

import model.Questionnaire;

public interface QuestionnaireDao {

	Integer addQuestionnaire(Questionnaire ques);

	void deleteQuestionnaire(Questionnaire ques);

	void updateQuestionnaire(Questionnaire ques);

	Questionnaire getQuestionnaireById(int id);

	List<Questionnaire> getAllQuestionnaires();
	
	List<Questionnaire> findQuestionnaires(String condi);
 
}