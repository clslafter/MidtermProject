package com.skilldistillery.destinations.controllers;

import java.time.LocalDateTime;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.skilldistillery.destinations.data.DestinationDAO;
import com.skilldistillery.destinations.entities.Address;
import com.skilldistillery.destinations.entities.Destination;
import com.skilldistillery.destinations.entities.Review;
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
//		model.addAttribute("destination", destinationDao.findDestinationById2(1));
		model.addAttribute("destinations", destinationDao.findAllDestinations());
		return "home" ;
		
	}
	
	
	@RequestMapping(path = "showDestination.do")
	public String showDestination(int did, Model model, HttpSession session) {
		User user = isUserInSession(session);
		
		model.addAttribute("destination", destinationDao.findDestinationById(did));
		Review review = null;
		if(user != null) {
			review = destinationDao.findReviewByUserAndDestination(user.getId(), did);
		}
		model.addAttribute("userReview", review);
		
		return "showDestination";
	}
	
	@RequestMapping(path = "createDestination.do")
	public String createDestination(Model model) {
		model.addAttribute("features", destinationDao.findAllFeatures());
		model.addAttribute("categories", destinationDao.findAllCategories());
		return "createDestination";
	}
	
	@RequestMapping(path = "createNewDestination.do", method = RequestMethod.POST)
	public ModelAndView createNewDestination(Destination destination, Address address,@RequestParam(required = false) Integer [] featureIds,  @RequestParam(required = false) int [] categoryIds, HttpSession session, RedirectAttributes redir) {
		ModelAndView mv = new ModelAndView();
		
		destination.setAddress(destinationDao.createDestinationAddress(address));
		
		destination.setEnabled(true);
		
		User user = this.isUserInSession(session);
		destination.setUser(user);
		
		destination.setCreateDate(LocalDateTime.now());
		
		destination = destinationDao.createNewDestination(destination, featureIds, categoryIds);
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
	
	@RequestMapping(path = "updateDestination.do", method = RequestMethod.GET)
	public ModelAndView updateDeatils(int id) {
		ModelAndView mv = new ModelAndView();
		
		mv.addObject("destination", destinationDao.findDestinationById(id));
		mv.addObject("address", destinationDao.getAddressIdByDestinationId(id));
		mv.addObject("features", destinationDao.findAllFeatures());
		mv.addObject("categories", destinationDao.findAllCategories());
		mv.addObject("prices", destinationDao.findAllPrices());
		mv.addObject("pricingTypes", destinationDao.findAllPricingTypes());
		mv.addObject("currencies", destinationDao.findAllCurrencies());
		
		mv.setViewName("updateDestination");
		return mv;
	}
	
	@RequestMapping(path="updateDestinationInfo.do", method = RequestMethod.POST)
	public ModelAndView updateDestination(int id, 
										Destination destination, 
										Address address, 
										@RequestParam(required = false) Integer [] featureIds, 
										@RequestParam(required = false) Integer [] categoryIds, 
										@RequestParam(required = false) Integer priceId,
										@RequestParam(required = false) Integer currencyId,
										@RequestParam(required = false) Integer typeId,
										@RequestParam(required = false) Double amount,
										@RequestParam(required = false) String description,
										RedirectAttributes redir) {
		
		ModelAndView mv = new ModelAndView();
		int addressId = destinationDao.getAddressIdByDestinationId(id).getId();
		
		destinationDao.updateDestination(id, destination, featureIds, categoryIds, priceId, currencyId, typeId, amount, description);
		
		destination = destinationDao.findDestinationById(id);
		
		address = destinationDao.updateAddressInDestination(addressId, address);
		
		redir.addFlashAttribute("destination", destination );
		redir.addFlashAttribute("address", address);
		
		mv.setViewName("redirect:showDestination.do?did=" + destination.getId());
		return mv;
	}
	
	@RequestMapping(path="destinationUpdated.do", method = RequestMethod.GET)
	public ModelAndView destinationUpdated() {
		ModelAndView mv = new ModelAndView();
		mv.setViewName("redirect:showDestination.do");
		return mv;
	}
	
	@RequestMapping(path="deleteDestination.do", method = RequestMethod.GET)
	public ModelAndView deleteDetails(int id) {
		ModelAndView mv = new ModelAndView();
		mv.addObject("destination", destinationDao.findDestinationById(id));
		mv.setViewName("deleteDestination");
		return mv;		
	}
	
	@RequestMapping(path="destinationDeleted.do", method = RequestMethod.GET)
	public ModelAndView destinationDeleted(int id) {
		ModelAndView mv = new ModelAndView();
		Destination disabled = destinationDao.disableDestination(id);
		mv.addObject("destination", disabled);
		mv.setViewName("redirect:home.do");
		return mv;
		
	}
	
	@RequestMapping(path="deletePrice.do", method = RequestMethod.GET)
	public ModelAndView deletePrice(int priceId, int id) {
		ModelAndView mv = new ModelAndView();
		destinationDao.removePriceById(priceId, id);
		mv.setViewName("redirect:showDestination.do?did=" + id);
		return mv;
	}
	
	
	
}
