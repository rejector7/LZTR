package service.impl;
import java.util.List;
import dao.AnswerDao;
import dao.AnswerSheetDao;
import model.Answer;
import model.AnswerSheet;
import service.AnswerSheetService;
public class AnswerSheetServiceImpl implements AnswerSheetService {
	private AnswerDao ansDao;
	private AnswerSheetDao anssheetDao;
	public void setAnsDao(AnswerDao ansDao) {
		this.ansDao = ansDao;
	}
	public void setAnssheetDao(AnswerSheetDao anssheetDao) {
		this.anssheetDao = anssheetDao;
	}
	/* (non-Javadoc)
	 * @see service.impl.AnswerSheetService#saveAnswer(model.Answer, model.AnswerSheet)
	 */
	@Override
	public void addAnswer(Answer ans, AnswerSheet anst){
		int id = ansDao.addAnswer(ans);
		anst.setAnswerid(id);
		anssheetDao.addAnswerSheet(anst);
	}
	/* (non-Javadoc)
	 * @see service.impl.AnswerSheetService#updateAnswer(model.Answer, model.AnswerSheet)
	 */
	@Override
	public void updateAnswer(Answer ans, AnswerSheet anst){
		ansDao.updateAnswer(ans);
		anssheetDao.updateAnswerSheet(anst);
	}
	/* (non-Javadoc)
	 * @see service.impl.AnswerSheetService#deleteAnswer(model.Answer, model.AnswerSheet)
	 */
	@Override
	public void deleteAnswer(Answer ans, AnswerSheet anst){
		ansDao.deleteAnswer(ans);
		anssheetDao.deleteAnswerSheet(anst);
	}
	/* (non-Javadoc)
	 * @see service.impl.AnswerSheetService#getAnswerById(int)
	 */
	@Override
	public Answer getAnswerById(int id){
		return ansDao.getAnswerById(id);
	}
	/* (non-Javadoc)
	 * @see service.impl.AnswerSheetService#getAnswerSheetById(int)
	 */
	@Override
	public AnswerSheet getAnswerSheetById(int id){
		return anssheetDao.getAnswerSheetById(id);
	}
	/* (non-Javadoc)
	 * @see service.impl.AnswerSheetService#getAnswerByQuestion(int)
	 */
	@Override
	public List<Answer> getAnswerByQuestion(int quesid){
		return ansDao.getAnswersByQuesId(quesid);
	}
	@Override
	public void deleteAnswersByQuestionId(int quesid){
		List<Answer> anss= ansDao.getAnswersByQuesId(quesid);
		if(anss==null||anss.size()==0)return;
		for(Answer ans:anss){
			AnswerSheet anst = anssheetDao.getAnswerSheetById(ans.getId());	
			deleteAnswer(ans, anst);
		}
	}
	@Override
	public List<Answer> getAnswersByIp(String ip,int quesid){
		return ansDao.getAnswersByIp(ip,quesid);
	}
}
