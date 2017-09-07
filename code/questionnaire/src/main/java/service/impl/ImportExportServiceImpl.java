package service.impl;

import java.io.BufferedReader;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.io.UnsupportedEncodingException;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

import org.json.JSONArray;
import org.json.JSONException;
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
		JSONArray allbackup = new JSONArray();
		allbackup.put(quesid);
		if(quesid==0){
			List<Questionnaire> quesinfos = quesDao.getAllQuestionnaires();
			for(Questionnaire quesinfo:quesinfos){
				int id = quesinfo.getId();
				JSONObject backup = new JSONObject();
				QuestionnaireQuestions ques = questionnairequestionsDao.getQuestionnaireById(id);
				List<Answer> anss = ansDao.getAnswersByQuesId(id);
				backup.put("quesinfo", quesinfo);
				if(ques!=null){
					backup.put("ques", ques.getContent());
				}
				if(anss!=null&&(!anss.isEmpty())){
					for(Answer ans:anss){
						JSONObject ansfull = new JSONObject();
						ansfull.put("ansinfo", ans);
						AnswerSheet anst = anssheetDao.getAnswerSheetById(ans.getId());
						if(anst!=null){
							ansfull.put("anser",anst.getUserid());
							ansfull.put("ans", anst.getContent());
						}
						backup.append("anss", ansfull);
					}
				}
				else backup.append("anss", "null");
				allbackup.put(backup);
			}
			return allbackup.toString();
		}
		Questionnaire quesinfo = quesDao.getQuestionnaireById(quesid);
		QuestionnaireQuestions ques = questionnairequestionsDao.getQuestionnaireById(quesid);
		List<Answer> anss = ansDao.getAnswersByQuesId(quesid);
		JSONObject backup = new JSONObject();
		if(quesinfo!=null){
			backup.put("quesinfo", quesinfo.toString());
		}
		if(ques!=null){
			backup.put("ques", ques.getContent());
		}
		if(anss!=null&&(!anss.isEmpty())){
			for(Answer ans:anss){
				JSONObject ansfull = new JSONObject();
				ansfull.put("ansinfo", ans.toString());
				AnswerSheet anst = anssheetDao.getAnswerSheetById(ans.getId());
				if(anst!=null){
					ansfull.put("anser",anst.getUserid());
					ansfull.put("ans", anst.getContent());
				}
				backup.append("anss", ansfull);
			}
		}
		else backup.append("anss", "null");
		allbackup.put(backup);
		return allbackup.toString();
	}
	
	public void parseAndStore(JSONObject sbu) throws JSONException, ParseException{
		JSONObject qninfoj = new JSONObject(sbu.getString("quesinfo"));
    	String qnj = sbu.getString("ques");
    	int newid = qninfoj.getInt("id");
    	if(quesDao.getQuestionnaireById(newid)==null){
        	Questionnaire qninfo = new Questionnaire();
        	qninfo.setId(newid);
        	qninfo.setTitle(qninfoj.getString("title"));
        	qninfo.setUserid(qninfoj.getInt("userid"));
        	qninfo.setIsPublic(qninfoj.getInt("isPublic"));
        	if(!qninfoj.getString("releaseTime").equals("null")){
        		Date releaseTime = new SimpleDateFormat("yyyy-MM-dd KK:mm:ss").parse(qninfoj.getString("releaseTime"));
        		qninfo.setReleaseTime(releaseTime);
        	}
        	if(!qninfoj.getString("endTime").equals("null")){
        		Date endTime = new SimpleDateFormat("yyyy-MM-dd KK:mm:ss").parse(qninfoj.getString("releaseTime"));
        		qninfo.setEndTime(endTime);
        	}
        	qninfo.setStatus(qninfoj.getString("status"));
        	newid = quesDao.addQuestionnaire(qninfo);
    	}
    	else{
    		Questionnaire qninfo = quesDao.getQuestionnaireById(newid);
        	qninfo.setId(newid);
        	qninfo.setTitle(qninfoj.getString("title"));
        	qninfo.setUserid(qninfoj.getInt("userid"));
        	qninfo.setIsPublic(qninfoj.getInt("isPublic"));
        	if(!qninfoj.getString("releaseTime").equals("null")){
        		Date releaseTime = new SimpleDateFormat("yyyy-MM-dd KK:mm:ss").parse(qninfoj.getString("releaseTime"));
        		qninfo.setReleaseTime(releaseTime);
        	}
        	if(!qninfoj.getString("endTime").equals("null")){
        		Date endTime = new SimpleDateFormat("yyyy-MM-dd KK:mm:ss").parse(qninfoj.getString("releaseTime"));
        		qninfo.setEndTime(endTime);
        	}
        	qninfo.setStatus(qninfoj.getString("status"));
        	quesDao.updateQuestionnaire(qninfo);
    	}
    	if(questionnairequestionsDao.getQuestionnaireById(newid)==null){
    		QuestionnaireQuestions qn = new QuestionnaireQuestions();
        	qn.setContent(qnj);
        	qn.setQuesid(newid);
        	questionnairequestionsDao.addQuestionnaire(qn);
    	}
    	else{
    		QuestionnaireQuestions qn = questionnairequestionsDao.getQuestionnaireById(qninfoj.getInt("id"));
        	qn.setQuesid(newid);
        	qn.setContent(qnj);
        	questionnairequestionsDao.updateQuestionnaire(qn);
    	}
    	JSONArray answers = sbu.getJSONArray("anss");
    	if(answers.get(0).equals("null")){
    		return;
    	}
    	for(int i=0;i<answers.length();i++){
    		JSONObject ans = answers.getJSONObject(i);
    		JSONObject ansinfo = new JSONObject(ans.getString("ansinfo"));
    		Answer aninfo = new Answer();
    		AnswerSheet ansheet = new AnswerSheet();
    		int ansnewid = ansinfo.getInt("id");
    		if(ansDao.getAnswerById(ansinfo.getInt("id"))==null){
    			aninfo.setIp(ansinfo.getString("ip"));
        		aninfo.setQuesid(newid);
        		Date time = new SimpleDateFormat("yyyy-MM-dd KK:mm:ss").parse(ansinfo.getString("time"));
        		aninfo.setTime(time);
        		ansnewid = ansDao.addAnswer(aninfo);
    		}
    		else{
    			aninfo = ansDao.getAnswerById(ansinfo.getInt("id"));
    			aninfo.setIp(ansinfo.getString("ip"));
        		aninfo.setQuesid(newid);
        		Date time = new SimpleDateFormat("yyyy-MM-dd KK:mm:ss").parse(ansinfo.getString("time"));
        		aninfo.setTime(time);
        		ansDao.updateAnswer(aninfo);
    		}
    		if(anssheetDao.getAnswerSheetById(ansinfo.getInt("id"))==null){
    			ansheet.setAnswerid(ansnewid);
        		ansheet.setUserid(ans.getInt("anser"));
        		ansheet.setContent(ans.getString("ans"));
        		anssheetDao.addAnswerSheet(ansheet);
    		}
    		else{
    			ansheet.setAnswerid(ansnewid);
        		ansheet.setUserid(ans.getInt("anser"));
        		ansheet.setContent(ans.getString("ans"));
        		anssheetDao.updateAnswerSheet(ansheet);
    		}
    	}
	}
	
	
	@Override
	public void backupImport(String url) throws IOException, JSONException, ParseException{
		InputStream in = new FileInputStream(url); 
		BufferedReader bf=new BufferedReader(new InputStreamReader(in,"UTF-8"));
		StringBuffer buffer=new StringBuffer();  
	     String line="";  
	     while((line=bf.readLine())!=null){  
	         buffer.append(line);  
	     }
	    JSONArray backup = new JSONArray(buffer.toString());
	    if(backup.getInt(0)==0){
	    	int len = backup.length();
	    	for(int i=1;i<len;i++){
	    		parseAndStore(backup.getJSONObject(i));
	    	}
	    }
	    else {
	    	JSONObject sbu = backup.getJSONObject(1);
	    	parseAndStore(sbu);
	    }
	}
}
