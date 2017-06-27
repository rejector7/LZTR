package dao;

import java.util.Map;



import model.User;
import model.UserProfile;

/* UserDao 用户持久化操作类
 * */

public interface UserDao {
	
	//通过ID获取user
	public User getUserById(int userId);
	//通过username获取user
	public User getUserByUsername(String username);
	
	//添加user
	public void addUser(User user);
	
	//通过ID删除user
	public void removeUser(int userId);
	
	//更新user基础信息
	public void updateUser(User user);
	
	//获取所有user列表,并获得其订单数
	public Map<String, Object> getAllUser();
	
	//更新User的Password
	public void updateUserPassword(User user);
	
	
}
