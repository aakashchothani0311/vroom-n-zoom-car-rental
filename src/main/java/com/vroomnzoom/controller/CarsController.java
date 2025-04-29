package com.vroomnzoom.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import com.vroomnzoom.dao.CarDAO;
import com.vroomnzoom.model.Car;

@Controller
@RequestMapping("/cars")
public class CarsController {
    
    private final CarDAO carDAO;
    
    public CarsController(CarDAO carDAO) {
    	this.carDAO = carDAO;
    }
    
    @GetMapping
    public ModelAndView showAllCars(){
        return new ModelAndView("car/show-cars", "cars", carDAO.getAllCars());
    }
    
    @GetMapping("/{id}")
    public ModelAndView showCarDetail(@PathVariable("id") int carId){
        Car car = carDAO.getCarById(carId);
        
        if(car == null)
            return new ModelAndView("car/show-car-detail", "error", "Car not found.");
        else
            return new ModelAndView("car/show-car-detail", "car", car);
    }
}
