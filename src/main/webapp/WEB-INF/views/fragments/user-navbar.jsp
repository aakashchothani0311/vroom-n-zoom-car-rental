<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<nav class="navbar">
    <div class="nav-left">
        <h1 class="logo">Vroom-N-Zoom</h1>
        <a href="<c:url value='/' />" class="nav-link">Home</a>
        <a href="<c:url value='/cars' />" class="nav-link">View Cars</a>
        <a href="<c:url value='/bookings/my-bookings' />" class="nav-link">My Bookings</a>
    </div>
    <div class="nav-right">
        <c:if test="${empty sessionScope.user}">
     		<a href="<c:url value='/sign-in' />" class="nav-link nav-auth">Sign In / Sign Up</a>
    	</c:if>
    	<c:if test="${not empty sessionScope.user}">
    		<a href="<c:url value='/my-profile' />" class="nav-link">
  				<span class="nav-icon">👤</span>
			</a>
     		<a href="<c:url value='/logout' />" class="nav-link nav-auth">Logout</a>
    	</c:if>
    </div>
</nav>