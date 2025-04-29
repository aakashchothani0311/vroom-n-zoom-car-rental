<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>Manage Cars</title>
		<link rel="stylesheet" href="<c:url value='/css/index.css' />">
		<link rel="stylesheet" href="<c:url value='/css/admin/adminView.css' />">
	</head>
	<body>
		<jsp:include page="/WEB-INF/views/fragments/admin-navbar.jsp" />
	
		<div class="admin-view">
    		<h2>All Cars</h2>

		    <table class="admin-table">
		        <thead>
		            <tr>
		                <th>Car ID</th>
		                <th>Make</th>
		                <th>Model</th>
		                <th>Plate No.</th>
		                <th>Seats</th>
		                <th>Fuel</th>
		                <th>Per hour Rate ($)</th>
		                <th>Rating</th>
		                <th>Status</th>
		            </tr>
		        </thead>
		        <tbody>
		            <c:forEach var="car" items="${cars}">
		                <tr>
		                    <td>${car.carId}</td>
		                    <td>${car.make}</td>
		                    <td>${car.model}</td>
		                    <td>${car.plateNo}</td>
		                    <td>${car.seats}</td>
		                    <td>${car.fuel}</td>
		                    <td>${car.rate}</td>
		                    <td>${car.rating}</td>
		                   	<td>
						   		<input class="status-toggle" type="checkbox" ${car.active ? "checked" : ""} data-id="${car.carId}"
						   		data-update-url="<c:url value='/admin/manage-cars/update-status' />" />
							</td>
		                </tr>
	            	</c:forEach>
       			</tbody>
   			</table>
		</div>	
		<script src="<c:url value='/js/adminView.js' />"></script>
	</body>
</html>