<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>

<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <title>Profile</title>
        <link rel="stylesheet" href="<c:url value='/css/index.css' />">
        <link rel="stylesheet" href="<c:url value='/css/user/auth.css' />">
    </head>
    <body>
 		<jsp:include page="/WEB-INF/views/fragments/user-navbar.jsp" />
 		
		<div class="auth-wrapper">
			<c:if test="${not empty message}">
				<div class="no-items-message">${message}</div>
			</c:if>
			
			<div class="auth-card">
	    		<h2 class="auth-title">Sign Up</h2>
				<form:form class="auth-form" modelAttribute="user" action="./my-profile">
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
				    <form:input id="username" path="username" title="Username" readonly="true" />
				
				    <label for="email">Email:</label>
				    <form:input id="email" path="email" type="email" required="true" title="Enter email" />
				    <form:errors path="email" cssClass="form-error" />
				
				    <label for="phone">Phone Number:</label>
				    <form:input id="phone" path="phone" type="tel" required="true" title="1234567890" pattern="^\d{10}$" />
				
				    <button type="submit" class="btn-primary">Update</button>
				    
				    <c:if test="${error != null}">
	                    <p class="auth-error">${error}</p>
	                </c:if>
				</form:form>
			</div>
		</div>
    </body>
</html>
