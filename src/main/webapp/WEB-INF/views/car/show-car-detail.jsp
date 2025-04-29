<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <title>${car.make} - ${car.model}</title>
        <link rel="stylesheet" href="<c:url value='/css/index.css' />">
		<link rel="stylesheet" href="<c:url value='/css/cars/showCarDetail.css' />">
    </head>
    <body>
    	<jsp:include page="/WEB-INF/views/fragments/admin-navbar.jsp" />
   
		<div class="car-detail-wrapper">
		   	<c:if test="${not empty error}">
	    		<div class="no-items-message">
	    			${error}
	    		</div>
    		</c:if>
		    <c:if test="${not empty car}">
		    	<div class="car-detail-container">
			        <div class="car-image-section">
			            <img src="<c:url value='/images/${car.imgURL}' />" alt="${car.make} ${car.model}" />
			        </div>
			        <div class="car-info-section">
			            <h1>${car.make} ${car.model}</h1>
			            <p class="rate">$${car.rate}/hr</p>
			            <p>${car.fuel} | ${car.seats} seats</p>
			            <p class="status ${car.active ? 'available' : 'unavailable'}">
			                ${car.active ? 'Available' : 'Unavailable'}
			            </p>
			            <div class="car-rating">
			                <c:forEach begin="1" end="5" var="i">
			                    <span class="star ${i <= car.rating ? 'filled' : ''}">★</span>
			                </c:forEach>
			            </div>
			            <c:if test="${car.active}">
					    	<a href="<c:url value='/bookings/new-booking/${car.carId}' />" class="btn-primary">Book</a>
			            </c:if>
			        </div>
		    	</div>
    		</c:if>
		</div>
    </body>
</html>
