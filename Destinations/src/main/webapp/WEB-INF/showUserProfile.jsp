<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>User Profile</title>
</head>
<body>
<H1>Welcome, ${user.firstName}</H1>

<!-- more user profile fields go here -->

!!Restrict access to this link later <a href="showAllUsers.do">Show all users</a> Testing purposing only!!<br>

<a href="updateAccount.do?uid=${user.id}">Update profile</a><br>

<a href="home.do">Home</a>

<a href="logout.do">Log Out</a>
</body>
</html>