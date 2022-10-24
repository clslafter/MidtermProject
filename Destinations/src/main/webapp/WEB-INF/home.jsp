<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
      <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Home</title>
<jsp:include page="bootstrapHead.jsp" />
</head>
<body>
<jsp:include page="navbar.jsp" />
<H1>Internal Home Page</H1>
<H1>Hello, ${user.firstName}!</H1>

<!-- list of all destinations -->

Current Destinations:
	<c:forEach var="destination" items="${destinations}">
	<li><a href="showDestination.do?did=${destination.id}">${destination.name}</a></li>
	</c:forEach><br>

<!-- search destinations and sort options -->

<a href="createDestination.do">Create a new destination</a>


<jsp:include page="bootstrapFoot.jsp" />
</body>
</html>