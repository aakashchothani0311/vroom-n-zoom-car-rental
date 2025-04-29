<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <title>Welcome to Vroom-N-Zoom</title>
        <link rel="stylesheet" href="<c:url value='/css/index.css' />">
        <link rel="stylesheet" href="<c:url value='/css/hero.css' />">
    </head>
    <body>
    	<jsp:include page="/WEB-INF/views/fragments/user-navbar.jsp" />
        
        <section class="hero">
            <h2>Welcome to Vroom-N-Zoom Car Rental Platform!</h2>
            <p>Your one-stop solution for easy and quick car rentals.</p>
            <div class="hero-images">
                <img src="<c:url value='/images/cars/car5.png' />" alt="Car 1">
                <img src="<c:url value='/images/cars/car6.png' />" alt="Car 2">
                <img src="<c:url value='/images/cars/car7.png' />" alt="Car 3">
            </div>
        </section>
    </body>
</html>
