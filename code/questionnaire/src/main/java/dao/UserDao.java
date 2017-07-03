package dao;

import java.util.List;

import model.User;

public interface UserDao {

	Integer addUser(User user);

	void deleteUser(User user);

	void updateUser(User user);

	User getUserById(int id);

	List<User> getAllUsers();

	List<User> getUserByUsername(String name);

}