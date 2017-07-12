package service;

import java.util.List;
import model.Questionnaire;
import model.QuestionnaireQuestions;

public interface QuestionnaireService {

	/**
	 * Add a questionnaire,including its basic information and content
	 * @param questions
	 * @param ques
	 */
	void addQuestionnaire(QuestionnaireQuestions questions, Questionnaire ques);

	/**
	 * Update a questionnaire,including its basic information and content
	 * @param questions
	 * @param ques
	 */
	void updateQuestionnaire(QuestionnaireQuestions questions, Questionnaire ques);
	
	void updateQuestionnaire(Questionnaire ques);

	/**
	 * Delete a questionnaire,including its basic information and content
	 * @param questions
	 * @param ques
	 */
	void deleteQuestionnaire(QuestionnaireQuestions questions, Questionnaire ques);

	/**
	 * Get content of a questionnaire by its id
	 * @param id
	 * @return
	 */
	QuestionnaireQuestions getQuestionnaireQuestionsById(int id);

	/**
	 * Get basic information of a questionnaire by its id
	 * @param id
	 * @return
	 */
	Questionnaire getQuestionnaireById(int id);

	/**
	 * Get basic information of all questionnaires
	 * @return
	 */
	List<Questionnaire> getAllQuestionnaires();

	/**
	 * Get basic information of a certain user's all questionnaires by his or her userid
	 * @param userid
	 * @return
	 */
	List<Questionnaire> getQuestionnaireByUserId(int userid);

	/**
	 * Find questionnaires with a given keyword
	 * @param condi
	 * @return
	 */
	List<Questionnaire> findQuestionnaires(String condi);

}

