package action;

import java.util.List;

import model.User;
import service.UserService;

public class UserActions extends BaseAction{
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	private int id;
	private String username;
	private String password;
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

	public void setUserService(UserService userService) {
		this.userService = userService;
	}
	
	public String add() throws Exception {
		if(userService.getUserByName(username)!=null){
			response().getWriter().print("itdepends");
			return null;
		}
		if(role==null) role = "user";
		User user = new User(username, password, age, sex, email, country,
				city, mobile, qq, wechat, role, job);
		userService.addUser(user);
		response().getWriter().print("success");
		return null;
	}
	
	public String update() throws Exception {
		User user = userService.getUserById(id);
		user.setCity(city);
		user.setAge(age);
		user.setCountry(country);
		user.setEmail(email);
		user.setMobile(mobile);
		user.setPassword(password);
		user.setQq(qq);
		user.setRole(role);
		user.setSex(sex);
		user.setUsername(username);
		user.setWechat(wechat);
		user.setJob(job);
		userService.updateUser(user);
		return "updateUser";
	}
	
	public String delete() throws Exception {
		User user = userService.getUserById(id);
		userService.deleteUser(user);
		return "deleteUser";
	}
	
	public String all() throws Exception {
		List<User> users = userService.getAllUsers();
		request().setAttribute("users", users);
		return "allUser";
	}

	public String getJob() {
		return job;
	}

	public void setJob(String job) {
		this.job = job;
	}
}
