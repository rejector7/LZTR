package dao;

import java.util.List;

import org.springframework.data.mongodb.core.query.Criteria;
import org.springframework.data.mongodb.core.query.Query;

import model.QuestionnaireQuestions;

public interface QuestionnaireQuestionsDao {

	/**
	 * Add a questionnaire's content
	 * @param ques
	 */
	void addQuestionnaire(QuestionnaireQuestions ques);

	/**
	 * Delete a questionnaire's content
	 * @param ques
	 */
	void deleteQuestionnaire(QuestionnaireQuestions ques);

	/**
	 * Update a questionnaire's content
	 * @param ques
	 */
	void updateQuestionnaire(QuestionnaireQuestions ques);

	/**
	 * Get a questionnaire's content
	 * @param Id
	 * @return
	 */
	QuestionnaireQuestions getQuestionnaireById(int id);
	
	void copyQuestionnaireContent(int content_id, int new_id);
}