package service.impl;

import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.InputStream;
import java.util.List;

import org.json.JSONObject;

import dao.AnswerDao;
import dao.AnswerSheetDao;
import dao.QuestionnaireDao;
import dao.QuestionnaireQuestionsDao;
import model.Answer;
import model.AnswerSheet;
import model.Questionnaire;
import model.QuestionnaireQuestions;
import service.ImportExportService;

public class ImportExportServiceImpl implements ImportExportService {
	private QuestionnaireQuestionsDao questionnairequestionsDao;
	private QuestionnaireDao quesDao;
	private AnswerDao ansDao;
	private AnswerSheetDao anssheetDao;
	public void setQuestionnairequestionsDao(QuestionnaireQuestionsDao questionnairequestionsDao) {
		this.questionnairequestionsDao = questionnairequestionsDao;
	}
	public void setQuesDao(QuestionnaireDao quesDao) {
		this.quesDao = quesDao;
	}
	public void setAnsDao(AnswerDao ansDao) {
		this.ansDao = ansDao;
	}
	public void setAnssheetDao(AnswerSheetDao anssheetDao) {
		this.anssheetDao = anssheetDao;
	}
	/* (non-Javadoc)
	 * @see service.impl.ImportExportService#backup(int)
	 */
	@Override
	public String backupExport(int quesid){
		Questionnaire quesinfo = quesDao.getQuestionnaireById(quesid);
		QuestionnaireQuestions ques = questionnairequestionsDao.getQuestionnaireById(quesid);
		List<Answer> anss = ansDao.getAnswersByQuesId(quesid);
		JSONObject backup = new JSONObject();
		if(quesinfo!=null){
			backup.put("questionnaireinfo", quesinfo.toString());
		}
		if(ques!=null){
			backup.put("questionnairecontent", ques.getContent());
		}
		if(anss!=null&&(!anss.isEmpty())){
			for(Answer ans:anss){
				JSONObject ansfull = new JSONObject();
				ansfull.put("answerinfo", ans.toString());
				AnswerSheet anst = anssheetDao.getAnswerSheetById(ans.getId());
				if(anst!=null){
					ansfull.put("answerer",anst.getUserid());
					ansfull.put("answercontent", anst.getContent());
				}
				backup.append("answers", ansfull);
			}
		}
		else backup.append("answers", "null");
		return backup.toString();
	}
	
	public void backupImport(String url) throws FileNotFoundException{
		InputStream inputStream = new FileInputStream(url); 
		
	}
}
