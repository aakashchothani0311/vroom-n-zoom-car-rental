<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>Manage Bookings</title>
		<link rel="stylesheet" href="<c:url value='/css/index.css' />">
		<link rel="stylesheet" href="<c:url value='/css/admin/adminView.css' />">
	</head>
	<body>
		<jsp:include page="/WEB-INF/views/fragments/admin-navbar.jsp" />
		
		<div class="admin-view">
	    	<h2>All Bookings</h2>
	
		    <table class="admin-table">
		        <thead>
		            <tr>
		                <th>Booking ID</th>
		                <th>Customer</th>
		                <th>Car</th>
		                <th>Plate No.</th>
		                <th>From</th>
		                <th>To</th>
		                <th>Payment ($)</th>
		                <th>Method</th>
		                <th>Booked On</th>
		                <th>Status</th>
		                <th>Cancelled On</th>
		            </tr>
		        </thead>
		        <tbody>
		            <c:forEach var="booking" items="${bookings}">
		                <tr>
		                    <td>${booking.bookingId}</td>
		                    <td>${booking.customer.firstName} ${booking.customer.lastName}</td>
		                    <td>${booking.car.make} ${booking.car.model}</td>
		                    <td>${booking.car.plateNo}</td>
		                    <td>${booking.fromDate}</td>
		                    <td>${booking.toDate}</td>
		                    <td>${booking.paymentAmount}</td>
		                    <td>${booking.paymentMethod}</td>
		                    <td>${booking.bookingDate}</td>
		                    <td>
		                        <span class="status-badge ${booking.bookingStatus}">${booking.bookingStatus}</span>
		                    </td>
		                    <td>
		                        <c:if test="${booking.bookingStatus == 'cancelled'}">
		                            ${booking.cancelledDate}
		                        </c:if>
		                    </td>
		                </tr>
		            </c:forEach>
        		</tbody>
    		</table>
		</div>
	</body>
</html>