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

	<form action="createNewDestination.do" method="POST">

		<label for="name">Destination name:</label>
 		<input type="text" id="name" name="name" required><br>
 		
		<label for="description">Description:</label>
 		<input type="text" id="description" name="description" required><br>
 		
		<label for="websiteUrl">URL for web site:</label>
 		<input type="text" id="websiteUrl" name="websiteUrl"><br>
 		
		<label for="imageUrl">URL for image:</label>
 		<input type="text" id="imageUrl" name="imageUrl"><br>
 		
 		<!-- lots more fields go here -->

		<input type="submit" value="Submit">

	</form>
	
</body>
</html>