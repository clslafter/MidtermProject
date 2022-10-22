package com.skilldistillery.destinations.controllers;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import com.skilldistillery.destinations.data.UserDAO;

@Controller
public class UserController {

	@Autowired
	private UserDAO userDao;
	
	@RequestMapping(path= {"/", "welcome.do"})
	public String welcome(Model model) {
		model.addAttribute("SMOKETEST", userDao.findUserById(1));
		return "welcome";
	}
	@RequestMapping(path= {"login.do"})
	public String login(Model model) {
		
		return "login";
	}
	
	@RequestMapping(path= {"createAccount.do"})
	public String createAccount(Model model) {
		
		return "createAccount";
	}
	
	@RequestMapping(path= {"updateAccount.do"})
	public String updateAccount(int uid, Model model) {
		model.addAttribute("user", userDao.findUserById(uid));
		return "updateAccount";
	}
	
	@RequestMapping(path= {"showUserProfile.do"})
	public String showUserProfile(Model model) {
		model.addAttribute("user", userDao.findUserById(1));
		return "showUserProfile";
	}
	
	@RequestMapping(path= {"showAllUsers.do"})
	public String showAllUsers(Model model) {
		model.addAttribute("users", userDao.findAllUsers());
		return "showAllUsers";
	}
}
