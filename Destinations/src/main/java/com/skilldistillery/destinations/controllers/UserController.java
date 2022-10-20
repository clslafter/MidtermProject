package com.skilldistillery.destinations.controllers;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;

import com.skilldistillery.destinations.data.UserDAO;

@Controller
public class UserController {

	@Autowired
	private UserDAO userDao;
}
