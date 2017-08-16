package dao;

import java.util.List;

import org.springframework.data.mongodb.core.query.Criteria;
import org.springframework.data.mongodb.core.query.Query;

import model.Message;

public interface MessageDao {

	void addMessage(Message message);

	List<Message> getMessageBySid(int sid);
	
	List<Message> getMessageByRid(int rid);

	void update1Message(Message message); //单纯的修改消息的状态（已读--》未读）
	
	void update0Message(Message message);
	
	Message getMsgById(String id);
}