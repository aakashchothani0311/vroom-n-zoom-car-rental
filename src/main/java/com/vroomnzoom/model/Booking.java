package com.vroomnzoom.model;

import java.time.LocalDate;

import com.fasterxml.jackson.annotation.JsonIgnoreProperties;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.JoinColumn;
import jakarta.persistence.ManyToOne;
import jakarta.persistence.Table;

@Entity
@Table(name = "bookings")
public class Booking {
    
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private int bookingId;
    
    @ManyToOne
    @JoinColumn(name = "userId", nullable = false)
    @JsonIgnoreProperties("bookings")
    private User customer;
    
    @ManyToOne
    @JoinColumn(name = "carId", nullable = false)
    @JsonIgnoreProperties("bookings")
    private Car car;
    
    @Column(nullable = false) private LocalDate fromDate; 
    @Column(nullable = false) private LocalDate toDate;
    @Column(nullable = false) private float paymentAmount;
    @Column(nullable = false) private String paymentMethod;
    @Column(nullable = false) private String bookingStatus;
    @Column(nullable = false) private LocalDate bookingDate;
    @Column private LocalDate cancelledDate;
    
    public Booking() {}

    public int getBookingId() {
        return bookingId;
    }

    public void setBookingId(int bookingId) {
        this.bookingId = bookingId;
    }

    public User getCustomer() {
        return customer;
    }

    public void setCustomer(User customer) {
        this.customer = customer;
    }

    public Car getCar() {
        return car;
    }

    public void setCar(Car car) {
        this.car = car;
    }

    public LocalDate getFromDate() {
        return fromDate;
    }

    public void setFromDate(LocalDate fromDate) {
        this.fromDate = fromDate;
    }

    public LocalDate getToDate() {
        return toDate;
    }

    public void setToDate(LocalDate toDate) {
        this.toDate = toDate;
    }
    
    public float getPaymentAmount() {
		return paymentAmount;
	}

	public void setPaymentAmount(float paymentAmount) {
		this.paymentAmount = paymentAmount;
	}

	public String getPaymentMethod() {
        return paymentMethod;
    }

    public void setPaymentMethod(String paymentMethod) {
        this.paymentMethod = paymentMethod;
    }
    
    public String getBookingStatus() {
        return bookingStatus;
    }

    public void setBookingStatus(String bookingStatus) {
        this.bookingStatus = bookingStatus;
    }

	public LocalDate getBookingDate() {
		return bookingDate;
	}

	public void setBookingDate(LocalDate bookingDate) {
		this.bookingDate = bookingDate;
	}

	public LocalDate getCancelledDate() {
		return cancelledDate;
	}

	public void setCancelledDate(LocalDate cancelledDate) {
		this.cancelledDate = cancelledDate;
	}
	
	public java.util.Date getFromDateUtil() {
	    return java.sql.Date.valueOf(fromDate);
	}

	public java.util.Date getToDateUtil() {
	    return java.sql.Date.valueOf(toDate);
	}
	
	public java.util.Date getBookingDateUtil() {
	    return java.sql.Date.valueOf(bookingDate);
	}
	
	public java.util.Date getCancelledDateUtil() {
	    return java.sql.Date.valueOf(bookingDate);
	}
}
