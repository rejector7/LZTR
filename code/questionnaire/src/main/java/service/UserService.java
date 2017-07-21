package service;

import java.util.List;

import javax.mail.MessagingException;
import javax.mail.internet.AddressException;

import dao.UserDao;
import model.User;

public interface UserService {

	void setUserDao(UserDao userDao);

	Integer addUser(User user);

	void deleteUser(User user);

	void updateUser(User user);

	User getUserById(int id);

	List<User> getAllUsers();

	List<User> getUserByName(String name);
	
	List<User> findUsers(String condi);
	
	User getUserByEmail(String email);
	
	User activateMail(User user) throws AddressException, MessagingException;
	
	void sendMail(String to, String title, String content)throws AddressException, MessagingException;

}