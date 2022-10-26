<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Welcome Page</title>
<jsp:include page="bootstrapHead.jsp" />
</head>
<body>

<jsp:include page="navbar.jsp" />
<jsp:include page="imageSlider.jsp"/>
<jsp:include page="welcomeMessage.jsp"/>



<!-- Insert Top Destination Teaser Here -->

	<c:if test = "${user.enabled == false}">
		${user.username}, Your Account has been deleted!
	</c:if>
	<jsp:include page="bootstrapFoot.jsp" />
</body>
</html>