package model;

import java.util.Date;

public class User {
	private int id;
	private String username;
	private String password;
	private int age;
	private String sex;		//male and female
	private String email;
	private String country;
	private String city;
	
	private int status;
	private String mobile;
	private String qq;
	private String wechat;
	private String job;
	private String role; //admin or user(it means common user)
	
	private String token;
	private Date createDate;
	private Long activateTime;
	
	public User(){
		
	}
	
	public User(String username, String password, int age, String sex, String email, String country,
			String city, String mobile, String qq, String wechat, String role, String job, String token, Date createDate, Long activateTime, int status) {
		this.username = username;
		this.password = password;
		this.age = age;
		this.sex = sex;
		this.email = email;
		this.country = country;
		this.city = city;
		this.mobile = mobile;
		this.qq = qq;
		this.wechat = wechat;
		this.role = role;
		this.job = job;
		this.createDate = createDate;
		this.token = token;
		this.activateTime = activateTime;
		this.status = status;
	}

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

	public void setPassword(String password){
		this.password=password;
	}
	
	public int getAge(){
		return this.age;
	}
	
	public void setAge(int age){
		this.age=age;
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

	public String getToken() {
		return token;
	}

	public void setToken(String token) {
		this.token = token;
	}

	public Date getCreateDate() {
		return createDate;
	}

	public void setCreateDate(Date createDate) {
		this.createDate = createDate;
	}

	public Long getActivateTime() {
		return activateTime;
	}

	public void setActivateTime(Long activateTime) {
		this.activateTime = activateTime;
	}

	public int getStatus() {
		return status;
	}

	public void setStatus(int status) {
		this.status = status;
	}
	
	
}
