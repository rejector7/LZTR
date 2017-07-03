package dao.impl;

import java.util.List;

import org.apache.catalina.connector.Request;
import org.springframework.orm.hibernate3.support.HibernateDaoSupport;

import dao.LoginDao;
import model.User;

public class LoginDaoImpl extends HibernateDaoSupport implements LoginDao{
	@Override
	public User login(String username, String password){
		List<User> u = (List<User>) this.getHibernateTemplate().find("from User where username=? and password=?", username, password);
		System.out.println(username);
		System.out.println("usersize" + u.size());
	if(u.size()>0){
		return u.get(0);
	}
	return null;
	}
}