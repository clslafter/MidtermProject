<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Delete Account</title>
<jsp:include page="bootstrapHead.jsp" />
</head>
<body>
<jsp:include page="navbar.jsp" />

	<form action="accountDeleted.do" method="GET">
		<h1>Delete Account</h1>
		
		<label for="id">Are you want to delete you account? </label>
		
		 <input name="id" value="${removeRestaurant.id}" type = hidden/> 
		 <input type="submit" value="Confirm" />
	</form>
	<jsp:include page="bootstrapFoot.jsp" />
</body>
</html>