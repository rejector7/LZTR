package service;

import java.util.List;

import org.json.JSONArray;
import org.json.JSONObject;

import model.AnswerSheet;

public interface StatisticService {

	/**
	 * Get all answers by the specific id of a questionnaire
	 * @param quesid
	 * @return
	 */
	JSONObject getAnssheetsByQuesid(int quesid);

}