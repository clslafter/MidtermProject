<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Destination Page</title>
</head>
<body>
<H1>${destination.name}</H1>

<p>${destination.description}</p>
<a href="${destination.websiteUrl}" target="_blank">Destination's web page</a><br>
<img src="${destination.imageUrl}"><br>

<!-- insert other destination details here -->

!!Restrict access to this link later!! <a href="updateDestination.do?did=${destination.id}">Update this destination</a><br>

<a href="home.do">Home</a>

</body>
</html>