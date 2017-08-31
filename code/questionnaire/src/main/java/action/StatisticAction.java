package action;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;

import org.json.JSONArray;
import org.json.JSONObject;

import model.Answer;
import model.AnswerSheet;
import model.Questionnaire;
import model.QuestionnaireQuestions;
import service.AnswerSheetService;
import service.QuestionnaireService;
import service.StatisticService;
/**
 * Action for statistic
 * @author LZTR
 *
 */
public class StatisticAction extends BaseAction{
	
	private static final long serialVersionUID = 1L;
	private int quesid;
	private int id;
	private StatisticService statisticService;
	private AnswerSheetService ansService;
	private QuestionnaireService quesService;
	
	public int getQuesid() {
		return quesid;
	}
	public void setQuesid(int quesid) {
		this.quesid = quesid;
	}
	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	public void setStatisticService(StatisticService statisticService) {
		this.statisticService = statisticService;
	}
	public void setAnsService(AnswerSheetService ansService) {
		this.ansService = ansService;
	}
	public void setQuesService(QuestionnaireService quesService) {
		this.quesService = quesService;
	}
	/**
	 * Get a specific answer with its information and content, along with the information and
	 * the content of the questionnaire it related to
	 * @return
	 * @throws IOException 
	 */
	public String getQuesAndAns() throws IOException{
		QuestionnaireQuestions Qques = quesService.getQuestionnaireQuestionsById(quesid);
		AnswerSheet anst = ansService.getAnswerSheetById(id);    //这个id是answer id，根据mysql的answer id去拿mongoDB中的answer sheet
		Questionnaire ques = quesService.getQuestionnaireById(quesid);
		JSONObject result = new JSONObject();
		result.put("Qques", new JSONObject(Qques.getContent()));
		result.put("anst", new JSONArray(anst.getContent()));
		result.put("name", ques.getTitle());
		result.put("userid", anst.getUserid());
		response().setCharacterEncoding("utf-8");
		response().setContentType("text/html;charset:utf-8");
		response().getWriter().print(result.toString());
		return null;
	}
	
	/**
	 * Get all answers of a specific questionnaire
	 * @return
	 * @throws IOException 
	 */
	public String get() throws IOException{
		JSONObject anss = statisticService.getAnssheetsByQuesid(quesid);
		QuestionnaireQuestions Qques = quesService.getQuestionnaireQuestionsById(quesid);
		Questionnaire ques = quesService.getQuestionnaireById(quesid);
		JSONObject result = new JSONObject();
		result.put("question", new JSONObject(Qques.getContent())).put("answers", anss.getJSONArray("contents")).put("title", ques.getTitle()).put("ids", anss.getJSONArray("ids"));
		response().setCharacterEncoding("utf-8");
		response().setContentType("text/html;charset:utf-8");
		response().getWriter().print(result.toString());
		return null;
	}
}
