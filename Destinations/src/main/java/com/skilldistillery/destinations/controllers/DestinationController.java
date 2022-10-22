package com.skilldistillery.destinations.controllers;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import com.skilldistillery.destinations.data.DestinationDAO;
import com.skilldistillery.destinations.entities.Destination;

@Controller
public class DestinationController {

	@Autowired
	private DestinationDAO destinationDao;
	
//	@RequestMapping(path= {"/", "welcome.do"})
//	public String welcome(Model model) {
//		model.addAttribute("SMOKETEST", userDao.findById(1));
//		return "welcome";
//	}
	@RequestMapping(path= {"home.do"})
	public String home(Model model) {
		model.addAttribute("destination", destinationDao.findDestinationById(1));
		model.addAttribute("destinations", destinationDao.findAllDestinations());
		return "home";
	}
	
	@RequestMapping(path = "showDestination.do")
	public String showDestination(Integer did, Model model) {
		model.addAttribute("destination", destinationDao.findDestinationById(did));
		//Destination destination = destinationDao.findDestinationById(did);
		
		return "showDestination";
	}
}
