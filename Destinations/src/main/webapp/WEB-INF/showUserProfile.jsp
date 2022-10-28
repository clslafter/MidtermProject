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

<h1>${user.firstName}'s Profile</h1>

	<form action="updateAccount.do" action="POST">
		<input type="hidden" name="id" value="${user.id}" /> 
		<input type="submit" value="Edit My Profile" class="btn btn" style="background-color: #7BC2BC; color: white;"/>
	</form> 
	<br>
	<c:if test="${isAdmin}">
	<form action="showAllUsers.do">
		<input type="submit" value="Manage Users" class="btn btn" style="background-color: #7BC2BC; color: white;"/>
	</form> <br>
	</c:if>

<hr>
<H5>Member since: ${user.createdDateFormatted}</H5>
<H4>About Me: ${user.bio}</H4>
<hr>

<!-- more user profile fields go here -->


	<h1>Manage My Destinations: </h1>
	<c:if test="${empty user.destinations }">
	You don't have any destinations, <a href="createDestination.do">Create a Destination</a>
	</c:if>
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
		   				<li class="list-group-item">Date Created: ${destination.createDateFormatted}</li>
		   				<c:if test="${!empty destination.lastEdited}">
		    			<li class="list-group-item">Last Edited: ${destination.editedDateFormatted}</li>
		    			</c:if>
		    			<li class="list-group-item">Enabled: ${destination.enabled}</li>
		  			</ul>
		  			<div class="card-body">
		  			
		  				<form action="updateDestination.do" action="POST">
							<input type="hidden" name="id" value="${destination.id}" /> 
							<input type="submit" value="Edit Destination" class="btn btn" style="background-color: #7BC2BC; color: white;" />
						</form> <br>
						
		  				<form action="showDestination.do" action="POST">
							<input type="hidden" name="did" value="${destination.id}" /> 
							<input type="submit" value="View Destination" class="btn btn" style="background-color: #7BC2BC; color: white;" />
						</form> <br>
		  			
		  			</div>
				</div>
				</c:if>
			</c:forEach>
		</div>
	</div>


</div>
<jsp:include page="bootstrapFoot.jsp" />
</body>
</html>