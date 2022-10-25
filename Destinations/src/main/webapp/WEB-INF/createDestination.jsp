<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
     <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
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
 		<input type="text" id="description" name="description" ><br>
 		
		<label for="websiteUrl">URL for web site:</label>
 		<input type="text" id="websiteUrl" name="websiteUrl"><br>
 		
		<label for="imageUrl">URL for image:</label>
 		<input type="text" id="imageUrl" name="imageUrl"><br>
 		

 		
 		<label for="street">Street:</label>
 		<input type="text" id="street" name="street"><br>
  
  		<label for="city">City:</label>
  		<input type="text" id="city" name="city"><br>
  		
  		<label for="stateProvince">State/Province:</label>
  		<input type="text" id="stateProvince" name="stateProvince"><br>
 		
 		<label for="zip">ZipCode:</label>
  		<input type="text" id="zip" name="zip"><br>
 		
 		<label for="country">Country: </label>
  		<input type="text" id="country" name="country"><br>
  		
  		Add Features:
  		<c:forEach items="${features}" var="feature"> 
  		
  		<input type="checkbox" id="${feature.id}" name="featureIds" value="${feature.id}">
		<label for="${feature.name}">${feature.name}</label><br>
		</c:forEach>
		
		

		<input type="submit" value="Submit">

	</form>
	
</body>
</html>