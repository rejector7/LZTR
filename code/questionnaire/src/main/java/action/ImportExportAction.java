package action;
import java.io.File;
import java.io.IOException;
import java.text.ParseException;
import org.json.JSONException;
import service.ImportExportService;
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
		response().setCharacterEncoding("utf-8");
		response().setContentType("text/html;charset:utf-8");
		response().getWriter().print(backup);
		return null;
	}
	public String backupim() throws JSONException, IOException, ParseException{
		if(file==null)return null;
		ioService.backupImport(file.getPath());
		return "import";
	}
}
