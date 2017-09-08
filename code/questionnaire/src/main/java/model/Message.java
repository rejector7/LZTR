package model;
import org.springframework.data.mongodb.core.mapping.Document;
import java.util.Date;
@Document(collection="Message")
public class Message {
	private String id;
	private int sid;  //sender id
	private int rid;  //receiver id
	private String msg; //message 
	private int isread;
	private Date senddate;
	public Message() {
		super();
	}
	public Message(int sid, int rid, String msg) {
		super();
		this.sid = sid;
		this.rid = rid;
		this.msg = msg;
		this.isread = 0;  //默认新建的信息未读
		this.senddate = new Date(); //获取当前时间
	}
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public int getSid() {
		return sid;
	}
	public void setSid(int sid) {
		this.sid = sid;
	}
	
	public int getRid() {
		return rid;
	}
	public void setRid(int rid) {
		this.rid = rid;
	}
	public int getIsread() {
		return isread;
	}
	public void setIsread(int isread) {
		this.isread = isread;
	}
	public String getMsg() {
		return msg;
	}
	public void setMsg(String msg) {
		this.msg = msg;
	}
	
	public Date getSenddate(){
		return senddate;
	}
	public void setSenddate(Date senddate){
		this.senddate = senddate;
	}
}
