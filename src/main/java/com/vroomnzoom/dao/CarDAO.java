package com.vroomnzoom.dao;

import java.util.List;

import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.springframework.stereotype.Repository;

import com.vroomnzoom.model.Car;

import jakarta.persistence.TypedQuery;

@Repository
public class CarDAO {
	
	private final SessionFactory sessionFactory;
	
	public CarDAO(SessionFactory sessionFactory) {
		this.sessionFactory = sessionFactory;
	}
    
    public List<Car> getAllCars(){
    	try(Session session = sessionFactory.openSession()){
	        TypedQuery<Car> tq = session.createQuery("FROM Car", Car.class);
	        return tq.getResultList();
    	} catch (Exception ex) {
    		System.out.println("Error in getAllCars: " + ex);
    		return null;
    	}
    }
    
    public Car getCarById(int id){
    	try(Session session = sessionFactory.openSession()){
	        TypedQuery<Car> tq = session.createQuery("FROM Car WHERE id = :id", Car.class);
	        tq.setParameter("id", id);
	        return tq.getSingleResultOrNull();
    	} catch (Exception ex) {
    		System.out.println("Error in getCarById: " + ex);
    		return null;
    	}
    }
    
    public Car updateCar(Car car) {
        Session session = sessionFactory.openSession();
        try{
			session.beginTransaction();
			Car updatedCar = session.merge(car);
			session.getTransaction().commit();
			return updatedCar;
		} catch (Exception ex) {
			System.out.println("Error in updateCar: " + ex);
			session.getTransaction().rollback();
			return null;
		} finally {
			session.close();
		}
    }
}
