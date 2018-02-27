package dao.impl;
import java.util.List;
import org.springframework.data.mongodb.core.MongoTemplate;
import org.springframework.data.mongodb.core.query.Criteria;
import org.springframework.data.mongodb.core.query.Query;
import org.springframework.data.mongodb.core.query.Update;
import dao.MessageDao;
import model.Message;
public class MessageDaoImpl implements MessageDao{
	MongoTemplate mongoTemplate;
	public void setMongoTemplate(MongoTemplate mongoTemplate) {
		this.mongoTemplate = mongoTemplate;
	}
	public void addMessage(Message message){
		mongoTemplate.save(message);
	}
	public List<Message> getMessageBySid(int sid){
		Criteria criteria = Criteria.where("sid").is(sid);
	    Query query = new Query(criteria);
	    List<Message> Messages=mongoTemplate.find(query, Message.class);
	    return Messages;
	}
	public List<Message> getMessageByRid(int rid){
		Criteria criteria = Criteria.where("rid").is(rid);
	    Query query = new Query(criteria);
	    List<Message> Messages=mongoTemplate.find(query, Message.class);
	    return Messages;
	}
	//当用户点击某一信息的时候，就设置为已读
	public void update1Message(Message message){
		Criteria criteria = Criteria.where("id").is(message.getId());
	      Query query = new Query(criteria);
	      Update update = new Update().set("isread", 1);
	      mongoTemplate.updateFirst(query, update, Message.class);
	}
	//用户可以将一个已读消息设为未读
	public void update0Message(Message message){
		Criteria criteria = Criteria.where("id").is(message.getId());
	      Query query = new Query(criteria);
	      Update update = new Update().set("isread", 0);
	      mongoTemplate.updateFirst(query, update, Message.class);
	}
	public Message getMsgById(String id){
		Criteria criteria = Criteria.where("id").is(id);
		Query query = new Query(criteria);
		List<Message> Messages=mongoTemplate.find(query, Message.class);
		if(!(Messages==null||Messages.isEmpty())){
			return Messages.get(0);
		}
		else {
			return null;
		}
	}
}
