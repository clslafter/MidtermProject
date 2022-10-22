<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Create Destination</title>
</head>
<body>
<H1>Create a new Destination</H1>

	<form action="newDestinationInfo" method="POST">

		<label for="name">Destination name:</label>
 		<input type="text" id="name" name="name" required><br>
 		
 		<!-- lots more fields go here -->

		<input type="submit" value="Submit">

	</form>
	
</body>
</html>