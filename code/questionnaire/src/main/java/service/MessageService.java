package service;

import java.util.List;
import model.Message;

public interface MessageService {
	void addMessage(Message message);
	
	List<Message> getMessageBySid(int sid);
	
	List<Message> getMessageByRid(int rid);
	
	void update1Message(Message message);
	
	void update0Message(Message message);
	
	Message getMsgById(String id);
}