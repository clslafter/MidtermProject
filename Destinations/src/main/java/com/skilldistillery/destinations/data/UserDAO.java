package com.skilldistillery.destinations.data;

import java.util.List;

import com.skilldistillery.destinations.entities.User;

public interface UserDAO {
	User findUserById(int userId);
	List <User> findAllUsers();
	User getUserByUserNameAndPassword(String userName, String password);

}
