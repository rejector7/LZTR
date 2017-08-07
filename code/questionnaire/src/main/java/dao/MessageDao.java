package dao;

import java.util.List;

import org.springframework.data.mongodb.core.query.Criteria;
import org.springframework.data.mongodb.core.query.Query;

import model.Message;

public interface MessageDao {

	void addMessage(Message message);

	List<Message> getMessageBySid(int sid);
	
	List<Message> getMessageByRid(int rid);

	void updateMessage(Message message);
}