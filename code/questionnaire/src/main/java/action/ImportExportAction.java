package action;

import java.io.File;
import java.io.FileNotFoundException;
import java.io.IOException;
import java.text.ParseException;
import java.util.List;

import org.json.JSONException;
import org.json.JSONObject;

import model.Answer;
import model.AnswerSheet;
import model.Questionnaire;
import model.QuestionnaireQuestions;
import service.AnswerSheetService;
import service.ImportExportService;
import service.QuestionnaireService;

public class ImportExportAction extends BaseAction{

	private static final long serialVersionUID = 1L;
	private int ansid;
	private int quesid;
	private File file;
	private ImportExportService ioService;
	public int getAnsid() {
		return ansid;
	}
	public void setAnsid(int ansid) {
		this.ansid = ansid;
	}
	public int getQuesid() {
		return quesid;
	}
	public void setQuesid(int quesid) {
		this.quesid = quesid;
	}
	public File getFile() {
		return file;
	}
	public void setFile(File file) {
		this.file = file;
	}
	public void setIoService(ImportExportService ioService) {
		this.ioService = ioService;
	}
	public String backupex() throws IOException{
		String backup = ioService.backupExport(quesid);
		System.out.println(backup);
		response().getWriter().print(backup);
		return null;
	}
	
	public String backupim() throws JSONException, IOException, ParseException{
		ioService.backupImport(file.getPath());
		return null;
	}
}
