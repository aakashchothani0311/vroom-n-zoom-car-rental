package com.vroomnzoom.dao;

import java.util.List;

import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.springframework.stereotype.Repository;

import com.vroomnzoom.model.User;

import jakarta.persistence.TypedQuery;

@Repository
public class UserDAO {
	
	private final SessionFactory sessionFactory;
	
	public UserDAO(SessionFactory sessionFactory) {
		this.sessionFactory = sessionFactory;
	}
	
    public List<User> getAllNonAdminUsers(){
    	try(Session session = sessionFactory.openSession()){
    		TypedQuery<User> tq = session.createQuery("FROM User WHERE role != 'admin'", User.class);
            return tq.getResultList();
    	} catch (Exception ex) {
    		System.out.println("Error in getUserByCreds: " + ex);
    		return null;
    	}
    }
	
	public User getUserById(int id) {
    	try(Session session = sessionFactory.openSession()){
    		TypedQuery<User> tq = session.createQuery("FROM User WHERE id = :id", User.class);
            tq.setParameter("id", id);
            return tq.getSingleResultOrNull();
    	} catch (Exception ex) {
    		System.out.println("Error in getUserByCreds: " + ex);
    		return null;
    	}
	}
    
    public User getUserByCreds(String username, String password){
    	try(Session session = sessionFactory.openSession()){
    		TypedQuery<User> tq = session.createQuery("FROM User WHERE username = :username AND password = :password AND active = true", User.class);
            tq.setParameter("username", username);
            tq.setParameter("password", password);
            return tq.getSingleResultOrNull();
    	} catch (Exception ex) {
    		System.out.println("Error in getUserByCreds: " + ex);
    		return null;
    	}
    }
    
    public List<User> getUserByUsernameEmail(String username, String email) {
    	try(Session session = sessionFactory.openSession()){
    		TypedQuery<User> tq = session.createQuery("FROM User WHERE username = :username OR email = :email", User.class);
            tq.setParameter("username", username);
            tq.setParameter("email", email);
            return tq.getResultList();
    	} catch (Exception ex) {
    		System.out.println("Error in getUserByUsernameEmail: " + ex);
    		return null;
    	}
    }
    
    public void createUser(User user) {
    	Session session = sessionFactory.openSession();
		try{
			session.beginTransaction();
			session.persist(user);
			session.getTransaction().commit();
		} catch (Exception ex) {
			session.getTransaction().rollback();
			throw ex;
		} finally {
			session.close();
		}
    }
    
    public User updateUser(User user) {
        Session session = sessionFactory.openSession();
        try{
			session.beginTransaction();
			User updatedUser = session.merge(user);
			session.getTransaction().commit();
			return updatedUser;
		} catch (Exception ex) {
			System.out.println("Error in updateUser: " + ex);
			session.getTransaction().rollback();
			return null;
		} finally {
			session.close();
		}
    }
}