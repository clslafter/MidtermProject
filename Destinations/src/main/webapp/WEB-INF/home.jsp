<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Home</title>
</head>
<body>
<H1>Internal Home Page</H1>

<!-- list of all destinations -->

${destination}

<!-- search destinations and sort options -->

<a href="createDestination.do">Create a new destination</a>

<a href="showUserProfile.do">My profile</a>

<a href="logout">Log out</a>


</body>
</html>