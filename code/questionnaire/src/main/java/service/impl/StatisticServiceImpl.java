package service.impl;

import java.util.ArrayList;
import java.util.List;

import dao.AnswerDao;
import dao.AnswerSheetDao;
import dao.QuestionnaireQuestionsDao;
import model.Answer;
import model.AnswerSheet;
import service.StatisticService;

/**
 * Implement of service of statistics
 * @author LZTR
 *
 */
public class StatisticServiceImpl implements StatisticService {
	private QuestionnaireQuestionsDao quesDao;
	private AnswerDao ansDao;
	private AnswerSheetDao anssheetDao;
	
	public void setQuestionnairequestionsDao(QuestionnaireQuestionsDao questionnairequestionsDao) {
		this.quesDao = questionnairequestionsDao;
	}
	
	public void setAnsDao(AnswerDao ansDao) {
		this.ansDao = ansDao;
	}
	
	public void setAnssheetDao(AnswerSheetDao anssheetDao) {
		this.anssheetDao = anssheetDao;
	}
	
	public void setQuesDao(QuestionnaireQuestionsDao quesDao) {
		this.quesDao = quesDao;
	}

	/* (non-Javadoc)
	 * @see service.impl.StatisticService#getAnssheetsByQuesid(int)
	 */
	@Override
	public List<AnswerSheet> getAnssheetsByQuesid(int quesid){
		List<AnswerSheet> ansts = new ArrayList<AnswerSheet>();
		List<Answer> anss = ansDao.getAnswersByQuesId(quesid);
		for(Answer ans : anss){
			ansts.add(anssheetDao.getAnswerSheetById(ans.getId()));
		}
		return ansts;
	}
}
