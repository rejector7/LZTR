package dao;

import java.util.Arrays;


import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.hibernate.Hibernate;
import org.hibernate.Session;
import org.hibernate.type.StandardBasicTypes;

import model.User;
import model.UserProfile;

import org.hibernate.SessionFactory;
import org.hibernate.cfg.Configuration;

/* UserDaoImpl 用户持久化操作类实现
 * */


public class UserDaoImpl implements UserDao{
	public User getUserById(int userId){
		Session session = new Configuration().configure().buildSessionFactory().getCurrentSession();
		session.beginTransaction();
		User user = (User)session.get(User.class, userId);
		session.getTransaction().commit();
		return user;
	}
	//只返回一个user
	public User getUserByUsername(String username){
		Session session = new Configuration().configure().buildSessionFactory().getCurrentSession();
		session.beginTransaction();
		String hql = "from User where username=?";
		org.hibernate.Query query = session.createQuery(hql);
		query.setParameter(0, username,StandardBasicTypes.STRING);
		@SuppressWarnings("unchecked")
		List<User> users = query.list();
		session.getTransaction().commit();	
		if (users != null && users.size() !=0){
			//存在
			return users.get(0);
		}else{
			//不存在
			return null;
		}
	}
	//更新基本信息
	public void updateUser(User user){
		Session session = new Configuration().configure().buildSessionFactory().getCurrentSession();
		session.beginTransaction();
		org.hibernate.Query query = session.createQuery("update User user set user.age = ?, user.city= ?, user.country = ?, user.email=?, user.mobile=?, user.qq=?,"
				+ "user.sex=?, user.username=?, user.wechat=? where id = ?");
		query.setInteger(0,user.getAge());
		query.setString(1, user.getCity());
		query.setString(2, user.getCountry());
		query.setString(3,user.getEmail());
		query.setString(4, user.getMobile());
		query.setString(5, user.getQq());
		query.setString(6, user.getSex());
		query.setString(7, user.getUsername());
		query.setString(8,user.getWechat());
		query.setInteger(9, user.getId());
		query.executeUpdate();
		session.getTransaction().commit();
	}
	
	public void addUser(User user){
		Session session = new Configuration().configure().buildSessionFactory().getCurrentSession();
		session.beginTransaction();
		session.save(user);//add the user
		/*String hql = "from User where username=? and password=?";
		org.hibernate.Query query = session.createQuery(hql);
		query.setParameter(0, user.getUsername(), StandardBasicTypes.STRING);
		query.setParameter(1, user.getPassword(), StandardBasicTypes.STRING);
		@SuppressWarnings("unchecked")
		List<User> users = query.list();//按用户名和密码查询用户
		//初始化该用户的 问卷
		user = users.get(0);//更新此用户
		*/
		//用户名重复在jsp中判断
		session.getTransaction().commit();
	}
	
	public void removeUser(int userId){
		Session session = new Configuration().configure().buildSessionFactory().getCurrentSession();
		session.beginTransaction();
		org.hibernate.Query query = session.createQuery("delete User as user where user.id=?");
		query.setParameter(0, userId, StandardBasicTypes.LONG);
		query.executeUpdate();
		session.getTransaction().commit();
	}
	//get all users and corresponding orderNum.
	public List<User> getAllUser(){
		Session session =new Configuration().configure().buildSessionFactory().getCurrentSession();
		session.beginTransaction();
		org.hibernate.Query query = session.createQuery("from User where user.role=user");
		@SuppressWarnings("unchecked")
		List<User> list = query.list();
		User[] userArray = new User[list.size()];
		list.toArray(userArray);
		Arrays.sort(userArray);//用户按ID 排序
		List<User> sortedList=Arrays.asList(userArray);
		session.getTransaction().commit();	
		return sortedList;
	}
	public List<User> getAllAdmin(){
		Session session =new Configuration().configure().buildSessionFactory().getCurrentSession();
		session.beginTransaction();
		org.hibernate.Query query = session.createQuery("from User where user.role=admin");
		@SuppressWarnings("unchecked")
		List<User> list = query.list();
		User[] userArray = new User[list.size()];
		list.toArray(userArray);
		Arrays.sort(userArray);//用户按ID 排序
		List<User> sortedList=Arrays.asList(userArray);
		session.getTransaction().commit();	
		return sortedList;
	}
	//关于问卷
	//获取所有user列表及其对应的发布问卷
	public Map<String, Object> getAllUserWithIssue(){
		return null;
	}
	
	//获取所有user列表及其对应的填写问卷
	public Map<String, Object> getAllUserWithFill(){
		return null;
	}
	
	//获取所有user列表及其对应的发布填写问卷
	public Map<String, Object> getAllUserWithAll(){
		return null;
	}
	
	public void updateUserPassword(User user){
		Session session =new Configuration().configure().buildSessionFactory().getCurrentSession();
		session.beginTransaction();
		org.hibernate.Query query = session.createQuery("update User user set user.password = ? where user.id = ?");
		query.setString(0, user.getPassword());
		query.setLong(1, user.getId());
		query.executeUpdate();
		session.getTransaction().commit();	
	}
	
	//获取UserProfile
	public UserProfile getUserProfileById(int Id){
		return null;
	}
	//添加UserProfile
	public void addUserProfile(UserProfile userProfile){
		
	}
	//更新UserProfile
	public void updateUserProfile(UserProfile userProfile){
		
	}
	
	
	 
	
	
}
