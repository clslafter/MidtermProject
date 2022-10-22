<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Update User</title>
</head>
<body>
<h1>Update ${user.username}'s profile</h1>

	<form action="updateUserInfo.do" method="POST">

		<label for="firstName">First name:</label>
 		<input type="text" id="firstName" name="firstName" value="${user.firstName}" required><br>
  
  		<label for="lastName">Last name:</label>
  		<input type="text" id="lastName" name="lastName" value="${user.lastName}" required><br>
  		
  	<!-- 	lots more fields go here -->

		<input type="submit" value="Submit">

	</form>
</body>
</html>