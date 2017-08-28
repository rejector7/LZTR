package service.impl;

import java.util.List;

import dao.QuestionnaireDao;
import dao.QuestionnaireQuestionsDao;
import model.Questionnaire;
import model.QuestionnaireQuestions;
import service.QuestionnaireService;

public class QuestionnaireServiceImpl implements QuestionnaireService{
	private QuestionnaireQuestionsDao questionnairequestionsDao;
	private QuestionnaireDao quesDao;

	public void setQuestionnairequestionsDao(QuestionnaireQuestionsDao questionnairequestionsDao) {
		this.questionnairequestionsDao = questionnairequestionsDao;
	}
	
	public void setQuesDao(QuestionnaireDao quesDao) {
		this.quesDao = quesDao;
	}


	/* (non-Javadoc)
	 * @see service.impl.QuestionnaireService#addQuestionnaire(model.QuestionnaireQuestions, model.Questionnaire)
	 */
	@Override
	public void addQuestionnaire(QuestionnaireQuestions questions,Questionnaire ques){
		int id = quesDao.addQuestionnaire(ques);
		questions.setQuesid(id);
		questionnairequestionsDao.addQuestionnaire(questions);
	}
	

	/* (non-Javadoc)
	 * @see service.impl.QuestionnaireService#updateQuestionnaire(model.QuestionnaireQuestions, model.Questionnaire)
	 */
	@Override
	public void updateQuestionnaire(QuestionnaireQuestions questions,Questionnaire ques){
		questionnairequestionsDao.updateQuestionnaire(questions);
		quesDao.updateQuestionnaire(ques);
	}
	

	/* (non-Javadoc)
	 * @see service.impl.QuestionnaireService#deleteQuestionnaire(model.QuestionnaireQuestions, model.Questionnaire)
	 */
	@Override
	public void deleteQuestionnaire(QuestionnaireQuestions questions,Questionnaire ques){
		questionnairequestionsDao.deleteQuestionnaire(questions);
		quesDao.deleteQuestionnaire(ques);
	}
	

	/* (non-Javadoc)
	 * @see service.impl.QuestionnaireService#getQuestionnaireQuestionsById(int)
	 */
	@Override
	public QuestionnaireQuestions getQuestionnaireQuestionsById(int id){		
		return questionnairequestionsDao.getQuestionnaireById(id);
	}
	
	/* (non-Javadoc)
	 * @see service.impl.QuestionnaireService#getQuestionnaireById(int)
	 */
	@Override
	public Questionnaire getQuestionnaireById(int id) {
		return quesDao.getQuestionnaireById(id);
	}

	/* (non-Javadoc)
	 * @see service.impl.QuestionnaireService#getAllQuestionnaires()
	 */
	@Override
	public List<Questionnaire> getAllQuestionnaires(){
		return quesDao.getAllQuestionnaires();
	}

	/* (non-Javadoc)
	 * @see service.impl.QuestionnaireService#getQuestionnairesByUserid(int)
	 */
	@Override
	public List<Questionnaire> getQuestionnaireByUserId(int userid){
		return quesDao.getQuestionnairesByUserid(userid);
	}
	
	@Override
	public List<Questionnaire> findQuestionnaires(String condi){
		return quesDao.findQuestionnaires(condi);
	}
	
	@Override
	public void updateQuestionnaire(Questionnaire ques) {
		quesDao.updateQuestionnaire(ques);
	}
	
	@Override
	public List<Questionnaire> getPublicQuestionnaires(){
		return quesDao.getPublicQuestionnaires();
	}
}
