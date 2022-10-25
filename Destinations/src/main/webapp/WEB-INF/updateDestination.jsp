<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
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
 		
 		Update Features:
  		<br>
  		<c:forEach items="${features}" var="feature"> 
  			<c:choose>
  				 <c:when test ="${destination.features.contains(feature)}">
  					<input type="checkbox" name="featureIds" value="${feature.id}" checked>
					<label for="${feature.name}">${feature.name}</label><br>
				</c:when>
				<c:otherwise>
  					<input type="checkbox" name="featureIds" value="${feature.id}">
					<label for="${feature.name}">${feature.name}</label><br>
				</c:otherwise>
  			</c:choose>
		</c:forEach>
		
 		Update Categories:
  		<br>
  		<c:forEach items="${categories}" var="category"> 
  			<c:choose>
  				 <c:when test ="${destination.categories.contains(category)}">
  					<input type="checkbox" id="${category.id}" name="categoryIds" value="${cateogory.id}" checked>
					<label for="${category.name}">${category.name}</label><br>
				</c:when>
				<c:otherwise>
  					<input type="checkbox" id="${category.id}" name="categoryIds" value="${category.id}">
					<label for="${category.name}">${category.name}</label><br>
				</c:otherwise>
  			</c:choose>
		</c:forEach>
		
		Add Price:
		<br>
  		<c:forEach items="${prices}" var="price"> 
  			<input type="checkbox" id="${price.id}" name="priceIds" value="${price.id}">
			<label for="${price.amount}">${price.amount}</label><br>
		</c:forEach>
 		
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