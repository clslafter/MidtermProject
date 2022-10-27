<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>User Profile</title>
<jsp:include page="bootstrapHead.jsp" />
</head>
<body>
<jsp:include page="navbar.jsp" />
<div class="container-fluid">
<H1>${user.firstName}'s Profile</H1>

<!-- more user profile fields go here -->

	<c:if test="${isAdmin}">
		<a href="showAllUsers.do">Show all users</a><br>
	</c:if>

	<h1>Manage My Destinations: </h1>
	<div class ="col">
		<div class = "row row-cols-1 row-cols-md-3 g-4">
			<c:forEach items="${user.destinations}" var="destination"> 
			<c:if test = "${destination.enabled == true }">
				<div class="card" style="width: 18rem;">
		 			<img src="${destination.imageUrl}" class="card-img-top" alt="...">
		  			<div class="card-body">
		    			<h5 class="card-title">${destination.name}</h5>
		    			<p class="card-text">${destination.description}</p>
		  			</div>
		  			<ul class="list-group list-group-flush">
		   				<li class="list-group-item">Date Created: ${destination.createDate}</li>
		    			<li class="list-group-item">Last Edited: ${destination.lastEdited}</li>
		    			<li class="list-group-item">Enabled: ${destination.enabled}</li>
		  			</ul>
		  			<div class="card-body">
		  			
		  				<form action="updateDestination.do" action="POST">
							<input type="hidden" name="id" value="${destination.id}" /> 
							<input type="submit" value="Edit Destination" class="btn btn-primary" />
						</form> <br>
		  			
		    			<a href="updateDestination.do?id=${destination.id}" class="card-link">Edit</a>
		    			<a href="showDestination.do?did=${destination.id}" class="card-link">View on Home Page</a>
		  			</div>
				</div>
				</c:if>
			</c:forEach>
		</div>
	</div>

	<form action="updateAccount.do" action="POST">
		<input type="hidden" name="id" value="${user.id}" /> 
		<input type="submit" value="Edit My Profile" class="btn btn-primary" />
	</form> <br>
	
	<form action="deleteAccount.do" action="POST">
		<input type="hidden" name="id" value="${user.id}" /> 
		<input type="submit" value="Delete My Account" class="btn btn-primary" />
	</form> <br>
</div>
<jsp:include page="bootstrapFoot.jsp" />
</body>
</html>