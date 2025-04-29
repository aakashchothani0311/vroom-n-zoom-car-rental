<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>Thank You</title>
		<link rel="stylesheet" href="<c:url value='/css/index.css' />">
		<link rel="stylesheet" href="<c:url value='/css/user/logout.css' />">
	</head>
	<body>
		<div class="logout-container">
			<div class="logout-card">
				<h1>You've been logged out</h1>
				<p>Thanks for using Vroom-N-Zoom! We hope to see you again soon.</p>
				<a href="<c:url value='/' />" class="btn-primary">Back to Home</a>
			</div>
		</div>
	</body>
</html>
