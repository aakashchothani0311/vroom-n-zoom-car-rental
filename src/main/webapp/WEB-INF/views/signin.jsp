<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <title>Sign In</title>
        <link rel="stylesheet" href="<c:url value='/css/index.css' />">
        <link rel="stylesheet" href="<c:url value='/css/user/auth.css' />">
    </head>
    <body>
	    <div class="auth-wrapper">
	        <div class="auth-card">
	            <h2 class="auth-title">Sign In</h2>
	            <form class="auth-form" action="./sign-in?source=${source}" method="POST">
	                <label for="username">Username:</label>
	                <input id="username" name="username" required title="Enter username" />
	
	                <label for="password">Password:</label>
	                <input id="password" name="password" type="password" required title="Enter password" />
	
	                <button type="submit" class="btn-primary">Sign In</button>
	
	                <c:if test="${error != null}">
	                    <p class="auth-error">${error}</p>
	                </c:if>
	            </form>
	
	            <div class="auth-links">
	                <a href="<c:url value='/' />">Home</a>
	                <span>|</span>
	                <a href="<c:url value='/sign-up?source=${source}' />">Sign Up</a>
	            </div>
	        </div>
	    </div>
    </body>
</html>
