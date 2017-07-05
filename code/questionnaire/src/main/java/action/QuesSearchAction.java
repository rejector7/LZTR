package action;

import java.sql.Date;
import java.util.List;

import model.Questionnaire;
import service.QuestionnaireService;

public class QuesSearchAction extends BaseAction{
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	
	private QuestionnaireService quesService;
	private String condi;
	
	public void setCondi(String condi){
		this.condi = condi;
	}
	public String getCondi(){
		return this.condi;
	}
	
	public void setQuestionnaireService(QuestionnaireService quesService) {
		this.quesService = quesService;
	}
	
	public String execute() throws Exception{
		List<Questionnaire> Questionnaires = quesService.findQuestionnaires(condi);
		request().setAttribute("ResultList", Questionnaires);
		return SUCCESS;
	}

}