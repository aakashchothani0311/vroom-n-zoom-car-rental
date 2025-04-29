<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>My Bookings</title>
		<link rel="stylesheet" href="<c:url value='/css/index.css' />">
		<link rel="stylesheet" href="<c:url value='/css/user-booking/showBookings.css' />">
	</head>
	<body>
		<jsp:include page="/WEB-INF/views/fragments/user-navbar.jsp" />
		 
		<h2 class="bookings-title">My Bookings</h2>
		
		<c:if test="${not empty noBookingsMessage}">
			<div class="no-items-message">
				${noBookingsMessage}
			</div>
		</c:if>
		
		<c:if test="${not empty bookings}">
			<%
			    java.time.LocalDate cutoffDate = java.time.LocalDate.now().plusDays(2);
			    request.setAttribute("cutoffDate", cutoffDate);
			%>
		
			<div class="bookings-container">
				<c:forEach items="${bookings}" var="booking">
					<div class="booking-card">
					    <div class="car-image">
					        <img src="<c:url value='/images/${booking.car.imgURL}' />" alt="${booking.car.make} ${booking.car.model}">
					    </div>
					
					    <div class="booking-content">
					        <div class="booking-header">
					            <h3 class="car-title">${booking.car.make} ${booking.car.model}</h3>
					            <span class="status-badge ${booking.bookingStatus}">${booking.bookingStatus}</span>
					        </div>
					
					        <div class="booking-details">
					        	<p class="plate-no">Plate No.: ${booking.car.plateNo}</p>
					        	<p class="plate-no">Fuel: ${booking.car.fuel}</p>
					        </div>
					
					        <div class="booking-details">
					            <p><strong>From:</strong> <fmt:formatDate value="${booking.fromDateUtil}" pattern="dd MMMM, yyyy" /></p>
					            <p><strong>To:</strong> <fmt:formatDate value="${booking.toDateUtil}" pattern="dd MMMM, yyyy" /></p>
					            <p><strong>Booked On:</strong> <fmt:formatDate value="${booking.bookingDateUtil}" pattern="dd MMMM, yyyy" /></p>
					        </div>
					        
					  		<div class="booking-details">
							    <p><strong>Payment:</strong> $${booking.paymentAmount} by ${booking.paymentMethod}</p>
							   
							    <c:if test="${booking.bookingStatus == 'cancelled'}">
							    	<p><strong>Cancelled On:</strong> <fmt:formatDate value="${booking.cancelledDateUtil}" pattern="dd MMMM, yyyy" /></p>
							    </c:if>

								<c:if test="${booking.bookingStatus == 'confirmed' and booking.fromDate >= cutoffDate}">
							    	<button class="btn-cancel" data-cancel-url="<c:url value='/bookings/cancel/${booking.bookingId}' />">Cancel</button>
							    </c:if>
							</div>
					    </div>
					</div>
				</c:forEach>
			</div>
		</c:if>
		<script src="<c:url value='/js/showBookings.js' />"></script>
	</body>
</html>