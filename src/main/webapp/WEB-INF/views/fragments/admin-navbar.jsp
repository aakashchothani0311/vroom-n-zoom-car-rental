<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<nav class="navbar">
    <div class="nav-left">
        <h1 class="logo">Vroom-N-Zoom</h1>
        <a href="<c:url value='/admin/manage-bookings' />" class="nav-link">Manage Bookings</a>
        <a href="<c:url value='/admin/manage-cars' />" class="nav-link">Manage Cars</a>
		<a href="<c:url value='/admin/manage-users' />" class="nav-link">Manage Users</a>
    </div>
    <div class="nav-right">
        <c:if test="${empty sessionScope.user}">
     		<a href="<c:url value='/sign-in' />" class="nav-link nav-auth">Sign In / Sign Up</a>
    	</c:if>
    	<c:if test="${not empty sessionScope.user}">
     		<a href="<c:url value='/logout' />" class="nav-link nav-auth">Logout</a>
    	</c:if>
    </div>
</nav>