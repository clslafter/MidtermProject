<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Update Destination</title>
</head>
<body>
<H1>Update a Destination</H1>

	<form action="updateDestinationInfo" method="POST">

		<label for="name">Destination name:</label>
 		<input type="text" id="name" name="name" value="${destination.name}" required><br>
 		
 		<!-- lots more fields go here -->

		<input type="submit" value="Submit">

	</form>

</body>
</html>