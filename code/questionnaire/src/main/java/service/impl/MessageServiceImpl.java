package service.impl;
import java.util.List;
import dao.MessageDao;
import model.Message;
import service.MessageService;
public class MessageServiceImpl implements MessageService{
	private MessageDao messageDao;
	public void setMessageDao(MessageDao msgDao){
		this.messageDao = msgDao;
	}
	public void addMessage(Message message){
		messageDao.addMessage(message);
	}
	public List<Message> getMessageBySid(int sid){
		return messageDao.getMessageBySid(sid);
	}
	public List<Message> getMessageByRid(int rid){
		return messageDao.getMessageByRid(rid);
	}
	public void update1Message(Message message){
		messageDao.update1Message(message);
	}
	public void update0Message(Message message){
		messageDao.update0Message(message);
	}
	public Message getMsgById(String id){
		return messageDao.getMsgById(id);
	}
}