<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <title>View All Cars</title>
        <link rel="stylesheet" href="<c:url value='/css/index.css' />">
       	<link rel="stylesheet" href="<c:url value='/css/cars/showCars.css' />">
    </head>
    <body>
    	<jsp:include page="/WEB-INF/views/fragments/user-navbar.jsp" />
	    
        <section class="car-listing-wrapper">
        	<h2 class="car-listing-title">Choose a ride that suits your needs</h2>
	        <div class="car-grid">
	            <c:forEach items="${cars}" var="car">
	                <div class="car-card-portrait">
	                	<div class="${!car.active ? 'disabled' : ''}">
		                	<div class="car-img-wrapper">
			                    <img class="car-img" src="<c:url value='/images/${car.imgURL}' />" alt="${car.make} ${car.model}">	                    
		        			</div>
			        			
		        			<div>
			        			<h3 class="car-title">${car.make} ${car.model}</h3>
			                    <p class="car-meta">
		        					${car.fuel} | ${car.seats} seats | $${car.rate}/hr
		    					</p>
		    					
			                    <div class="car-rating">
			                        <c:forEach begin="1" end="5" var="i">
			                            <span class="star ${i <= car.rating ? 'filled' : ''}">★</span>
			                        </c:forEach>
			                    </div>
			
			                    <div class="car-card-actions-inline">
			                        <a href="<c:url value='/cars/${car.carId}' />" class="btn-secondary">View</a>
			                        <a href="<c:url value='/bookings/new-booking/${car.carId}' />" class="btn-primary">Book</a>
			                    </div>
		        			</div>
		        		</div> 
		        		<c:if test="${!car.active}">
		            		<span class="badge-unavailable">Unavailable</span>
		        		</c:if>          
	                </div>
	            </c:forEach>
	        </div>
    	</section>
    </body>
</html>
