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

	<form action="createUserAccount.do" method="POST">


		<label for="firstName">First name:</label>
 		<input type="text" id="firstName" name="firstName" required><br>
  
  		<label for="lastName">Last name:</label>
  		<input type="text" id="lastName" name="lastName" required><br>
  		
  		<label for="email">Email address:</label>
  		<input type="text" id="email" name="email" required><br>
  		
  		<label for="username">User name:</label>
  		<input type="text" id="username" name="username" required><br>
  		
  		<label for="password">Password: </label>
  		<input type="text" id="password" name="password" required><br>
  		
 		<input type="submit" value="Create Account">

	</form>
</body>
</html>