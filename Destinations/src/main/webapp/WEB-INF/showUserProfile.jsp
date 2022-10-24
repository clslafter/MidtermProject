<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>User Profile</title>
<jsp:include page="bootstrapHead.jsp" />
</head>
<body>
<jsp:include page="navbar.jsp" />
<H1>Welcome, ${user.firstName}</H1>

<!-- more user profile fields go here -->

	<c:if test="${isAdmin}">
		<a href="showAllUsers.do">Show all users</a><br>
	</c:if>

	<h1>Manage My Destinations: </h1>
	<c:forEach items="${user.destinations}" var="destination"> 
		<ul>
			
			<li>${destination.id}</li>
			<li>${destination.name}</li>
			<li>${destination.description}</li>
			<li>${destination.websiteUrl}</li>
			<li>${destination.imageUrl}</li>
			<li>${destination.createDate}</li>
			<li>${destination.lastEdited}</li>
		</ul>
	</c:forEach>

	<form action="updateAccount.do" action="POST">
		<input type="hidden" name="id" value="${user.id}" /> 
		<input type="submit" value="Edit My Profile" class="btn btn-primary" />
	</form> <br>
	
	<form action="deleteAccount.do" action="POST">
		<input type="hidden" name="id" value="${user.id}" /> 
		<input type="submit" value="Delete My Account" class="btn btn-primary" />
	</form> <br>
<jsp:include page="bootstrapFoot.jsp" />
</body>
</html>