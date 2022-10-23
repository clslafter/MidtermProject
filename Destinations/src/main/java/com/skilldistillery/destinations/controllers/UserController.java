package com.skilldistillery.destinations.controllers;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.skilldistillery.destinations.data.UserDAO;
import com.skilldistillery.destinations.entities.Address;
import com.skilldistillery.destinations.entities.User;

@Controller
public class UserController {

	@Autowired
	private UserDAO userDao;
	
	private User isUserInSession(HttpSession session) {
		if(session.getAttribute("user") != null) {
			return (User) session.getAttribute("user");			
		}else {
			return null;
		}
	}
	
	@RequestMapping(path = { "/", "welcome.do" })
	public String welcome(Model model) {
		model.addAttribute("SMOKETEST", userDao.findUserById(1));
		return "welcome";
	}

	@RequestMapping(path = { "updateAccount.do" })
	public String updateAccount(int uid, Model model) {
		model.addAttribute("user", userDao.findUserById(uid));
		return "updateAccount";
	}

	@RequestMapping(path = { "showUserProfile.do" })
	public String showUserProfile(Model model, HttpSession session) {
		User user = this.isUserInSession(session);
		if(user == null) {
			return "welcome";
		}
		boolean isAdmin = user.getRole().equals("admin");
		model.addAttribute("user", user);
		model.addAttribute("isAdmin", isAdmin);

		return "showUserProfile";
	}

	@RequestMapping(path = { "showAllUsers.do" })
	public String showAllUsers(Model model) {
		model.addAttribute("users", userDao.findAllUsers());
		return "showAllUsers";
	}

//	@RequestMapping(path = "loginPage.do")
//	public String login(Model model) {
//		return "login";
//	}

	@RequestMapping(path = "login.do", method = RequestMethod.GET)
	public ModelAndView getLogin(HttpSession session) {
		ModelAndView mv = new ModelAndView();
		if (session.getAttribute("user") != null) {
			mv.setViewName("welcome");
		}
		mv.setViewName("login");
		return mv;
	}

	@RequestMapping(path = "login.do", method = RequestMethod.POST)
	public ModelAndView postLogin(User user, HttpSession session) {
		ModelAndView mv = new ModelAndView();
		user = userDao.getUserByUserNameAndPassword(user.getUsername(), user.getPassword());
		if (session.getAttribute("user") != null) {
			mv.setViewName("welcome");
		} else if (user != null) {
			session.setAttribute("user", user);
			mv.addObject("user", user);
			mv.setViewName("showUserProfile");
		} else {
			mv.setViewName("login");
		}
		return mv;
	}

	@RequestMapping(path = "logout.do", method = RequestMethod.GET)
	public ModelAndView getLogout(HttpSession session) {
		ModelAndView mv = new ModelAndView();
		session.removeAttribute("user");
		mv.setViewName("welcome");
		return mv;
	}

	@RequestMapping(path = { "createAccount.do" })
	public String createAccount(Model model, User user) {
		model.addAttribute("user", user);
		return "createAccount";
	}

	@RequestMapping(path = "createUserAccount.do", method = RequestMethod.POST)
	public ModelAndView createUserAccount(User user, RedirectAttributes redir) {
		ModelAndView mv = new ModelAndView();
		
		user.setAddress(userDao.createUserAddress(new Address()));
		
		user.setEnabled(true);
		
		user.setRole("normal");
		
		user = userDao.createUserAccount(user);
		redir.addFlashAttribute("user", user);
		mv.setViewName("redirect:userCreated.do");
		return mv;
	}

	@RequestMapping(path = "userCreated.do", method = RequestMethod.GET)
	public ModelAndView userCreated() {
		ModelAndView mv = new ModelAndView();
		mv.setViewName("login");
		return mv;
		
	}
	
	@RequestMapping(path="updateAccount.do", method = RequestMethod.GET)
	public ModelAndView updateDetails(int id) {
		ModelAndView mv = new ModelAndView();
		mv.addObject("user", userDao.findUserById(id));
		mv.addObject("address", userDao.getAddressIdByUserId(id));
		mv.setViewName("updateAccount");
		return mv;
	}
	
	@RequestMapping(path="updateUserInfo.do", method = RequestMethod.POST)
	public ModelAndView updateAccount(int id, User user, Address address, RedirectAttributes redir) {
		ModelAndView mv = new ModelAndView();
		int addressId  = userDao.getAddressIdByUserId(id).getId();
		System.out.println(addressId);
		user = userDao.updateUserAccount(id, user);
		address = userDao.updateAddressInUserAccount(addressId, address);
		redir.addFlashAttribute("user", user);
		redir.addFlashAttribute("address", address);
		mv.setViewName("redirect:userAccountUpdated.do");
		return mv;
	}
	
	@RequestMapping(path="userAccountUpdated.do", method = RequestMethod.GET)
	public ModelAndView userAccountUpdated() {
		ModelAndView mv = new ModelAndView();
		mv.setViewName("showUserProfile");
		return mv;
	}
	

}
