package com.vroomnzoom.dao;

import java.util.List;

import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.springframework.stereotype.Repository;

import com.vroomnzoom.model.Booking;

import jakarta.persistence.TypedQuery;

@Repository
public class BookingDAO {
	
	private final SessionFactory sessionFactory;
	
	public BookingDAO(SessionFactory sessionFactory) {
		this.sessionFactory = sessionFactory;
	}
	
    public List<Booking> getAllBookings(){
    	try(Session session = sessionFactory.openSession()){
	        TypedQuery<Booking> tq = session.createQuery("FROM Booking ORDER BY fromDate ASC, toDate ASC", Booking.class);
	        return tq.getResultList();
    	} catch (Exception ex) {
    		System.out.println("Error in showAllBookings: " + ex);
    		return null;
    	}
    }
    
    public Booking getBookingById(int userId, int bookingId){
    	try(Session session = sessionFactory.openSession()){
	        TypedQuery<Booking> tq = session.createQuery("FROM Booking b WHERE b.customer.userId = :userId AND b.bookingId = :bookingId", Booking.class);
	        tq.setParameter("userId", userId);
	        tq.setParameter("bookingId", bookingId);
	        return tq.getSingleResultOrNull();
    	} catch (Exception ex) {
    		System.out.println("Error in showBookingsById: " + ex);
    		return null;
    	}   
    }
    
    public List<Booking> getBookingsByUserId(int userId){
    	try(Session session = sessionFactory.openSession()){
	        TypedQuery<Booking> tq = session.createQuery("FROM Booking b WHERE b.customer.userId = :userId", Booking.class);
	        tq.setParameter("userId", userId);
	        return tq.getResultList();
    	} catch (Exception ex) {
    		System.out.println("Error in showBookingsByUserId: " + ex);
    		return null;
    	}   
    }
    
    public void createBooking(Booking booking) {
    	Session session = sessionFactory.openSession();
		try{
			session.beginTransaction();
			session.persist(booking);
			session.getTransaction().commit();
		} catch (Exception ex) {
			System.out.println("Error in createBooking: " + ex);
			session.getTransaction().rollback();
		} finally {
			session.close();
		}
    }
    
    public Booking cancelBooking(Booking booking) {
        Session session = sessionFactory.openSession();
        try{
			session.beginTransaction();
			Booking updatedBooking = session.merge(booking);
			session.getTransaction().commit();
			return updatedBooking;
		} catch (Exception ex) {
			System.out.println("Error in cancelBooking: " + ex);
			session.getTransaction().rollback();
			return null;
		} finally {
			session.close();
		}
    }
}
