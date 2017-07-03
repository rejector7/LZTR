package dao;

import model.User;

public interface LoginDao{
	User login(String username, String password);
}