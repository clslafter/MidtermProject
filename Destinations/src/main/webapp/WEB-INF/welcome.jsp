<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Welcome Page</title>
</head>
<body>
<jsp:include page="navbar.jsp" />

<h1>Welcome to Travel Destinations</h1>
<h3>Where travelers discover and share exciting destinations</h3>

<!-- Insert Top Destination Teaser Here -->

<c:if test = "${user.enabled == false}">
${user.username}, Your Account has been deleted!
</c:if>

<a href="login.do">Log In</a>
<a href="createAccount.do">Create Account</a>
</body>
</html>