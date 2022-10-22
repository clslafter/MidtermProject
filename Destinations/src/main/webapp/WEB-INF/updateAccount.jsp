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
	
		<input name="id" value="${user.id}" type="hidden" />

		<label for="firstName">First name:</label>
 		<input type="text" id="firstName" name="firstName" value="${user.firstName}"><br>
  
  		<label for="lastName">Last name:</label>
  		<input type="text" id="lastName" name="lastName" value="${user.lastName}"><br>
  		
  		<label for="email">Email address:</label>
  		<input type="text" id="email" name="email" value="${user.email}" ><br>
 		
 		<label for="username">User name:</label>
  		<input type="text" id="username" name="username" value="${user.username}"><br>
 		
 		<label for="password">Password: </label>
  		<input type="text" id="password" name="password" value="${user.password}"><br>
  		
  		<h2>Address(optional)</h2>
  		
  		
  	
  		
  	<!-- 	lots more fields go here -->

		<input type="submit" value="Submit">

	</form>
</body>
</html>