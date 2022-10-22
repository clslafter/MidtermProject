<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Create an account</title>
</head>
<body>

<H1>Create an Account</H1>

	<form action="newAccountInfo" method="POST">

		<label for="firstName">First name:</label>
 		<input type="text" id="firstName" name="firstName" required><br>
  
  		<label for="lastName">Last name:</label>
  		<input type="text" id="lastName" name="lastName" required><br>
  		
  		<label for="email">Email address:</label>
  		<input type="text" id="email" name="email" required><br>
  		
  		<label for="userName">User name:</label>
  		<input type="text" id="userName" name="userName" required><br>
  		
  		<label for="Password">Last name:</label>
  		<input type="text" id="password" name="password" required><br>
  		 	
 		<input type="submit" value="Submit">

	</form>
</body>
</html>