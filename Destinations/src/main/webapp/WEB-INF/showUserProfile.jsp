<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>User Profile</title>
</head>
<body>
<H1>Welcome, ${user.firstName}</H1>

<!-- more user profile fields go here -->

<c:if test="${isAdmin}">
<a href="showAllUsers.do">Show all users</a><br>
</c:if>

<a href="updateAccount.do?uid=${user.id}">Update profile</a><br>

<a href="home.do">Home</a>

<a href="logout.do">Log Out</a>
</body>
</html>