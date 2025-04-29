<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>Manage Users</title>
		<link rel="stylesheet" href="<c:url value='/css/index.css' />">
		<link rel="stylesheet" href="<c:url value='/css/admin/adminView.css' />">
	</head>
	<body>
		<jsp:include page="/WEB-INF/views/fragments/admin-navbar.jsp" />
	
		<div class="admin-view">
    		<h2>All Users</h2>

		    <table class="admin-table">
		        <thead>
		            <tr>
		                <th>User ID</th>
		                <th>First Name</th>
		                <th>Last Name</th>
		                <th>Email</th>
		                <th>Phone</th>
		                <th>Active?</th>
		            </tr>
		        </thead>
		        <tbody>
		            <c:forEach var="user" items="${users}">
		                <tr>
		                    <td>${user.userId}</td>
		                    <td>${user.firstName}</td>
		                    <td>${user.lastName}</td>
		                    <td>${user.email}</td>
		                    <td>${user.phone}</td>
		                   	<td>
						   		<input class="status-toggle" type="checkbox" ${user.active ? "checked" : ""} data-id="${user.userId}"
						   		data-update-url="<c:url value='/admin/manage-users/update-status' />" />
							</td>
		                </tr>
	            	</c:forEach>
       			</tbody>
   			</table>
		</div>	
		<script src="<c:url value='/js/adminView.js' />"></script>
	</body>
</html>