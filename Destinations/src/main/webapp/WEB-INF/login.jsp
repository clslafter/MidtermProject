<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Log in Page</title>
</head>
<body>

<h1>Log In</h1>

<form action="login.do" method="POST">

	<label for="username">User Name:</label>
 	<input type="text" id="username" name="username" required><br>

	<label for="password">Password:</label>
 	<input type="password" id="password" name="password" required><br>
 	
 	<input type="submit" value="Log In">

</form>

Test only <a href="showUserProfile.do">Show user profile</a> Testing Only - bypasses login!
</body>
</html>