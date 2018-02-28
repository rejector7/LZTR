package dao;

import java.util.List;

import model.Questionnaire;

public interface QuestionnaireDao {



	/* (non-Javadoc)
	 * @see dao.impl.QuestionnaireDao#addQuestionnaire(model.Questionnaire)
	 */
	Integer addQuestionnaire(Questionnaire ques);

	/* (non-Javadoc)
	 * @see dao.impl.QuestionnaireDao#deleteQuestionnaire(model.Questionnaire)
	 */
	void deleteQuestionnaire(Questionnaire ques);

	/* (non-Javadoc)
	 * @see dao.impl.QuestionnaireDao#updateQuestionnaire(model.Questionnaire)
	 */
	void updateQuestionnaire(Questionnaire ques);

	void copyQuestionnaire(int id);
	/* (non-Javadoc)
	 * @see dao.impl.QuestionnaireDao#getQuestionnaireById(int)
	 */
	Questionnaire getQuestionnaireById(int id);

	/* (non-Javadoc)
	 * @see dao.impl.QuestionnaireDao#getAllQuestionnaires()
	 */
	List<Questionnaire> getAllQuestionnaires();

	List<Questionnaire> getQuestionnairesByUserid(int userid);

	List<Questionnaire> findQuestionnaires(String condi);

	List<Questionnaire> getPublicQuestionnaires();

	List<Questionnaire> getPublicResults();
	
	List<Questionnaire> getTemplateQuestionnaires();
}