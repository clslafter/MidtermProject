<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Log in Page</title>
<jsp:include page="bootstrapHead.jsp" />
</head>
<body>
<jsp:include page="navbar.jsp" />

<h1>Log In</h1>

	<c:choose>
		<c:when test="${userError != null }" >
			<p style="font-weight: bold;">${userError}</p>
		</c:when>
	</c:choose>	
	<form action="login.do" method="POST">

		<label for="username">User Name:</label>
 		<input type="text" id="username" name="username" required><br>

		<label for="password">Password:</label>
 		<input type="password" id="password" name="password" required><br>
 	
 		<input type="submit" value="Log In">

	</form>
<jsp:include page="bootstrapFoot.jsp" />
</body>
</html>