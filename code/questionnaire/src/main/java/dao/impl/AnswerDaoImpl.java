package dao.impl;

import java.util.List;

import org.springframework.orm.hibernate3.support.HibernateDaoSupport;

import dao.AnswerDao;
import model.Answer;
import model.Questionnaire;

public class AnswerDaoImpl extends HibernateDaoSupport implements AnswerDao {
	/* (non-Javadoc)
	 * @see dao.impl.AnswerDao#addAnswer(model.Answer)
	 */
	@Override
	public Integer addAnswer(Answer ans) {
		return (Integer)getHibernateTemplate().save(ans);
	}
	
	/* (non-Javadoc)
	 * @see dao.impl.AnswerDao#updateAnswer(model.Answer)
	 */
	@Override
	public void updateAnswer(Answer ans) {
		getHibernateTemplate().merge(ans);
	}
	
	/* (non-Javadoc)
	 * @see dao.impl.AnswerDao#deleteAnswer(model.Answer)
	 */
	@Override
	public void deleteAnswer(Answer ans){
		getHibernateTemplate().delete(ans);
	}
	
	/* (non-Javadoc)
	 * @see dao.impl.AnswerDao#getAnswerById(int)
	 */
	@Override
	public Answer getAnswerById(int id){
		List<Answer> anss = (List<Answer>)getHibernateTemplate()
				.find("from Answer as a where a.id=?",id);
		Answer ans = anss.size() > 0 ? anss.get(0) : null;
		return ans;
	}
	
	/* (non-Javadoc)
	 * @see dao.impl.AnswerDao#getAnswersByQuesId(int)
	 */
	@Override
	public List<Answer> getAnswersByQuesId(int quesid){
		return (List<Answer>)getHibernateTemplate()
				.find("from Answer as a where a.quesid=?",quesid);
	}
	
	@Override
	public List<Answer> getAnswersByIp(String ip,int quesid){
		return (List<Answer>)getHibernateTemplate()
				.find("from Answer as a where a.ip=? and a.quesid=?",ip,quesid);
	}
}
