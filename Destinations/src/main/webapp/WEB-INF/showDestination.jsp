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

	<c:choose>
		<c:when test="${empty destination.description}">
			<p>This destination does not yet have a description</p>
		</c:when>
		<c:otherwise>
			<p>${destination.description}</p>
		</c:otherwise>
	</c:choose>
	<c:choose>
		<c:when test="${empty destination.websiteUrl}">
			<p>This destination does not yet have a web page</p>
		</c:when>
		<c:otherwise>
			<a href="${destination.websiteUrl}" target="_blank">${destination.name}'s
				web page</a>
			<br>
		</c:otherwise>
	</c:choose>
	<c:choose>
		<c:when test="${empty destination.imageUrl}">
			<p>This destination does not yet have a main image</p>
		</c:when>
		<c:otherwise>
			<img src="${destination.imageUrl}">
			<br>
		</c:otherwise>
	</c:choose>






	<!-- insert other destination details here -->
	<c:choose>
		<c:when
			test="${empty destination.address.city && empty destination.address.stateProvince&& empty destination.address.country}">
			<p>This destination does not yet have an address</p>
		</c:when>
		<c:otherwise>
			<p>${destination.address.street}
				<br>${destination.address.city},
				${destination.address.stateProvince} ${destination.address.zip} <br>${destination.address.country}</p>
		</c:otherwise>
	</c:choose>
	<c:choose>
		<c:when
			test="${empty destination.address.latitude && empty destination.address.longitude}">
			<p>This destination does not yet have coordinates</p>
		</c:when>
		<c:otherwise>
			<p>Latitude/Longitude:
				${destination.address.latitude}/${destination.address.longitude}</p>
			<br>
		</c:otherwise>
	</c:choose>




	<c:choose>
		<c:when test="${empty destination.categories}">
			<p>There are no categories entered for this destination</p>
		</c:when>
		<c:otherwise>

			<ul>
				<lh>Type of Destination</lh>
				<c:forEach var="category" items="${destination.categories}">
					<li>${category.name}</li>
				</c:forEach>
			</ul>
		</c:otherwise>
	</c:choose>



	<c:choose>
		<c:when test="${empty destination.features}">
			<p>There are no features entered for this destination</p>
		</c:when>
		<c:otherwise>
			<ul>
				<lh>Features</lh>
				<c:forEach var="feature" items="${destination.features}">
					<li>${feature.name}</li>
					<c:choose>
						<c:when test="${empty feature.description}">

						</c:when>
						<c:otherwise>
							<ul>
								<li>${feature.description}</li>
							</ul>
						</c:otherwise>
					</c:choose>

				</c:forEach>
			</ul>
		</c:otherwise>
	</c:choose>



	<c:choose>
		<c:when test="${empty destination.prices}">
			<p>There are no prices listed for this destination. Not even
				free.</p>
		</c:when>
		<c:otherwise>
			<ul>
				<lh>Prices</lh>
				<c:forEach var="price" items="${destination.prices}">
					<li>${price.pricingType.name}: ${price.amount} ${price.currency.name}</li>
					<c:choose>
						<c:when test="${empty price.pricingType.description}">

						</c:when>
						<c:otherwise>
							<ul>
								<li>${price.pricingType.description}</li>
							</ul>
						</c:otherwise>
					</c:choose>
					<c:choose>
						<c:when test="${empty price.description}">

						</c:when>
						<c:otherwise>
							<ul>
								<li>${price.description}</li>
							</ul>
						</c:otherwise>
					</c:choose>

				</c:forEach>
			</ul>
		</c:otherwise>
	</c:choose>



	!!Restrict access to this link later!!
	<a href="updateDestination.do?did=${destination.id}">Update this
		destination</a>
	<br>

	<a href="home.do">Home</a>



</body>
</html>