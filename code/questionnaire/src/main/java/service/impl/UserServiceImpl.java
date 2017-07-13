package service.impl;

import java.util.List;


import dao.UserDao;
import model.User;
import service.UserService;

public class UserServiceImpl implements UserService {
	
	private UserDao userDao;
	
	/* (non-Javadoc)
	 * @see service.impl.UserService#setUserDao(dao.UserDao)
	 */
	@Override
	public void setUserDao(UserDao userDao) {
		this.userDao = userDao;
	}
	
	/* (non-Javadoc)
	 * @see service.impl.UserService#addUser(model.User)
	 */
	@Override
	public Integer addUser(User user) {
		return userDao.addUser(user);
	}

	/* (non-Javadoc)
	 * @see service.impl.UserService#deleteUser(model.User)
	 */
	@Override
	public void deleteUser(User user) {
		userDao.deleteUser(user);
	}

	/* (non-Javadoc)
	 * @see service.impl.UserService#updateUser(model.User)
	 */
	@Override
	public void updateUser(User user) {
		userDao.updateUser(user);
	}

	/* (non-Javadoc)
	 * @see service.impl.UserService#getUserById(int)
	 */
	@Override
	public User getUserById(int id) {
		return userDao.getUserById(id);
	}

	/* (non-Javadoc)
	 * @see service.impl.UserService#getAllUsers()
	 */
	@Override
	public List<User> getAllUsers() {
		return userDao.getAllUsers();
	}

	/* (non-Javadoc)
	 * @see service.impl.UserService#getUserByName(java.lang.String)
	 */
	@Override
	public List<User> getUserByName(String name){
		return userDao.getUserByUsername(name);
	}
	/* (non-Javadoc)
	 * @see service.impl.QuestionnaireService#findQuestionnaires(Sting condi)
	 */
	@Override
	public List<User> findUsers(String condi){
		return userDao.findUsers(condi);
	}
}