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

<form action="loginInfo.do" method="POST">

	<label for="userName">User Name:</label>
 	<input type="text" id="userName" name="userName" required><br>

	<label for="password">Password:</label>
 	<input type="text" id="password" name="password" required><br>
 	
 	<input type="submit" value="Submit">

</form>

Test only <a href="showUserProfile.do">Show user profile</a> Testing Only - bypasses login!
</body>
</html>