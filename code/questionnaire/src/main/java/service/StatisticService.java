package service;

import java.util.List;

import model.AnswerSheet;

public interface StatisticService {

	/**
	 * Get all answers by the specific id of a questionnaire
	 * @param quesid
	 * @return
	 */
	List<AnswerSheet> getAnssheetsByQuesid(int quesid);

}