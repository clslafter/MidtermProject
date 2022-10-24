package com.skilldistillery.destinations.data;

import java.util.List;

import com.skilldistillery.destinations.entities.Address;
import com.skilldistillery.destinations.entities.User;

public interface UserDAO {
	User findUserById(int userId);
	
	List <User> findAllUsers();
	
	User getUserByUserNameAndPassword(String userName, String password);

	User createUserAccount(User user);
	
	Address createUserAddress(Address address);
	
	User updateUserAccount(int id, User user);
	
	Address updateAddressInUserAccount(int id, Address address);
	
	Address getAddressIdByUserId(int id);
	
	User disableUserAccount(int id);
}
