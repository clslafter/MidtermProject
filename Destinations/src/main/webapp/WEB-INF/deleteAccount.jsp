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
<div class="container-fluid">

	<form action="accountDeleted.do" method="GET">
		<h1>Delete Account</h1>
		
		<label for="id">Are you sure you want to delete you account? </label>
		
		 <input name="id" value="${user.id}" type = "hidden"/> 
		 <input type="submit" value="Confirm" style="background-color: #7BC2BC; color: white;" />
	</form>
	</div>
	<jsp:include page="bootstrapFoot.jsp" />
</body>
</html>