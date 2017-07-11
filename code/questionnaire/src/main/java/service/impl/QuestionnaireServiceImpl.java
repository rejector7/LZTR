package service.impl;

import java.util.List;

import dao.QuestionnaireDao;
import model.Questionnaire;
import service.QuestionnaireService;

public class QuestionnaireServiceImpl implements QuestionnaireService {
	
	private QuestionnaireDao questionnaireDao;
	public void setQuestionnaireDao(QuestionnaireDao quesDao) {
		this.questionnaireDao = quesDao;
	}
	
	/* (non-Javadoc)
	 * @see service.impl.QuestionnaireService#addQuestionnaire(model.Questionnaire)
	 */
	@Override
	public Integer addQuestionnaire(Questionnaire ques) {
		return questionnaireDao.addQuestionnaire(ques);
	}

	/* (non-Javadoc)
	 * @see service.impl.QuestionnaireService#deleteQuestionnaire(model.Questionnaire)
	 */
	@Override
	public void deleteQuestionnaire(Questionnaire ques) {
		questionnaireDao.deleteQuestionnaire(ques);
	}

	/* (non-Javadoc)
	 * @see service.impl.QuestionnaireService#updateQuestionnaire(model.Questionnaire)
	 */
	@Override
	public void updateQuestionnaire(Questionnaire ques) {
		questionnaireDao.updateQuestionnaire(ques);
	}

	/* (non-Javadoc)
	 * @see service.impl.QuestionnaireService#getQuestionnaireById(int)
	 */
	@Override
	public Questionnaire getQuestionnaireById(int id) {
		return questionnaireDao.getQuestionnaireById(id);
	}

	/* (non-Javadoc)
	 * @see service.impl.QuestionnaireService#getAllQuestionnaires()
	 */
	@Override
	public List<Questionnaire> getAllQuestionnaires() {
		return questionnaireDao.getAllQuestionnaires();
	}
	
	/* (non-Javadoc)
	 * @see service.impl.QuestionnaireService#findQuestionnaires(Sting condi)
	 */
	@Override
	public List<Questionnaire> findQuestionnaires(String condi){
		return questionnaireDao.findQuestionnaires(condi);
	}
}
