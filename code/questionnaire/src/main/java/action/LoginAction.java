package action;

import model.User;
import service.LoginService;

public class LoginAction extends BaseAction{
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	private LoginService loginService;
	private String password;
	private String username;
	public void setLoginService(LoginService loginService) {
		this.loginService = loginService;
	}
	public String getUsername() {
		return username;
	}
	public void setUsername(String username) {
		this.username = username;
	}
	public String getPassword() {
		return password;
	}
	public void setPassword(String password) {
		this.password = password;
	}
	public String login(){
		User user = loginService.login(username,  password);
		if(user != null) {
			session().setAttribute("user", user);
			return SUCCESS;
		}
		else{
			request().setAttribute("flag", "0");
			return INPUT;
		}
	}
	
	public String logout(){
		session().removeAttribute("user");
		return SUCCESS;
	}
	
}