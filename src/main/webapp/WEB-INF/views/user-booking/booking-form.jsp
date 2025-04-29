<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>

<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <title>Book A Ride</title>
        <link rel="stylesheet" href="<c:url value='/css/index.css' />">
        <link rel="stylesheet" href="<c:url value='/css/user-booking/bookingForm.css' />">
    </head>
    <body>
    	<jsp:include page="/WEB-INF/views/fragments/user-navbar.jsp" />

        <section class="booking-page">
	        <div class="booking-card">
	            <div class="booking-car-info">
	                <img src="<c:url value='/images/${car.imgURL}' />" alt="${car.make} ${car.model}" class="car-img">
	                <div class="car-details">
	                    <h2>${car.make} ${car.model}</h2>
	                    <p>${car.fuel} | ${car.seats} seats | $<span id="rate">${car.rate}</span>/hr</p>
	                    <div class="car-rating">
	                        <c:forEach begin="1" end="5" var="i">
	                            <span class="star ${i <= car.rating ? 'filled' : ''}">★</span>
	                        </c:forEach>
	                    </div>
	                </div>
	            </div>
	            
	            <c:if test="${car.active}">
		            <ol class="note">
		            	<li>Cars can be booked 15 days in advance and for a maximum of 30 days from the date of booking.</li>
		            	<li>For same day bookings please visit the center.</li>
		            </ol>
		         
		           	<%
		           		java.time.LocalDate todayDate = java.time.LocalDate.now();
				    	request.setAttribute("minFromDate", todayDate.plusDays(1).toString());
				    	request.setAttribute("maxFromDate", todayDate.plusDays(15).toString());
					%>
		            <form:form class="booking-form" modelAttribute="booking" action="${pageContext.request.contextPath}/bookings/create-booking">
		            	<div class="date-group">
		            		<div>
			            		<label for="fromDate">From:</label><br />
						    	<form:input id="fromDate" path="fromDate" type="date" required="true" min="${minFromDate}" max="${maxFromDate}" title="From Date" />
		            		</div>
		            	
			            	<div>
		            			<label for="toDate">To:</label><br />
						    	<form:input id="toDate" path="toDate" type="date" required="true" disabled="true" title="To Date" />
			            	</div>
		            	</div>
		            	<div class="booking-summary">
			            	<p>Booked Days: <span id="day-count"></span></p>
							<p>Amount: $<span id="total-amount"></span></p>
		            	</div>	            						
					    <label for="paymentMethod">Payment Method</label>
					    <form:select path="paymentMethod" id="paymentMethod" required="true" title="Please select payment method." >
					        <form:option value="" label="-- Select Payment Method --" />
					        <form:option value="Card" />
					        <form:option value="Apple Pay" />
					        <form:option value="PayPal" />
					    </form:select>
					
					    <div class="booking-actions">
					        <button type="submit" class="btn-primary">Confirm Booking</button>
					        <a href="<c:url value='/cars' />" class="btn-secondary">Cancel</a>
					    </div>
		            </form:form>
	            </c:if>	  
	            
	            <c:if test="${!car.active}">
	            	<p class="note">${error}</p>
	            </c:if>          
	        </div>
	    </section>
	    
	    <script src="<c:url value='/js/bookingForm.js' />"></script>
    </body>
</html>
