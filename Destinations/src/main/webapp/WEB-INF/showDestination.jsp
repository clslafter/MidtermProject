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
<a href="${destination.websiteUrl}" target="_blank">Destination's webpage</a><br>
<img src="${destination.imageUrl}"><br>

<!-- insert other destination details here -->

<a href="home.do">Home</a>

</body>
</html>