package action;

import java.io.IOException;
import java.util.Date;
import java.util.List;

import javax.mail.MessagingException;
import javax.mail.internet.AddressException;
import javax.servlet.http.HttpServletRequest;

import model.User;
import service.UserService;

public class UserAction extends BaseAction{
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	private int id;
	private String username;
	private String password;
	private String oldpassword;
	private int age;
	private String sex;		//male and female
	private String email;
	private String country;
	private String city;
	
	private String mobile;
	private String qq;
	private String wechat;
	private String job;
	private String role; //admin or user(it means common user)
	
	private String condi;//for search
	
	private UserService userService;

	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
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

	public int getAge() {
		return age;
	}

	public void setAge(int age) {
		this.age = age;
	}

	public String getSex() {
		return sex;
	}

	public void setSex(String sex) {
		this.sex = sex;
	}

	public String getEmail() {
		return email;
	}

	public void setEmail(String email) {
		this.email = email;
	}

	public String getCountry() {
		return country;
	}

	public void setCountry(String country) {
		this.country = country;
	}

	public String getCity() {
		return city;
	}

	public void setCity(String city) {
		this.city = city;
	}

	public String getMobile() {
		return mobile;
	}

	public void setMobile(String mobile) {
		this.mobile = mobile;
	}

	public String getQq() {
		return qq;
	}

	public void setQq(String qq) {
		this.qq = qq;
	}

	public String getWechat() {
		return wechat;
	}

	public void setWechat(String wechat) {
		this.wechat = wechat;
	}

	public String getRole() {
		return role;
	}

	public void setRole(String role) {
		this.role = role;
	}
	
	public String getJob() {
		return job;
	}

	public void setJob(String job) {
		this.job = job;
	}
	
	public void setCondi(String condi){
		this.condi = condi;
	}
	public String getCondi(){
		return this.condi;
	}

	public String getOldpassword() {
		return oldpassword;
	}

	public void setOldpassword(String oldpassword) {
		this.oldpassword = oldpassword;
	}

	public void setUserService(UserService userService) {
		this.userService = userService;
	}
	
	public String add() throws Exception {
		if(userService.getUserByName(username)!=null){
			response().getWriter().print("dupusername");
			return null;
		}
		if(userService.getUserByEmail(email)!=null){
			response().getWriter().print("dupemail");
			return null;
		}
		if(role==null) role = "user";
		System.out.println("1");
		User user = new User(username, password, age, sex, email, country,
				city, mobile, qq, wechat, role, job, null, null, null, 0);
		System.out.println("2");
		user = userService.activateMail(user);
		
		System.out.println("3");
		userService.addUser(user);
		System.out.println("4");
		response().getWriter().print("success");
		return null;
	}
	
	public String update() throws Exception {
		User user = userService.getUserById(id);
		user.setCity(city);
		user.setAge(age);
		user.setCountry(country);
		if(email!=null||email!=""){
		user.setEmail(email);
		}
		user.setMobile(mobile);
		user.setQq(qq);
		user.setSex(sex);
		user.setWechat(wechat);
		user.setJob(job);
		userService.updateUser(user);
		session().removeAttribute("user");
		session().setAttribute("user", user);
		return "update";
	}
	
	public String delete() throws Exception {
		User user = userService.getUserById(id);
		userService.deleteUser(user);
		return "delete";
	}
	
	public String all() throws Exception {
		List<User> users = userService.getAllUsers();
		request().setAttribute("Users", users);
		return "all";
	}
	
	public String search() throws Exception{
		List<User> Users = userService.findUsers(condi);
		request().setAttribute("ResultList", Users);
		return "search";
	}
	
	public String activate() throws AddressException, MessagingException{
		String email = request().getParameter("email");
		String token = request().getParameter("token");
		Long time = System.currentTimeMillis();
		User u = userService.getUserByEmail(email);
		if(u!=null){
			if(u.getStatus()==0 && u.getActivateTime()!= 1){
				if(u.getActivateTime()<time){
					//过期，激活失败
					u.setActivateTime(Long.parseLong("-1"));
					//重新发送
					u = userService.activateMail(u);
					userService.updateUser(u);
				}
				else if(u.getActivateTime()>time){
					//在时间内
					u.setActivateTime(Long.parseLong("1"));
					if(u.getToken().equals(token)){
						//激活码通过
						u.setStatus(1);
						u.setCreateDate(new Date());
						u.setToken("");
						userService.updateUser(u);
					}
					else{
						//激活码错误
					}
				}
			}
			else if(u.getStatus()==1){
				//已经被激活重复点链接
				request().setAttribute("flag", 3);
				return SUCCESS;
			}
		}
		else if(u==null){
			
		}
		request().setAttribute("flag", 2);
		return SUCCESS;
		
	}

	public String updatepass() throws IOException{
		User user = userService.getUserById(id);
		System.out.println("id:"+id+"oldpassword:"+oldpassword+"user.getPassword():"+user.getPassword());
		if(!user.getPassword().equals(oldpassword)){
			response().getWriter().print("false");
			return null;
		}
		user.setPassword(password);
		userService.updateUser(user);
		session().removeAttribute("user");
		session().removeAttribute("role");
		response().getWriter().print("true");
		return null;
	}
}