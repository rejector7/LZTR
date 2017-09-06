package service;

import java.util.List;

import model.Answer;
import model.AnswerSheet;

public interface AnswerSheetService {

	void addAnswer(Answer ans, AnswerSheet anst);

	void updateAnswer(Answer ans, AnswerSheet anst);

	void deleteAnswer(Answer ans, AnswerSheet anst);

	Answer getAnswerById(int id);

	AnswerSheet getAnswerSheetById(int id);

	List<Answer> getAnswerByQuestion(int quesid);

	void deleteAnswersByQuestionId(int quesid);

	List<Answer> getAnswersByIp(String ip,int quesid);

}