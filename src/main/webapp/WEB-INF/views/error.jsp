<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page isErrorPage="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>Page not found</title>
		<link rel="stylesheet" href="<c:url value='/css/index.css' />">
		<link rel="stylesheet" href="<c:url value='/css/error.css' />">
	</head>
	<body>
		<section class="error-wrapper">
			<div class="error-container">
				<c:set var="statusCode" value="${requestScope['jakarta.servlet.error.status_code']}" />
		        <c:choose>
		            <c:when test="${statusCode == 401}">
						<h1>Unauthorized</h1>
						<p>Looks like you need to log in first. Go ahead and sign in to continue.</p>
						<div>
							<a href="<c:url value='/sign-in' />" class="btn-primary">Sign In / Sign Up</a>
							<a href="<c:url value='/' />" class="btn-primary">Return to Home</a>
						</div>	
		            </c:when>
		
		            <c:when test="${statusCode == 403}">
						<h1>Access Denied</h1>
						<p>This page is off-limits! You don't have the magic key to enter here.</p>
		                <a href="<c:url value='/' />" class="btn-primary">Return to Home</a>
		            </c:when>
		
		            <c:when test="${statusCode == 404}">
						<h1>404 - Lost in the Web</h1>
						<p>We couldn't find the page you're looking for. It's either gone or never existed. Try the homepage!</p>
		                <a href="<c:url value='/' />" class="btn-primary">Return to Home</a>
		            </c:when>
		
		            <c:when test="${statusCode == 500}">
						<h1>Oops, Something Went Wrong!</h1>
						<p>Our server is having a bad day. We're working on it, so try again soon!</p>
		                <a href="<c:url value='/' />" class="btn-primary">Return to Home</a>
		            </c:when>
		
		            <c:otherwise>
						<h1>Whoops! Something Went Wrong...</h1>
						<p>We couldn't quite figure out what happened. But don't worry, we're on it!</p>
		              	<a href="<c:url value='/' />" class="btn-primary">Return to Home</a>
		            </c:otherwise>
		        </c:choose>
	    	</div>
    	</section>
	</body>
</html>