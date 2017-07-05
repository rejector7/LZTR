package action;

import service.QuestionnaireService;

import java.sql.Date;
import java.util.ArrayList;
import java.util.List;
import org.json.JSONObject;
import org.json.JSONArray;

import model.MultipleChoice;
import model.Question;
import model.Questionnaire;
import model.QuestionnaireQuestions;
import model.SubjectiveQuestion;
import model.UserInfoBlank;

public class QuestionnaireActions extends BaseAction{
	private QuestionnaireService quesService;
	private int id;
	private int userid;
	private String title;
	private String status; 		/* unp(default), pub, end, or ban */
	private int isPublic;    	/* 1(default) or 0 */
	private Date releaseTime;
	private Date endTime;
	private String questions;
	private String introduction;
	
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
	public String getQuestions() {
		return questions;
	}
	public void setQuestions(String questions) {
		this.questions = questions;
	}
	public String getIntroduction() {
		return introduction;
	}
	public void setIntroduction(String introduction) {
		this.introduction = introduction;
	}
	public void setQuesService(QuestionnaireService quesService) {
		this.quesService = quesService;
	}
	
	private List<Question> parseQuestionList(String questions){
		JSONArray quesjsonlist = new JSONArray(questions);
		List<Question> queslist = new ArrayList<Question>();
		for(int i=0;i<quesjsonlist.length();i++){
			JSONObject quesjson = quesjsonlist.getJSONObject(i);
			int quesid = quesjson.getInt("id");
			String questype = quesjson.getString("type");
			String quesstem = quesjson.getString("stem");
			Boolean quesisMust = quesjson.getBoolean("isMust");
			if(questype.equals("Single")){
				List<String> options = (List)quesjson.getJSONArray("options").toList();
				MultipleChoice multi = new MultipleChoice(quesid,quesstem,questype,quesisMust,options,1,1);
				queslist.add(multi);
			}
			else if(questype.equals("Multiple")){
				List<String> options = (List)quesjson.getJSONArray("options").toList();
				int minopt=quesjson.getInt("minopt");
				int maxopt=quesjson.getInt("mmaxopt");
				MultipleChoice multi = new MultipleChoice(quesid,quesstem,questype,quesisMust,options,minopt,maxopt);
				queslist.add(multi);
			}
			else if(questype.equals("Subjective")){
				SubjectiveQuestion subjective = new SubjectiveQuestion(quesid,quesstem,quesisMust);
				queslist.add(subjective);
			}
			else if(questype.equals("UserInfo")){
				UserInfoBlank userinfo = new UserInfoBlank(quesid,quesstem,quesisMust);
				queslist.add(userinfo);
			}
		}
		return queslist;
	}
	
	public String addQuestionnaire(){
		if(status==null) status = "unp";
		Questionnaire ques = new Questionnaire(userid,title,status,isPublic,releaseTime,endTime);
		List<Question> queslist = parseQuestionList(questions);
		QuestionnaireQuestions quescontent = new QuestionnaireQuestions(id,queslist,introduction);
		quesService.addQuestionnaire(quescontent, ques);
		return null;
	}
	
	public String updateQuestionnaire(){
		Questionnaire ques = quesService.getQuestionnaireById(id);
		ques.setEndTime(endTime);
		ques.setIsPublic(isPublic);
		ques.setReleaseTime(releaseTime);
		ques.setStatus(status);
		ques.setTitle(title);
		List<Question> queslist = parseQuestionList(questions);
		QuestionnaireQuestions quescontent = quesService.getQuestionnaireQuestionsById(id);
		quescontent.setIntroduction(introduction);
		quescontent.setQuestions(queslist);
		quesService.updateQuestionnaire(quescontent, ques);
		return null;
	}
	
	public String deleteQuestionnaire(){
		Questionnaire ques = quesService.getQuestionnaireById(id);
		QuestionnaireQuestions quescontent = quesService.getQuestionnaireQuestionsById(id);
		quesService.deleteQuestionnaire(quescontent, ques);
		return null;
	}
	
	public String getQuestionnaireById(){
		Questionnaire ques = quesService.getQuestionnaireById(id);
		QuestionnaireQuestions quescontent = quesService.getQuestionnaireQuestionsById(id);
		request().setAttribute("quesinfo", ques);
		request().setAttribute("quescontent", quescontent);
		return null;
	}
	
	public String getAllQuestionnaire(){
		List<Questionnaire> questionnaires = quesService.getAllQuestionnaires();
		request().setAttribute("Questionnaires", questionnaires);
		return null;
	}
	
}
