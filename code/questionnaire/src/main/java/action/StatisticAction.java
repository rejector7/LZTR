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
		request().setAttribute("Qques", Qques);
		request().setAttribute("anst", anst);
		request().setAttribute("name", ques.getTitle());
		return "getQuesAndAns";
	}
	
	/**
	 * Get all answers of a specific questionnaire
	 * @return
	 * @throws IOException 
	 */
	public String getStatistic() throws IOException{
		JSONArray ansts = statisticService.getAnssheetsByQuesid(quesid);
		QuestionnaireQuestions Qques = quesService.getQuestionnaireQuestionsById(quesid);
		Questionnaire ques = quesService.getQuestionnaireById(quesid);
		JSONObject result = new JSONObject();
		result.put("question", new JSONObject(Qques.getContent())).put("answers", ansts).put("title", ques.getTitle());
		response().setCharacterEncoding("utf-8");
		response().setContentType("text/html;charset:utf-8");
		response().getWriter().print(result.toString());
		return null;
	}
}
