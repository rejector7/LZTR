package dao.impl;

import java.util.List;

import org.springframework.orm.hibernate3.support.HibernateDaoSupport;

import dao.UserDao;
import model.User;

public class UserDaoImpl extends HibernateDaoSupport implements UserDao {

	/* (non-Javadoc)
	 * @see dao.impl.UserDao#addUser(model.User)
	 */
	@Override
	public Integer addUser(User user) {
		return (Integer) getHibernateTemplate().save(user);
	}

	/* (non-Javadoc)
	 * @see dao.impl.UserDao#deleteUser(model.User)
	 */
	@Override
	public void deleteUser(User user) {
		getHibernateTemplate().delete(user);
	}

	/* (non-Javadoc)
	 * @see dao.impl.UserDao#updateUser(model.User)
	 */
	@Override
	public void updateUser(User user) {
		getHibernateTemplate().merge(user);
	}

	/* (non-Javadoc)
	 * @see dao.impl.UserDao#getUserById(int)
	 */
	@Override
	public User getUserById(int id) {
		@SuppressWarnings("unchecked")
		List<User> users = (List<User>) getHibernateTemplate().find(
				"from User as u where u.id=?", id);
		User user = users.size() > 0 ? users.get(0) : null;
		return user;
	}

	/* (non-Javadoc)
	 * @see dao.impl.UserDao#getAllUsers()
	 */
	@Override
	public List<User> getAllUsers() {
		@SuppressWarnings("unchecked")
		List<User> users = (List<User>) getHibernateTemplate()
				.find("from User");
		return users;
	}

	/* (non-Javadoc)
	 * @see dao.impl.UserDao#getUserByUsername(java.lang.String)
	 */
	@Override
	public List<User> getUserByUsername(String name){
		System.out.println("here in dao");
		@SuppressWarnings("unchecked")
		
		List<User> users = (List<User>) getHibernateTemplate()
				.find("from User as u where u.username=?",name);
		System.out.println("usersize");
		if(users.size() == 0)return null;
		System.out.println("succeed here in dao");
		return users;
	}
}
