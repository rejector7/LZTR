package dao.impl;
import java.util.List;
import org.springframework.data.mongodb.core.MongoTemplate;
import org.springframework.data.mongodb.core.query.Criteria;
import org.springframework.data.mongodb.core.query.Query;
import org.springframework.data.mongodb.core.query.Update;
import model.AnswerSheet;
import dao.AnswerSheetDao;
public class AnswerSheetDaoImpl implements AnswerSheetDao {
	MongoTemplate mongoTemplate;
	public void setMongoTemplate(MongoTemplate mongoTemplate) {
		this.mongoTemplate = mongoTemplate;
	}
	/* (non-Javadoc)
	 * @see dao.impl.AnswerSheet#addAnswerSheet(model.AnswerSheet)
	 */
	@Override
	public void addAnswerSheet(AnswerSheet ans){
		mongoTemplate.save(ans);
	}
	/* (non-Javadoc)
	 * @see dao.impl.AnswerSheet#deleteAnswerSheet(model.AnswerSheet)
	 */
	@Override
	public void deleteAnswerSheet(AnswerSheet ans){
		mongoTemplate.remove(ans);
	}
	/* (non-Javadoc)
	 * @see dao.impl.AnswerSheet#updateAnswerSheet(model.AnswerSheet)
	 */
	@Override
	public void updateAnswerSheet(AnswerSheet ans){
		Criteria criteria = Criteria.where("answerid").is(ans.getAnswerid());
	      Query query = new Query(criteria);
	      Update update = new Update().set("answerid", ans.getAnswerid());
	      update.set("content",ans.getContent());
	      mongoTemplate.updateFirst(query, update, AnswerSheet.class);
	}
	/* (non-Javadoc)
	 * @see dao.impl.AnswerSheet#getAnswerSheetById(int)
	 */
	@Override
	public AnswerSheet getAnswerSheetById(int id){
		Criteria criteria = Criteria.where("answerid").is(id);
	      Query query = new Query(criteria);
	      List<AnswerSheet> anss = mongoTemplate.find(query, AnswerSheet.class);
	      if(!(anss==null||anss.isEmpty())){
	    	  return anss.get(0);
	      }
	      else{
	    	  return null;
	      }
	}
}
