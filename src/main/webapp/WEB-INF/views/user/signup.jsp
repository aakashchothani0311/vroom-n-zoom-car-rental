<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>

<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>Sign Up</title>
		<link rel="stylesheet" href="<c:url value='/css/index.css' />">
        <link rel="stylesheet" href="<c:url value='/css/user/auth.css' />">
	</head>
	<body>
		<div class="auth-wrapper">
			<div class="auth-card">
		    	<h2 class="auth-title">Sign Up</h2>
				<form:form class="auth-form" modelAttribute="user" action="./sign-up?source=${source}">
		
					<div class="name-group">
						<div>
							<label for="firstName">First Name:</label>
					    	<form:input id="firstName" path="firstName" required="true" title="Enter first name" />
						</div>
					    
						<div>
							<label for="lastName">Last Name:</label>
						    <form:input id="lastName" path="lastName" required="true" title="Enter last name" />
						</div>					    
					</div>
				
				    <label for="username">Username:</label>
				    <form:input id="username" path="username" required="true" title="Enter username" />
				    <form:errors path="username" cssClass="form-error" />
				
				    <label for="email">Email:</label>
				    <form:input id="email" path="email" type="email" required="true" title="Enter email" />
				    <form:errors path="email" cssClass="form-error" />
				
				    <label for="phone">Phone Number:</label>
				    <form:input id="phone" path="phone" type="tel" required="true" title="1234567890" pattern="^\d{10}$" />
				
				    <label for="password">Password:</label>
				    <form:password id="password" path="password" required="true" title="Enter password" />
				
				    <button type="submit" class="btn-primary">Sign Up</button>
				    
				    <c:if test="${error != null}">
	                    <p class="auth-error">${error}</p>
	                </c:if>
				</form:form>
		
		        <div class="auth-links">
		            <a href="<c:url value='/' />">Home</a>
		            <span>|</span>
		            <a href="<c:url value='/sign-in?source=${source}' />">Sign In</a>
				</div>
			</div>
		</div>
	</body>
</html>