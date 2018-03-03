package action;
import service.AnswerSheetService;
import service.QuestionnaireService;
import java.io.IOException;
import java.net.URLDecoder;
import java.util.Date;
import java.util.List;
import org.json.JSONObject;
import model.User;
import model.Questionnaire;
import model.QuestionnaireQuestions;
public class QuestionnaireAction extends BaseAction{
	private AnswerSheetService ansService;
	private QuestionnaireService quesService;
	private int id;
	private int userid;
	private String title;
	private String status; 		/* unp(default), pub, end, or ban */
	private int isPublic;    	/* 1(default) or 0 */
	private Date releaseTime;
	private Date endTime;
	private String condi;
	private String content;
	private int allowDup;
	private String result;
	public String getContent() {
		return content;
	}
	public void setContent(String content) {
		this.content = content;
	}
	public String getCondi() {
		return condi;
	}
	public void setCondi(String condi) {
		this.condi = condi;
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
	public String getStatus() {
		return status;
	}
	public void setStatus(String status) {
		this.status = status;
	}
	public String getTitle() {
		return title;
	}
	public void setTitle(String title) {
		this.title = title;
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
	public int getAllowDup() {
		return allowDup;
	}
	public void setAllowDup(int allowDup) {
		this.allowDup = allowDup;
	}
	public void setQuesService(QuestionnaireService quesService) {
		this.quesService = quesService;
	}
	public void setAnsService(AnswerSheetService ansService) {
		this.ansService = ansService;
	}
	/**
	 * Use Service to add a questionnaire,including its basic information and content
	 * @return
	 * @throws IOException 
	 */
	public String add() throws IOException{
		content =  URLDecoder.decode(content, "UTF-8");
		content =  URLDecoder.decode(content, "UTF-8");
		title =  URLDecoder.decode(title, "UTF-8");
		title =  URLDecoder.decode(title, "UTF-8");
		if(id!=0){
			Questionnaire ques = quesService.getQuestionnaireById(id);
			QuestionnaireQuestions quescontent = quesService.getQuestionnaireQuestionsById(id);
			if(ques.getStatus().equals("pub")||ques.getStatus().equals("end")){
				ansService.deleteAnswersByQuestionId(id);
			}
			if(status!=null){
				ques.setEndTime(endTime);
				ques.setIsPublic(isPublic);
				ques.setReleaseTime(releaseTime);
				ques.setStatus(status);
			}
			ques.setTitle(title);
			quescontent.setContent(content);
			ques.setAllowDup(allowDup);
			ques.setResult(result);
			User user = (User)session().getAttribute("user");
			if(user.getRole()=="admin"){
				ques.setStatus("end");
				ques.setIsPublic(0);
				ques.setResult("private");
			}
			quesService.updateQuestionnaire(quescontent, ques);
			response().getWriter().write(Integer.valueOf(id).toString());
			return null;
		}
		if(status==null) status = "unp";
		int userid = ((User)request().getSession().getAttribute("user")).getId();
		Questionnaire ques = new Questionnaire(userid,status,title,isPublic,result,releaseTime,endTime,allowDup);
		User user = (User)session().getAttribute("user");
		if(user.getRole()=="admin"){
			ques.setStatus("end");
			ques.setIsPublic(0);
			ques.setResult("private");
		}
		QuestionnaireQuestions quescontent = new QuestionnaireQuestions(content);
		int tmpid = quesService.addQuestionnaire(quescontent, ques);
		response().getWriter().write(Integer.valueOf(tmpid).toString());
		return null;
	}
	public String update() throws IOException {
		Questionnaire ques = quesService.getQuestionnaireById(id);
		if(ques.getStatus().equals("ban")){
			response().getWriter().print("success");
			return null;
		}
		ques.setEndTime(endTime);
		ques.setIsPublic(isPublic);
		ques.setReleaseTime(releaseTime);
		ques.setStatus(status);
		ques.setAllowDup(allowDup);
		ques.setResult(result);
		User user = (User)session().getAttribute("user");
		if(user.getRole()=="admin"){
			ques.setStatus("end");
			ques.setIsPublic(0);
			ques.setResult("private");
		}
		quesService.updateQuestionnaire(ques);
		response().getWriter().print("success");
		return null;
	}
	public String updateStatus() throws Exception {
		User user = (User)session().getAttribute("user");
		if(user.getRole()=="admin"){
			return "updateStatus";
		}
		Questionnaire ques = quesService.getQuestionnaireById(id);
		ques.setStatus(status);
		quesService.updateQuestionnaire(ques);
		return "updateStatus";
	}
	/**
	 * Use Service to delete a questionnaire,including its basic information and content
	 * @return
	 */
	public String delete1(){
		ansService.deleteAnswersByQuestionId(id);
		Questionnaire ques = quesService.getQuestionnaireById(id);
		QuestionnaireQuestions quescontent = quesService.getQuestionnaireQuestionsById(id);
		quesService.deleteQuestionnaire(quescontent, ques);
		return "delete1";
	}
	public String delete2(){
		ansService.deleteAnswersByQuestionId(id);
		Questionnaire ques = quesService.getQuestionnaireById(id);
		QuestionnaireQuestions quescontent = quesService.getQuestionnaireQuestionsById(id);
		quesService.deleteQuestionnaire(quescontent, ques);
		return "delete2";
	}
	/**
	 * Use Service to get a questionnaire,including its basic information and content
	 * @return
	 * @throws IOException 
	 */
	public String get() throws IOException{
		Questionnaire ques = quesService.getQuestionnaireById(id);
		if(ques==null){
			JSONObject questot = new JSONObject();
			questot.put("status", "notexist");
			response().getWriter().print(questot);
			return null;
		}
		if(status!=null&&status.equals("need")){
			if(!ques.getStatus().equals("pub")){
				JSONObject questot = new JSONObject();
				questot.put("status", "notpub");
				response().getWriter().print(questot);
				return null;
			}
		}
		QuestionnaireQuestions quescontent = quesService.getQuestionnaireQuestionsById(id);
		JSONObject questot = new JSONObject(quescontent.getContent());
		questot.put("title", ques.getTitle());
		questot.put("allowdup", ques.getAllowDup());
		questot.put("status", "pub");
		questot.put("result", ques.getResult());
		response().setCharacterEncoding("utf-8");
		response().setContentType("text/html;charset:utf-8");
		response().getWriter().print(questot.toString());
		return null;
	}
	public String getInfo() throws IOException{
		Questionnaire ques = quesService.getQuestionnaireById(id);
		request().setAttribute("quesinfo", ques);
		return "getInfo";
	}
	public String CopyTemplate() throws IOException{
		User user = (User)session().getAttribute("user");
		Questionnaire ques = quesService.copyTemplate(id,user.getId());
		request().setAttribute("id", ques.getId());
		JSONObject q = new JSONObject();
		q.put("quesid", ques.getId());
		response().getWriter().print(q);
		return null;
	}
	/**
	 * Use Service to get basic information of all questionnaires
	 * @return
	 */
	public String all(){
		List<Questionnaire> questionnaires = quesService.getAllQuestionnaires();
		request().setAttribute("Questionnaires", questionnaires);
		return "all";
	}
	public String search() throws Exception{
		List<Questionnaire> Questionnaires = quesService.findQuestionnaires(condi);
		request().setAttribute("ResultList", Questionnaires);
		return "search";
	}
	public String My() throws Exception{
		User user = (User)session().getAttribute("user");
		int userid = user.getId();
		List<Questionnaire> Questionnaires = quesService.getQuestionnaireByUserId(userid);
		request().setAttribute("MyQuess", Questionnaires);
		return "My";
	}
	public String copy() {
		quesService.copyQuestionnaire(id);
		return "copy";
	}
	public String propel(){
		List<Questionnaire> questionnaires = quesService.getPublicQuestionnaires();
		if(questionnaires.size()>=6){
		for(int i=0;i<6;i++){
			QuestionnaireQuestions quescontent = quesService.getQuestionnaireQuestionsById(questionnaires.get(i).getId());
			JSONObject questot = new JSONObject(quescontent.getContent());
			String intro = questot.getString("introduction");
			request().setAttribute(i + "intro", intro);
		}
		}
		else {
			for(int i=0;i<questionnaires.size();i++){
				QuestionnaireQuestions quescontent = quesService.getQuestionnaireQuestionsById(questionnaires.get(i).getId());
				JSONObject questot = new JSONObject(quescontent.getContent());
				String intro = questot.getString("introduction");
				request().setAttribute(i + "intro", intro);
			}
		}
		request().setAttribute("quesByTime", questionnaires);
		
		List<Questionnaire> results = quesService.getPublicResults();
		if(results.size()>=6){
		for(int i=0;i<6;i++){
			QuestionnaireQuestions quescontent = quesService.getQuestionnaireQuestionsById(results.get(i).getId());
			JSONObject questot = new JSONObject(quescontent.getContent());
			String intro = questot.getString("introduction");
			request().setAttribute(i + "intro1", intro);
		}
		}
		else {
			for(int i=0;i<results.size();i++){
				QuestionnaireQuestions quescontent = quesService.getQuestionnaireQuestionsById(results.get(i).getId());
				JSONObject questot = new JSONObject(quescontent.getContent());
				String intro = questot.getString("introduction");
				request().setAttribute(i + "intro1", intro);
			}
		}
		request().setAttribute("resultByTime", results);
		
		List<Questionnaire> templates = quesService.getTemplateQuestionnaires();
		if(templates.size()>=6){
		for(int i=0;i<6;i++){
			QuestionnaireQuestions quescontent = quesService.getQuestionnaireQuestionsById(templates.get(i).getId());
			JSONObject questot = new JSONObject(quescontent.getContent());
			String intro = questot.getString("introduction");
			request().setAttribute(i + "intro2", intro);
		}
		}
		else {
			for(int i=0;i<templates.size();i++){
				QuestionnaireQuestions quescontent = quesService.getQuestionnaireQuestionsById(templates.get(i).getId());
				if(quescontent!=null){
					JSONObject questot = new JSONObject(quescontent.getContent());
					String intro = questot.getString("introduction");
					request().setAttribute(i + "intro", intro);
				}
			}
		}
		request().setAttribute("templateByTime", templates);
		
		return SUCCESS;
	}
	public String getResult() {
		return result;
	}
	public void setResult(String result) {
		this.result = result;
	}
}
