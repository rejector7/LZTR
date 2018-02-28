package dao.impl;
import java.util.List;
import org.springframework.orm.hibernate3.support.HibernateDaoSupport;
import dao.QuestionnaireDao;
import model.Questionnaire;
import model.User;
import java.util.ArrayList;
public class QuestionnaireDaoImpl extends HibernateDaoSupport implements QuestionnaireDao{
	/* (non-Javadoc)
	 * @see dao.impl.QuestionnaireDao#addQuestionnaire(model.Questionnaire)
	 */
	@Override
	public Integer addQuestionnaire(Questionnaire ques) {
		return (Integer)getHibernateTemplate().save(ques);
	}
	/* (non-Javadoc)
	 * @see dao.impl.QuestionnaireDao#deleteQuestionnaire(model.Questionnaire)
	 */
	@Override
	public void deleteQuestionnaire(Questionnaire ques) {
		getHibernateTemplate().delete(ques);
	}
	/* (non-Javadoc)
	 * @see dao.impl.QuestionnaireDao#updateQuestionnaire(model.Questionnaire)
	 */
	@Override
	public void updateQuestionnaire(Questionnaire ques) {
		getHibernateTemplate().merge(ques);
	}
	/* (non-Javadoc)
	 * @see dao.impl.QuestionnaireDao#updateQuestionnaire(model.Questionnaire)
	 */
	@Override
	public void copyQuestionnaire(int id) {
		Questionnaire ques = getQuestionnaireById(id);
		ques.setId(0);
		ques.setTitle(ques.getTitle() + "_副本");
		ques.setStatus("unp");
		ques.setReleaseTime(null);
		ques.setEndTime(null);
		addQuestionnaire(ques);
	}
	/* (non-Javadoc)
	 * @see dao.impl.QuestionnaireDao#getQuestionnaireById(int)
	 */
	@Override
	public Questionnaire getQuestionnaireById(int id) {
		@SuppressWarnings("unchecked")
		List<Questionnaire> quess = (List<Questionnaire>) getHibernateTemplate().find(
				"from Questionnaire as q where q.id=?", id);
		Questionnaire ques = quess.size() > 0 ? quess.get(0) : null;
		return ques;
	}
	/* (non-Javadoc)
	 * @see dao.impl.QuestionnaireDao#getAllQuestionnaires()
	 */
	@Override
	public List<Questionnaire> getAllQuestionnaires() {
		@SuppressWarnings("unchecked")
		List<Questionnaire> quess = (List<Questionnaire>) getHibernateTemplate()
				.find("from Questionnaire");
		return quess;
	}
	@Override
	public List<Questionnaire> getQuestionnairesByUserid(int userid) {
		@SuppressWarnings("unchecked")
		List<Questionnaire> quess = (List<Questionnaire>) getHibernateTemplate()
				.find("from Questionnaire as q where q.userid=?", userid);
		return quess;
	}
	/* (non-Javadoc)
	 * @see dao.impl.QuestionnaireDao#findQuestionnaires(String condi)
	 */
	@Override
	public List<Questionnaire> findQuestionnaires(String condi){
		@SuppressWarnings("unchecked")
		List<Questionnaire> quess  = (List<Questionnaire>) getHibernateTemplate()
				.find("from Questionnaire as q where q.title LIKE ?",'%'+condi+'%');
		return quess;
	}
	@Override
	public List<Questionnaire> getPublicQuestionnaires(){
		@SuppressWarnings("unchecked")
		List<Questionnaire> quess  = (List<Questionnaire>) getHibernateTemplate()
				.find("from Questionnaire as q where q.isPublic=1 and status='pub' order by releaseTime desc");
		return quess;
	}
	@Override
	public List<Questionnaire> getPublicResults(){
		@SuppressWarnings("unchecked")
		List<Questionnaire> quess  = (List<Questionnaire>) getHibernateTemplate()
				.find("from Questionnaire as q where q.result='public' and status='pub' order by releaseTime desc");
		return quess;
	}
	
	public List<Questionnaire> getTemplateQuestionnaires(){
		@SuppressWarnings("unchecked")
		List<User> admins = (List<User>) getHibernateTemplate().find("from User as u where u.role = 'admin'");
		int len = admins.size();
		int userid;
		List<Questionnaire> templates = new ArrayList();
		for(int i=0;i<len;i++){
			userid = admins.get(i).getId();
			List<Questionnaire> quess  = (List<Questionnaire>) getHibernateTemplate()
					.find("from Questionnaire as q where q.userid=?", userid);
			templates.addAll(quess);
		}
		return templates;
	}
}
