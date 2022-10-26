package com.skilldistillery.destinations.controllers;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;

import com.skilldistillery.destinations.data.DestinationDAO;
import com.skilldistillery.destinations.entities.Review;
import com.skilldistillery.destinations.entities.User;

@Controller
public class ReviewAndCommentController {

	@Autowired
	private DestinationDAO destinationDao;
	
	private User isUserInSession(HttpSession session) {
		if(session.getAttribute("user") != null) {
			return (User) session.getAttribute("user");			
		}else {
			return null;
		}
	}
	
	@RequestMapping(path="createDestinationReview.do", method = RequestMethod.POST)
	public ModelAndView createDestinationReview(int destinationId, Review review, HttpSession session) {
		ModelAndView mv = new ModelAndView();
		
		User user = this.isUserInSession(session);
		
		destinationDao.createNewReviewForDestination(destinationId, review, user.getId());
		
		mv.setViewName("redirect:showDestination.do?did=" + destinationId);
		
		return mv;
	}
	
}
