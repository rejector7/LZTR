package service.impl;

import java.util.ArrayList;
import java.util.List;

import org.json.JSONArray;
import org.json.JSONObject;

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
	public JSONArray getAnssheetsByQuesid(int quesid){
		JSONArray ansts = new JSONArray();
		List<Answer> anss = ansDao.getAnswersByQuesId(quesid);
		for(Answer ans : anss){
			ansts.put(new JSONArray(anssheetDao.getAnswerSheetById(ans.getId()).getContent()));
		}
		return ansts;
	}
}
