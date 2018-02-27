package dao.impl;
import java.util.List;
import org.springframework.orm.hibernate3.support.HibernateDaoSupport;
import dao.LoginDao;
import model.User;
import assist.BCrypt;
public class LoginDaoImpl extends HibernateDaoSupport implements LoginDao{
	@Override
	public User login(String username, String password){
		List<User> u = (List<User>) this.getHibernateTemplate().find("from User where username=?", username);
	if(u.size()>0){
		User user = u.get(0);
		if(BCrypt.checkpw(password, user.getPassword())){
			return user;
		}
	}
	return null;
	}
}