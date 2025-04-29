<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>Booking Status</title>
		<link rel="stylesheet" href="<c:url value='/css/index.css' />">
		<link rel="stylesheet" href="<c:url value='/css/user-booking/bookingStatus.css' />">
	</head>
	<body>
	    <jsp:include page="/WEB-INF/views/fragments/user-navbar.jsp" />
           	
       	<section class="booking-status">
    		<div class="confirmation-box">
		        <h2 class="success-message">🎉 Booking Confirmed!</h2>
		        <p class="confirmation-text">Your ride is reserved. Here are the booking details:</p>
		        <div class="booking-summary-card">
		        	<div class="summary-highlight">
						${booking.car.make} ${booking.car.model} <span class="car-fuel">(${booking.car.fuel})</span>
    				</div>
				    <div class="summary-row">
				        <span class="summary-label">Plate No.:</span>
				        <span class="summary-value">${booking.car.plateNo}</span>
				    </div>
				    <div class="summary-row">
				        <span class="summary-label">Booking Dates:</span>
				        <span class="summary-value">
				        	<fmt:formatDate value="${booking.fromDateUtil}" pattern="dd MMMM, yyyy" /> – 
				        	<fmt:formatDate value="${booking.toDateUtil}" pattern="dd MMMM, yyyy" />
				        </span>
				    </div>
				    <div class="summary-row">
				        <span class="summary-label">Amount Paid:</span>
				        <span class="summary-value">$${booking.paymentAmount}</span>
				    </div>
				    <div class="summary-row">
				        <span class="summary-label">Payment Method:</span>
				        <span class="summary-value">${booking.paymentMethod}</span>
				    </div>
		        </div>
		        <p class="redirect-note">
    				Redirecting you to your bookings in <span id="countdown" data-url="<c:url value='/bookings/my-bookings' />">5</span> seconds...
    				<a href="<c:url value='/bookings/my-bookings' />">Go now</a>
				</p>
    		</div>
		</section>
		<script src="<c:url value='/js/bookingStatus.js' />"></script>
	</body>
</html>