package dao;

import java.util.List;

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
	
	//获取所有common user列表
	public List<User> getAllUser();
	
	public List<User> getAllAdmin();
	
	//获取所有user列表及其对应的发布问卷
	public Map<String, Object> getAllUserWithIssue();
	
	//获取所有user列表及其对应的填写问卷
	public Map<String, Object> getAllUserWithFill();
	
	//获取所有user列表及其对应的发布填写问卷
	public Map<String, Object> getAllUserWithAll();
	
	//更新User的Password
	public void updateUserPassword(User user);
	
	//获取UserProfile
	public UserProfile getUserProfileById(int Id);
	//添加UserProfile
	public void addUserProfile(UserProfile userProfile);
	//更新UserProfile
	public void updateUserProfile(UserProfile userProfile);
}
