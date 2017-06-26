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
		org.hibernate.Query query = session.createQuery("update User user set user.coin = ?, user.mobile= ?, user.priority = ?, user.username=?, user.sex=? where id = ?");
		query.setBigDecimal(0, user.getCoin());
		query.setLong(1, user.getMobile());
		query.setInteger(2, user.getPriority());
		query.setString(3, user.getUsername());
		query.setInteger(4, user.getSex());
		query.setLong(5, user.getId());
		query.executeUpdate();
		session.getTransaction().commit();
	}
	
	public void addUser(User user){
		Session session = new Configuration().configure().buildSessionFactory().getCurrentSession();
		session.beginTransaction();
		session.save(user);//add the user
		String hql = "from User where username=? and password=?";
		org.hibernate.Query query = session.createQuery(hql);
		query.setParameter(0, user.getUsername(), StandardBasicTypes.STRING);
		query.setParameter(1, user.getPassword(), StandardBasicTypes.STRING);
		@SuppressWarnings("unchecked")
		List<User> users = query.list();//按用户名和密码查询用户
		Hibernate.initialize(users.get(0).getOrders());//初始化该用户的 订单
		user = users.get(0);//更新此用户
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
	public Map<String, Object> getAllUser(){
		Session session =new Configuration().configure().buildSessionFactory().getCurrentSession();
		session.beginTransaction();
		org.hibernate.Query query = session.createQuery("from User");
		@SuppressWarnings("unchecked")
		List<User> list = query.list();
		User[] userArray = new User[list.size()];
		list.toArray(userArray);
		Arrays.sort(userArray);//用户按ID 排序
		int[] orderNum = new int[list.size()];
		for (int i = 0; i < userArray.length; i++){
			orderNum[i] = userArray[i].getOrders().size();
		}
		Map<String, Object> ans = new HashMap<String, Object>();
		ans.put("userArray", userArray);
		ans.put("orderNum", orderNum);				// two keys and two values.
		session.getTransaction().commit();	
		return ans;
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
	
	
	 
	
	
}
