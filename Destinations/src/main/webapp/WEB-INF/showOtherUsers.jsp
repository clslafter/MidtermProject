<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Show Other Users</title>
<jsp:include page="bootstrapHead.jsp" />
</head>
<body>
<jsp:include page="navbar.jsp" />
<div class="container-fluid">
<H1>Welcome to ${user.firstName}'s Profile!</H1>

<H4>Member since: ${user.createdDateFormatted}</H4>
<H4>About Me: ${user.bio}</H4>



<H2>${user.firstName}'s Destinations</H2>

<div class ="col">
		<div class = "row row-cols-1 row-cols-md-3 g-4">
			<c:forEach items="${user.destinations}" var="destination"> 
			<c:if test = "${destination.enabled == true }">
				<div class="card" style="width: 18rem;">
		 			<img src="${destination.imageUrl}" class="card-img-top" alt="...">
		  			<div class="card-body">
		    			<h5 class="card-title"><a href="showDestination.do?did=${destination.id}">${destination.name}</a></h5>
		    			<p class="card-text">${destination.description}</p>
		  			</div>
		  			<ul class="list-group list-group-flush">
		   				<li class="list-group-item">Date Created: ${destination.createDateFormatted}</li>
		   				<c:if test="${!empty destination.lastEdited}">
		    			<li class="list-group-item">Last Edited: ${destination.editedDateFormatted}</li>
		    			</c:if>
		  			</ul>
				</div>
				</c:if>
			</c:forEach>
		</div>
	</div>



</div>
<jsp:include page="bootstrapFoot.jsp" />
</body>
</html>