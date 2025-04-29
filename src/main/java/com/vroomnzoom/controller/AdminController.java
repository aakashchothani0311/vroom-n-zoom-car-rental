package com.vroomnzoom.controller;

import java.util.List;

import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.vroomnzoom.dao.BookingDAO;
import com.vroomnzoom.dao.CarDAO;
import com.vroomnzoom.dao.UserDAO;
import com.vroomnzoom.model.Booking;
import com.vroomnzoom.model.Car;
import com.vroomnzoom.model.User;

@Controller
@RequestMapping("/admin")
public class AdminController {
	
	private final BookingDAO bookingDAO;
	private final CarDAO carDAO;
	private final UserDAO userDAO;
	
	public AdminController (BookingDAO bookingDAO, CarDAO carDAO, UserDAO userDAO) {
		this.bookingDAO = bookingDAO;
		this.carDAO = carDAO;
		this.userDAO = userDAO;
	}
	
	@GetMapping("/manage-bookings")
	public ModelAndView showAllBookings() {
		List<Booking> allBookings = bookingDAO.getAllBookings();
		return new ModelAndView("admin/manage-bookings", "bookings", allBookings);
	}
	
	@GetMapping("/manage-cars")
	public ModelAndView manageCars() {
		List<Car> allCars = carDAO.getAllCars();
		return new ModelAndView("admin/manage-cars", "cars", allCars);
	}
	
	@PostMapping("/manage-cars/update-status/{id}")
	@ResponseBody
	public ResponseEntity<String> updateCarStatus(@PathVariable("id") int carId, @RequestParam boolean active) {
		try {
			Car car = carDAO.getCarById(carId);
			car.setActive(active);
			carDAO.updateCar(car);
			
			String msg = String.format("%s %s (Plate No: %s) is now %s to rent.", car.getMake(), car.getModel(), car.getPlateNo(), car.isActive() ? "available" : "unavailable");
			return ResponseEntity.ok(msg);
		} catch (Exception ex) {
    		System.out.println("Error in cancelBookingCont: " + ex);
    	    return ResponseEntity.status(500).build();
		}
	}
	
	@GetMapping("/manage-users")
	public ModelAndView showAllUsers() {
		List<User> allUsers = userDAO.getAllNonAdminUsers();
		return new ModelAndView("admin/manage-users", "users", allUsers);
	}
	
	@PostMapping("/manage-users/update-status/{id}")
	@ResponseBody
	public ResponseEntity<String> updateUserStatus(@PathVariable("id") int userId, @RequestParam boolean active) {
		try {
			User user = userDAO.getUserById(userId);
			user.setActive(active);
			userDAO.updateUser(user);
			
			String msg = String.format("User %s %s's is now %s.", user.getFirstName(), user.getLastName(), user.isActive() ? "active" : "inactive");
			return ResponseEntity.ok(msg);
		} catch (Exception ex) {
    		System.out.println("Error in cancelBookingCont: " + ex);
    	    return ResponseEntity.status(500).build();
		}
	}
}
