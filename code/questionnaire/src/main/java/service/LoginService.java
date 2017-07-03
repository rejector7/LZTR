package service;

import model.User;

public interface LoginService{
	User login(String username, String password);
}