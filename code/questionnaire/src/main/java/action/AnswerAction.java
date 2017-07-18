package action;

import java.util.Date;
import java.util.List;

import org.json.JSONObject;

import model.Answer;
import model.AnswerSheet;
import model.User;
import service.AnswerSheetService;

public class AnswerAction extends BaseAction{
	private AnswerSheetService ansService;
	private int id;
	private int quesid;
	private Date time;
	private String content;
	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	public int getQuesid() {
		return quesid;
	}
	public void setQuesid(int quesid) {
		this.quesid = quesid;
	}
	public String getContent() {
		return content;
	}
	public void setContent(String content) {
		this.content = content;
	}
	public Date getTime() {
		return time;
	}
	public void setTime(Date time) {
		this.time = time;
	}
	public void setAnsService(AnswerSheetService ansService) {
		this.ansService = ansService;
	}
	
	public String add(){
		Answer ans = new Answer(quesid, time);
		JSONObject pack = new JSONObject();
		pack.put("content", content);
		AnswerSheet anst  = new AnswerSheet(pack.toString());
		if(session().getAttribute("user") != null){
			User user = (User)session().getAttribute("user");
			anst.setUserid(user.getId());
		}
		ansService.addAnswer(ans, anst);
		return null;
	}
	
	public String update(){
		
		return null;
	}
	
	public String delete(){
		Answer ans = ansService.getAnswerById(id);
		AnswerSheet anst = ansService.getAnswerSheetById(id);
		ansService.deleteAnswer(ans, anst);
		return null;
	}
	
	public String getByQuesid(){
		List<Answer> anss = ansService.getAnswerByQuestion(quesid);
		request().setAttribute("answers", anss);
		return null;
	}
}
