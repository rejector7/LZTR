package service.impl;

import java.util.Date;
import java.util.List;
import java.util.Properties;

import javax.mail.Message;
import javax.mail.MessagingException;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.AddressException;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;

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
	
	@Override
	public User getUserByEmail(String email){
		return userDao.getUserByEmail(email);
	}
	
	public static final String FROM = "nmgzhangran@163.com";
	public static final String PWD = "327453nmg";
	public static final String URL = "http://localhost:8080/questionnaire";
	public static final int TIMELIMIT = 1000*60*60*24;
	public static final String TITLE = "LZTR questionnaire account activation email";
	public static final String HOST = "smtp.163.com";
	public static final String SMTP = "smtp";
			
	
	@Override
	public User activateMail(User user) throws AddressException, MessagingException{
		String to = user.getEmail();
		Long curTime = System.currentTimeMillis();
		Long activateTime = curTime + TIMELIMIT;
		String token = to + curTime;
		user.setToken(token);
		user.setCreateDate(new Date());
		token = user.getToken();
		user.setActivateTime(activateTime);
		String content = "<p>Hello本次内容为学生作业。请不要草率退信，我们不会对其他人造成影响<br><br>Welcome to LZTR Questinnaire Website!<br><br>"
				+ "Your Account need to be activated, now to activate to be a member of us!"
				+ "<br><br>Please activate your account in 24 hours:"
				+ "<br><a href = '" + URL + "/activatemail?token=" + token
				+ "&email=" + to + "'>"
				+ URL + "/activatemail?token=" + token + "&email=" + to + "</a></p>";
		sendMail(to, TITLE, content);
		return user;
	}
	
	@Override
	public void sendMail(String to, String title, String content) throws AddressException, MessagingException{
		System.out.println("2-1");
		Properties props = new Properties();
		System.out.println("2-1-1");
		props.put("mail.smtp.host", HOST);
		System.out.println("2-1-2");
		props.put("mail.smtp.auth", "true");
		System.out.println("2-1-3");
		Session session = Session.getInstance(props);
		System.out.println(session);
		System.out.println(session.toString());
		session.setDebug(true);
		System.out.println("2-2");
		MimeMessage message = new MimeMessage(session);
		message.setFrom(new InternetAddress(FROM));
		message.addRecipient(Message.RecipientType.TO, new InternetAddress(to));
		message.addRecipient(Message.RecipientType.CC, new InternetAddress(FROM));
		message.setSubject(title);
		System.out.println("2-3");
		 message.setContent(content, "text/html;charset=gbk"); //发送HTML邮件，内容样式比较丰富  
	       // message.setSentDate(new Date());//设置发信时间  
	        message.saveChanges();//存储邮件信息  
	       
		Transport transport = session.getTransport(SMTP);
		transport.connect(FROM, PWD);
		transport.sendMessage(message, message.getAllRecipients());
		transport.close();
	}
	
	
}