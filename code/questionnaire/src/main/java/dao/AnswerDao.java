package dao;

import java.util.List;

import model.Answer;

public interface AnswerDao {

	Integer addAnswer(Answer ans);

	void updateAnswer(Answer ans);

	void deleteAnswer(Answer ans);

	Answer getAnswerById(int id);

	List<Answer> getAnswersByQuesId(int quesid);

	List<Answer> getAnswersByIp(String ip);

}