package action;


import service.QuestionnaireService;

import java.io.IOException;
import java.sql.Date;
import java.util.ArrayList;
import java.util.List;
import org.json.JSONObject;
import org.json.JSONArray;

import model.User;
import model.Questionnaire;
import model.QuestionnaireQuestions;


public class QuestionnaireActions extends BaseAction{
	private QuestionnaireService quesService;
	private int id;
	private int userid;
	private String title;
	private String status; 		/* unp(default), pub, end, or ban */
	private int isPublic;    	/* 1(default) or 0 */
	private Date releaseTime;
	private Date endTime;
	private String content;
	
	public String getContent() {
		return content;
	}
	public void setContent(String content) {
		this.content = content;
	}
	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	public int getUserid() {
		return userid;
	}
	public void setUserid(int userid) {
		this.userid = userid;
	}
	public String getTitle() {
		return title;
	}
	public void setTitle(String title) {
		this.title = title;
	}
	public String getStatus() {
		return status;
	}
	public void setStatus(String status) {
		this.status = status;
	}
	public int getIsPublic() {
		return isPublic;
	}
	public void setIsPublic(int isPublic) {
		this.isPublic = isPublic;
	}
	public Date getReleaseTime() {
		return releaseTime;
	}
	public void setReleaseTime(Date releaseTime) {
		this.releaseTime = releaseTime;
	}
	public Date getEndTime() {
		return endTime;
	}
	public void setEndTime(Date endTime) {
		this.endTime = endTime;
	}
	public void setQuesService(QuestionnaireService quesService) {
		this.quesService = quesService;
	}
	
	/**
	 * Parse the questions with the string type into a list of questions
	 * @param questions
	 * @return
	 */
	
	/**
	 * Use appService to add a questionnaire,including its basic information and content
	 * @return
	 * @throws IOException 
	 */
	public String add() throws IOException{
		if(id!=0){
			Questionnaire ques = quesService.getQuestionnaireById(id);
			ques.setTitle(title);
			QuestionnaireQuestions quescontent = quesService.getQuestionnaireQuestionsById(id);
			quescontent.setContent(content);
			quesService.updateQuestionnaire(quescontent, ques);
			return null;
		}
		if(status==null) status = "unp";
		int userid = ((User)request().getSession().getAttribute("user")).getId();
		Questionnaire ques = new Questionnaire(userid,title,status,isPublic,releaseTime,endTime);
		QuestionnaireQuestions quescontent = new QuestionnaireQuestions(content);
		System.out.println(content);
		quesService.addQuestionnaire(quescontent, ques);
		return null;
	}
	
	/**
	 * Use appService to update a questionnaire,including its basic information and content
	 * @return
	 */
	public String update(){

		Questionnaire ques = quesService.getQuestionnaireById(id);
		ques.setEndTime(endTime);
		ques.setIsPublic(isPublic);
		ques.setReleaseTime(releaseTime);
		ques.setStatus(status);
		ques.setTitle(title);

		QuestionnaireQuestions quescontent = quesService.getQuestionnaireQuestionsById(id);
		quescontent.setContent(content);
		quesService.updateQuestionnaire(quescontent, ques);
		return null;
	}
	
	/**
	 * Use appService to delete a questionnaire,including its basic information and content
	 * @return
	 */
	public String delete(){
		Questionnaire ques = quesService.getQuestionnaireById(id);
		QuestionnaireQuestions quescontent = quesService.getQuestionnaireQuestionsById(id);
		quesService.deleteQuestionnaire(quescontent, ques);
		return null;
	}
	
	/**
	 * Use appService to get a questionnaire,including its basic information and content
	 * @return
	 * @throws IOException 
	 */
	public String get() throws IOException{
		Questionnaire ques = quesService.getQuestionnaireById(id);
		QuestionnaireQuestions quescontent = quesService.getQuestionnaireQuestionsById(id);
		request().setAttribute("quesinfo", ques);
		request().setAttribute("quescontent", quescontent.getContent());
		return "getbyid";
	}
	
	/**
	 * Use appService to get basic information of all questionnaires
	 * @return
	 */
	public String getAll(){
		List<Questionnaire> questionnaires = quesService.getAllQuestionnaires();
		request().setAttribute("Questionnaires", questionnaires);
		return "getall";
	}
	
}

