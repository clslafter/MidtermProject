package com.skilldistillery.destinations.data;

import com.skilldistillery.destinations.entities.User;

public interface UserDAO {
	User findUserById(int userId);

}
