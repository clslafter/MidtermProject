package com.skilldistillery.destinations.controllers;

import java.time.LocalDateTime;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.skilldistillery.destinations.data.DestinationDAO;
import com.skilldistillery.destinations.entities.Address;
import com.skilldistillery.destinations.entities.Destination;
import com.skilldistillery.destinations.entities.User;

@Controller
public class DestinationController {

	@Autowired
	private DestinationDAO destinationDao;
	
	private User isUserInSession(HttpSession session) {
		if(session.getAttribute("user") != null) {
			return (User) session.getAttribute("user");			
		}else {
			return null;
		}
	}
	
	@RequestMapping(path= {"home.do"})
	public String home(Model model) {
		model.addAttribute("destination", destinationDao.findDestinationById(1));
		model.addAttribute("destinations", destinationDao.findAllDestinations());
		return "home";
	}
	
	@RequestMapping(path = "showDestination.do")
	public String showDestination(Integer did, Model model) {
		model.addAttribute("destination", destinationDao.findDestinationById(did));
//		model.addAttribute("categories", destinationDao.findCategoriesByDestinationId(did));
//		First, find singular review of destination created by the user who created the destination.
//		If review.destination.user = review.user then list this one first
		//Destination destination = destinationDao.findDestinationById(did);
		return "showDestination";
	}
	
	@RequestMapping(path = "createDestination.do")
	public String createDestination(Model model) {
		model.addAttribute("features", destinationDao.findAllFeatures());
		return "createDestination";
	}
	
	@RequestMapping(path = "createNewDestination.do", method = RequestMethod.POST)
	public ModelAndView createNewDestination(Destination destination, Address address, HttpSession session, RedirectAttributes redir) {
		ModelAndView mv = new ModelAndView();
		
		destination.setAddress(destinationDao.createDestinationAddress(address));
		
		destination.setFeatures(null);
		
		destination.setEnabled(true);
		
		User user = this.isUserInSession(session);
		destination.setUser(user);
		
		destination.setCreateDate(LocalDateTime.now());
		
		destination = destinationDao.createNewDestination(destination);
		redir.addFlashAttribute("destination", destination);
		mv.setViewName("redirect:destinationCreated.do"); 
		return mv;
	}
	
	@RequestMapping(path = "destinationCreated.do", method = RequestMethod.GET)
	public ModelAndView destinationCreated() {
		ModelAndView mv = new ModelAndView();
		mv.setViewName("redirect:home.do");
		return mv;
	}
	
	@RequestMapping(path = "updateDestination.do")
	public String updateDestination(Integer did, Model model) {
		model.addAttribute("destination", destinationDao.findDestinationById(did));
		return "updateDestination";
	}
	
	
}
