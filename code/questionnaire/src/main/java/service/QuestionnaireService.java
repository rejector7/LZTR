package service;

import java.util.List;

import model.Questionnaire;
import model.QuestionnaireQuestions;

public interface QuestionnaireService {

	void addQuestionnaire(QuestionnaireQuestions questions, Questionnaire ques);

	void updateQuestionnaire(QuestionnaireQuestions questions, Questionnaire ques);

	void deleteQuestionnaire(QuestionnaireQuestions questions, Questionnaire ques);

	QuestionnaireQuestions getQuestionnaireQuestionsById(int id);

	Questionnaire getQuestionnaireById(int id);

	List<Questionnaire> getAllQuestionnaires();

	List<Questionnaire> getQuestionnairesByUserid(int userid);

	List<Questionnaire> findQuestionnaires(String condi);

}