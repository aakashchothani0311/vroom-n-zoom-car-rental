package com.vroomnzoom.controller;

import java.util.List;

import org.springframework.stereotype.Controller;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import com.vroomnzoom.dao.UserDAO;
import com.vroomnzoom.model.User;

import jakarta.servlet.http.HttpSession;

@Controller
public class AuthController {
    
    private final UserDAO userDAO;
    
    public AuthController(UserDAO userDAO) {
    	this.userDAO = userDAO;
    }
    
    @GetMapping("/sign-in")
    public ModelAndView showLogin(@RequestParam(required = false) String source){
    	return new ModelAndView("signin", "source", source);
    }
    
    @PostMapping("/sign-in")
    public ModelAndView handleLogin(HttpSession session, @RequestParam String username, @RequestParam String password, @RequestParam(required = false) String source){
        User user = userDAO.getUserByCreds(username, password);

        if(user != null){
            session.setAttribute("user", user);
            if(user.getRole().equals("admin"))
            	return new ModelAndView("redirect:/admin/manage-bookings");
            else
            	return new ModelAndView("redirect:/" + (source != null ? source : ""));
        } else {
            ModelAndView mav = new ModelAndView("user/signin", "error", "Invalid username or password. Or the user is not active. Please contact the admin for further support.");
            
            if(source != null)
                mav.addObject("source", source);
            return mav;
        }
    }
    
    @GetMapping("/sign-up")
    public ModelAndView showSignUp(@ModelAttribute User user, @RequestParam(required = false) String source){
    	ModelAndView mav = new ModelAndView("user/signup", "user", user);
    	mav.addObject("source", source);
    	return mav;
    }
    
    @PostMapping("/sign-up")
    public ModelAndView handleSignUp(@ModelAttribute User user, BindingResult result, HttpSession session, @RequestParam(required = false) String source){    	
    	user.setActive(true);
    	user.setRole("user");
    	
    	List<User> dupUsers = userDAO.getUserByUsernameEmail(user.getUsername(), user.getEmail());
    	
    	ModelAndView mav = new ModelAndView("user/signup", "user", user);
		if(source != null)
            mav.addObject("source", source);
		
    	if(dupUsers == null)
    		mav.addObject("error", "Some error occured. Please try again later or contact support.");
    	else {
    		if(dupUsers.size() == 0) {
        		userDAO.createUser(user);
        		session.setAttribute("user", user);            	
                return new ModelAndView("redirect:/" + (source != null ? source : "/"));
        	} else {
        	     boolean usernameExists = dupUsers.stream().anyMatch(u -> u.getUsername().equals(user.getUsername()));
        	     boolean emailExists = dupUsers.stream().anyMatch(u -> u.getEmail().equals(user.getEmail()));
        	     
        	     if(usernameExists)
        	    	 result.rejectValue("username", "username.exists", "Username taken. Please select a different username.");
        	     
        	     if(emailExists)
        	    	 result.rejectValue("email", "email.exists", "Email taken. Register with a different email.");
        	}
    	} 
    	
    	return mav;
    }
    
    @GetMapping("/logout")
    public ModelAndView handleLogout(HttpSession session) {
    	session.invalidate();
    	return new ModelAndView("user/logout");
    }
}
