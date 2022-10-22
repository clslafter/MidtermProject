<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
     <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>All Users</title>
</head>
<body>
<H1>List of all Users</H1>

Current Users:
	<c:forEach var="user" items="${users}">
	<li>${user.username}: ${user.firstName} ${user.lastName}</li>
	</c:forEach><br>
</body>
</html>