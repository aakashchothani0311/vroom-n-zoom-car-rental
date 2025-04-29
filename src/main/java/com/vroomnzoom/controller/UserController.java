package com.vroomnzoom.controller;

import java.util.List;

import org.springframework.stereotype.Controller;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import com.vroomnzoom.dao.UserDAO;
import com.vroomnzoom.model.User;

import jakarta.servlet.http.HttpSession;

@Controller
@RequestMapping("/my-profile")
public class UserController {
	
	private final UserDAO userDAO;
	
	public UserController(UserDAO userDAO) {
		this.userDAO = userDAO;
	}
	
	@GetMapping
	public ModelAndView showProfilePage(HttpSession session) {
		User user = (User) session.getAttribute("user");
		
		ModelAndView mav = new ModelAndView("user/profile", "user", user);
		return mav;
	}
	
	@PostMapping
	public ModelAndView updateUserProfile(@ModelAttribute User user, BindingResult result, HttpSession session) {
		User sessionUser = (User) session.getAttribute("user");
		
		if(sessionUser.getEmail().equals(user.getEmail()))
			return updateUserHelper(user, session);
		else {
	    	List<User> dupUsers = userDAO.getUserByUsernameEmail(user.getUsername(), user.getEmail());
	    	
	    	if(dupUsers == null)
	    		return new ModelAndView("error");
	    	else {
	    		if(dupUsers.size() == 0)
	    			return updateUserHelper(user, session);
	        	else {
	        	    boolean emailExists = dupUsers.stream().anyMatch(u -> u.getEmail().equals(user.getEmail()));        	             	     
	        	    if(emailExists) {
	        	    	result.rejectValue("email", "email.exists", "Email taken. Use a different email.");
	        	    	return new ModelAndView("user/profile", "user", user);
	        	    } else
	        	    	return updateUserHelper(user, session);
	        	}
	    	} 
		}
	}
	
	private ModelAndView updateUserHelper(User user, HttpSession session) {
		User sessionUser = (User) session.getAttribute("user");
		sessionUser.setFirstName(user.getFirstName());
		sessionUser.setLastName(user.getLastName());
		sessionUser.setEmail(user.getEmail());
		sessionUser.setPhone(user.getPhone());
		
		User updatedUser = userDAO.updateUser(sessionUser);
		session.setAttribute("user", updatedUser);
		
		ModelAndView mav = new ModelAndView("user/profile");
		mav.addObject("user", updatedUser);
		mav.addObject("message", "Profile Updated.");
		return mav;
	}
}
