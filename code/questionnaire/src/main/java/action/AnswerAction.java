package action;

import java.util.List;

import model.Answer;
import model.AnswerSheet;
import service.AnswerSheetService;

public class AnswerAction extends BaseAction{
	private AnswerSheetService ansService;
	private int id;
	private int quesid;
	private int userid;
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
	public int getUserid() {
		return userid;
	}
	public void setUserid(int userid) {
		this.userid = userid;
	}
	public String getContent() {
		return content;
	}
	public void setContent(String content) {
		this.content = content;
	}
	public void setAnsService(AnswerSheetService ansService) {
		this.ansService = ansService;
	}
	
	public String add(){
		Answer ans = new Answer(quesid);
		AnswerSheet anst  = new AnswerSheet(content);
		if(userid != 0){
			anst.setUserid(userid);
		}
		return null;
	}
	
	public String update(){
		AnswerSheet anst = ansService.getAnswerSheetById(id);
		anst.setContent(content);
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
