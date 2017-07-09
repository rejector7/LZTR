package action;

import java.sql.Date;


import java.util.List;

import model.User;
import service.UserService;

public class UserSearchAction extends BaseAction{
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	
	private UserService userService;
	private String condi;
	
	public void setCondi(String condi){
		this.condi = condi;
	}
	public String getCondi(){
		return this.condi;
	}
	
	public void setUserService(UserService userService) {
		this.userService = userService;
	}
	
	public String execute() throws Exception{
		List<User> Users = userService.findUsers(condi);
		request().setAttribute("ResultList", Users);
		return SUCCESS;
	}

}