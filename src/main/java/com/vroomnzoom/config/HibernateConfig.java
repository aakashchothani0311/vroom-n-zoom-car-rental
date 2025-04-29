package com.vroomnzoom.config;

import java.util.Properties;

import org.hibernate.SessionFactory;
import org.hibernate.boot.MetadataSources;
import org.hibernate.boot.registry.StandardServiceRegistryBuilder;
import org.hibernate.service.ServiceRegistry;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;

import com.vroomnzoom.model.Booking;
import com.vroomnzoom.model.Car;
import com.vroomnzoom.model.User;

@Configuration
public class HibernateConfig {

    @Bean
    SessionFactory sessionFactory() {
		Properties hibernateProps = new Properties();
        hibernateProps.put("hibernate.connection.driver_class", "com.mysql.cj.jdbc.Driver");
        hibernateProps.put("hibernate.connection.url", "jdbc:mysql://localhost:3306/vroom_n_zoom_carrentaldb");
        hibernateProps.put("hibernate.connection.username", "vroom_n_zoom_dbuser");
        hibernateProps.put("hibernate.connection.password", "csye6220_vroom");
        //hibernateProps.put("hibernate.dialect", "org.hibernate.dialect.MySQLDialect");
       // hibernateProps.put("hibernate.show_sql", "true");
        hibernateProps.put("hibernate.format_sql", "true");
        
        ServiceRegistry serviceRegistry = new StandardServiceRegistryBuilder().applySettings(hibernateProps).build();
        
        return new MetadataSources(serviceRegistry)
        					.addAnnotatedClass(Booking.class)
        					.addAnnotatedClass(Car.class)
        					.addAnnotatedClass(User.class)
        					.buildMetadata()
        					.buildSessionFactory();
	}
}
