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

	<form action="updateDestinationInfo.do" method="POST">
	
		<input name="id" value="${destination.id}" type="hidden" />

		<label for="name">Destination name:</label>
 		<input type="text" id="name" name="name" value="${destination.name}" required><br>
 		
		<h3>Description:</h3>
 		<textarea name="description" class="form-control" rows="3" placeholder="${destination.description}"></textarea>
 		<br>
 		
		<label for="websiteUrl">Destination website URL:</label>
 		<input type="text" id="name" name="websiteUrl" value="${destination.websiteUrl}"><br>
 		
		<label for="imageUrl">Destination Main image URL:</label>
 		<input type="text" id="name" name="imageUrl" value="${destination.imageUrl}" ><br>
 		
 		<h2>Address(optional)</h2>
  		
  		<input name="id" value="${address.id}" type="hidden" />
  		
  		<label for="street">Street:</label>
 		<input type="text" id="street" name="street" value="${address.street}"><br>
  
  		<label for="city">City:</label>
  		<input type="text" id="city" name="city" value="${address.city}"><br>
  		
  		<label for="stateProvince">State/Province:</label>
  		<input type="text" id="stateProvince" name="stateProvince" value="${address.stateProvince}" ><br>
 		
 		<label for="zip">ZipCode:</label>
  		<input type="text" id="zip" name="zip" value="${address.zip}"><br>
 		
 		<label for="country">Country: </label>
  		<input type="text" id="country" name="country" value="${address.country}"><br>
 		
 		<!-- lots more fields go here -->

		<input type="submit" value="Submit">

	</form>

</body>
</html>