package com.vroomnzoom.controller;

import java.time.LocalDate;
import java.time.temporal.ChronoUnit;
import java.util.List;

import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.vroomnzoom.dao.BookingDAO;
import com.vroomnzoom.dao.CarDAO;
import com.vroomnzoom.model.Booking;
import com.vroomnzoom.model.Car;
import com.vroomnzoom.model.User;

import jakarta.servlet.http.HttpSession;

@Controller
@RequestMapping("/bookings")
public class BookingController {
    
	private final BookingDAO bookingDAO;
	private final CarDAO carDAO;
	
    public BookingController(BookingDAO bookingDAO, CarDAO carDAO){
    	this.bookingDAO = bookingDAO;
    	this.carDAO = carDAO;
    }
    
    @GetMapping("/my-bookings")
    public ModelAndView showMyBookings(HttpSession session){
        User user = (User) session.getAttribute("user");
        List<Booking> bookings = bookingDAO.getBookingsByUserId(user.getUserId());
        
        if(bookings.size() > 0)
        	return new ModelAndView("user-booking/show-bookings", "bookings", bookings);
        else
        	return new ModelAndView("user-booking/show-bookings", "noBookingsMessage", "You do not have any bookings.");
    }
    
    @GetMapping("/new-booking/{id}")
    public ModelAndView bookACar(@PathVariable("id") int carId, @ModelAttribute Booking booking, HttpSession session){
    	Car car = carDAO.getCarById(carId);
    	
    	if(car == null)
    		return new ModelAndView("error");
    	else {
        	ModelAndView mav = new ModelAndView("user-booking/booking-form");
    		mav.addObject("car", car);
    		
    		if(car.isActive()) {
    			mav.addObject("booking", booking);
    			session.setAttribute("carToBook", car);
    		}	
	    	else
	    		mav.addObject("error", "This car is currently not available.");
    		
    		return mav;
    	}
    }
    
    @PostMapping("/create-booking")
    public ModelAndView createBooking(@ModelAttribute Booking booking, HttpSession session){
    	User user = (User) session.getAttribute("user");
    	Car car = (Car) session.getAttribute("carToBook");

    	if(user != null && car != null) {
    		booking.setCustomer(user);
    		booking.setCar(car);
        	booking.setBookingStatus("confirmed");
        	booking.setBookingDate(LocalDate.now());
        	
            long numOfDays = ChronoUnit.DAYS.between(booking.getFromDate(), booking.getToDate()) + 1;
        	float bookingAmount = numOfDays * car.getRate() * 24;
        	booking.setPaymentAmount(bookingAmount);
        	
            bookingDAO.createBooking(booking);
        	session.removeAttribute("carToBook");
           	return new ModelAndView("user-booking/booking-status", "booking", booking);
    	} else
    		return new ModelAndView("error");   	
    }
    
    @PostMapping("/cancel/{id}")
    @ResponseBody
    public ResponseEntity<Booking> cancelBooking(@PathVariable("id") int bookingId, HttpSession session) {
    	User user = (User) session.getAttribute("user");
    	try {
            Booking booking = bookingDAO.getBookingById(user.getUserId(), bookingId);
            
            if(booking != null) {
            	 booking.setBookingId(bookingId);
                 booking.setBookingStatus("cancelled");
                 booking.setCancelledDate(LocalDate.now());
                 
                 Booking updatedBooking = bookingDAO.cancelBooking(booking);
                 return ResponseEntity.ok(updatedBooking);    	
            } else
            	return ResponseEntity.status(403).build();
    	} catch (Exception ex) {
    		System.out.println("Error in cancelBookingCont: " + ex);
    	    return ResponseEntity.status(500).build();
    	}
    }
}
