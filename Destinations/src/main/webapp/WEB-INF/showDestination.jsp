<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Destination Page</title>
</head>
<body>
<H1>${destination.name}</H1>

<p>${destination.description}</p>
<a href="${destination.websiteUrl}" target="_blank">${destination.name}'s web page</a><br>
<img src="${destination.imageUrl}"><br>

<!-- insert other destination details here -->

<%-- <ul>
<lh>Type of Destination</lh>
<c:forEach var="category" items="${destination.categories}">
<li>${destination.category.name}</li>
</c:forEach>
</ul> --%>

!!Restrict access to this link later!! <a href="updateDestination.do?did=${destination.id}">Update this destination</a><br>

<a href="home.do">Home</a>



</body>
</html>