package com.skilldistillery.destinations.controllers;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;

import com.skilldistillery.destinations.data.DestinationDAO;
import com.skilldistillery.destinations.entities.DestinationImage;
import com.skilldistillery.destinations.entities.Review;
import com.skilldistillery.destinations.entities.ReviewComment;
import com.skilldistillery.destinations.entities.ReviewId;
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
		
		mv.addObject("user", user);
		
		destinationDao.createNewReviewForDestination(destinationId, review, user.getId());
		
		mv.setViewName("redirect:showDestination.do?did=" + destinationId);
		
		return mv;
	}
	
	
	@RequestMapping(path="updateDestinationReview.do", method = RequestMethod.POST)
	public ModelAndView updateDestinationReview(int destinationId, Review review, HttpSession session) {
		ModelAndView mv = new ModelAndView();
		
		User user = this.isUserInSession(session);
		
		destinationDao.updateReviewForDestination(destinationId, user.getId(), review);
		
		mv.setViewName("redirect:showDestination.do?did=" + destinationId);
		
		return mv;
	}
	
	@RequestMapping(path="deleteDestinationReview.do", method = RequestMethod.POST)
	public ModelAndView deleteDestinationReview(int destinationId, Review review, HttpSession session) {
		ModelAndView mv = new ModelAndView();
		
		User user = this.isUserInSession(session);
		
		destinationDao.deleteReviewForDestination(destinationId, user.getId(), review);
		
		mv.setViewName("redirect:showDestination.do?did=" + destinationId);
		
		return mv;
	}
	
	@RequestMapping(path="createReviewComment.do", method = RequestMethod.POST)
	public ModelAndView createReviewComment(int destinationId, int reviewUserId, String reviewComment, HttpSession session) {
		ModelAndView mv = new ModelAndView();
		
		User user = this.isUserInSession(session);
		
		mv.addObject("user", user);
		ReviewId reviewId = new ReviewId(destinationId, reviewUserId);
		System.out.println(reviewId);
		destinationDao.createNewReviewCommentForReview(reviewId, reviewComment, user.getId());
		
		mv.setViewName("redirect:showDestination.do?did=" + reviewId.getDestinationId());
		
		return mv;
	}
	
	@RequestMapping(path="updateReviewComment.do", method = RequestMethod.POST)
	public ModelAndView updateReviewComment(int destinationId, int reviewUserId, ReviewComment reviewComment, HttpSession session) {
		ModelAndView mv = new ModelAndView();
		System.out.println(reviewComment);
		User user = this.isUserInSession(session);
		
		mv.addObject("user", user);
		ReviewId reviewId = new ReviewId(destinationId, reviewUserId);
		System.out.println(reviewId);
		
		destinationDao.updateReviewCommentForReview(reviewId, reviewComment, user.getId());
		
		mv.setViewName("redirect:showDestination.do?did=" + destinationId);
		
		return mv;
	}
	
	@RequestMapping(path="deleteReviewComment.do", method = RequestMethod.POST)
	public ModelAndView deleteReviewComment(int destinationId, int reviewUserId, ReviewComment reviewComment, HttpSession session) {
		ModelAndView mv = new ModelAndView();
		
		User user = this.isUserInSession(session);
		
		ReviewId reviewId = new ReviewId(destinationId, reviewUserId);
		destinationDao.deleteReviewCommentForReview(reviewId, reviewComment, user.getId());
		
		mv.setViewName("redirect:showDestination.do?did=" + destinationId);
		
		return mv;
	}
	
	@RequestMapping(path="createDestinationImage.do", method=RequestMethod.POST)
	public ModelAndView createDestinationImage(DestinationImage image, HttpSession session, int destinationId) {
		ModelAndView mv = new ModelAndView();
		
		User user = this.isUserInSession(session);
		
		destinationDao.createDestinationImage(image, user.getId(), destinationId);
		
		mv.setViewName("redirect:showDestination.do?did=" + destinationId);
		
		return mv;
		
	}
	
	@RequestMapping(path="updateDestinationImage.do", method=RequestMethod.POST)
	public ModelAndView updateDesintationImage(DestinationImage image, HttpSession session, int destinationId) {
	ModelAndView mv = new ModelAndView();
		
		User user = this.isUserInSession(session);
		
		destinationDao.updateDestinationImage(image, user.getId(), destinationId);
		
		mv.setViewName("redirect:showDestination.do?did=" + destinationId);
		
		return mv;
		
	}
	
	@RequestMapping(path="deleteDestinationImage.do", method=RequestMethod.POST)
	public ModelAndView deleteDesintationImage(DestinationImage image, HttpSession session, int destinationId) {
		ModelAndView mv = new ModelAndView();
		
		User user = this.isUserInSession(session);
		
		destinationDao.deleteDestinationImage(image, user.getId(), destinationId);
		
		mv.setViewName("redirect:showDestination.do?did=" + destinationId);
		
		return mv;
		
	}
	
	
}
