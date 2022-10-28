<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Update Destination</title>
<jsp:include page="bootstrapHead.jsp" />
</head>
<body>
<jsp:include page="navbar.jsp" />
<div class="container-fluid">
<H1>Update a Destination</H1>

	<form action="updateDestinationInfo.do" method="POST">
	
		<input name="id" value="${destination.id}" type="hidden" />

		<h4>Destination name:</h4><!-- <label for="name"></label> -->
 		<input type="text" id="name" name="name" value="${destination.name}" required><br>
 		
		<h4>Description:</h4>
 		<textarea name="description" class="form-control" rows="3" placeholder="${destination.description}"></textarea>
 		<br>
 		
 		<div class="row">
  		<div class="col">
  
 		<h4>Destination web site URL:</h4>
		<!-- <label for="websiteUrl">Destination website URL:</label> -->
 		<input type="text" id="name" name="websiteUrl" value="${destination.websiteUrl}"><br>
 		
		<h4>Destination main image URL:</h4>
		<!-- <label for="imageUrl">Destination Main image URL:</label> -->
 		<input type="text" id="name" name="imageUrl" value="${destination.imageUrl}" ><br>
 		
 		<h4>Update Features:</h4>
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
		
 		<h4>Update Categories:</h4>
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
		</div>
		
		<div class="col">
		<h4>Add A Price:</h4>
 		Amount: <input type="number" step="0.01" name = "amount" >
		Description: <input type="text" name = "description" >
		
		<br>
		<h5>Choose Currency Type:</h5>
  		<c:forEach items="${currencies}" var="currency"> 
  			<input type="checkbox" id="${currency.id}" name="currencyId" value="${currency.id}">
			<label for="${currency.name}">${currency.name}</label><br>
		</c:forEach>
		
		<h5>Choose Pricing Type:</h5>
		<c:forEach items="${pricingTypes}" var="type"> 
  			<input type="checkbox" id="${type.id}" name="typeId" value="${type.id}">
			<label for="${type.name}">${type.name}</label><br>
		</c:forEach>
 		</div>
 		<div class="col">
 		<h4>Address (optional):</h4>
  		
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
 		</div>
 		</div>

		<input type="submit" value="Submit">

	</form>
		
		<table class="table table table-striped" style="background-color: #7BC2BC; color: white;">
			<thead>
				<tr>
					<th scope="col">Pricing Type</th>
					<th scope="col">Amount</th>
					<th scope="col">Currency Type</th>
					<th scope="col">Description</th>
					<th scope="col">Delete</th>
				
				</tr>
		</thead>
			<c:forEach items="${destination.prices}" var="price">
				<tbody>
					<tr>
						<td scope="row">${price.pricingType.name}</td>
						<td>${price.amount}</td>
						<td>${price.currency.name}</td>
						<td>${price.description}</td>

					
						<td>
							<form action="deletePrice.do" >
								<input type= "hidden" name ="id" value ="${destination.id}">	
								<input type="hidden" name="priceId" value="${price.id}" /> 
								<input type="submit" value="Delete"/>
							</form>
						</td>
					</tr>
				</tbody>
			</c:forEach>
		</table>
		</div>
		<jsp:include page="bootstrapFoot.jsp" />
	</body>
</html>