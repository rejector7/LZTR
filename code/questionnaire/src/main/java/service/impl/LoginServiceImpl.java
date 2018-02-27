package service.impl;
import dao.LoginDao;
import model.User;
import service.LoginService;
public class LoginServiceImpl implements LoginService{
	private LoginDao loginDao;
	public void setLoginDao(LoginDao loginDao){
		this.loginDao = loginDao;
	}
	@Override
	public User login(String username, String password){
		return loginDao.login(username,  password);
	}
}