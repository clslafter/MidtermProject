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
	<p>
		Created by ${destination.user.username}

		<c:choose>
			<c:when test="${empty destination.createDate}">

			</c:when>
			<c:otherwise>
			on ${destination.createDate}<br>
			</c:otherwise>
		</c:choose>
		<c:choose>
			<c:when test="${empty destination.lastEdited}">

			</c:when>
			<c:otherwise>
			Last edited on ${destination.lastEdited}
	
	
	
	
	
	</p>
	</c:otherwise>
	</c:choose>


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
					<li>${price.pricingType.name}:${price.amount}
						${price.currency.name}</li>
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


	<c:choose>
		<c:when test="${empty destination.images}">
			<p>There are no extra images entered for this destination</p>
		</c:when>
		<c:otherwise>
			<ul>
				<lh>More Images</lh>
				<c:forEach var="image" items="${destination.images}">
					<li><img src="${image.imageUrl}" height="100" width="130" /></li>
					<c:choose>
						<c:when test="${empty image.caption}">

						</c:when>
						<c:otherwise>
							<ul>
								<li>${image.caption}</li>
							</ul>
						</c:otherwise>
					</c:choose>
					<c:choose>
						<c:when test="${empty image.imageDate}">

						</c:when>
						<c:otherwise>
							<ul>
								<li>Posted by ${image.user.username}</li>
								<li>${image.imageDate}</li>
							</ul>
						</c:otherwise>
					</c:choose>

				</c:forEach>
			</ul>
		</c:otherwise>
	</c:choose>

	<c:choose>
		<c:when test="${empty destination.reviews}">
			<p>There are no reviews entered for this destination</p>
		</c:when>
		<c:otherwise>

			<ul>
				<lh>Destination Author's Review</lh>
				<c:forEach var="review" items="${destination.reviews}">

					<c:if test="${review.destination.user == review.user}">
						<li>By ${review.user.username} on ${review.reviewDate}</li>
						<ul>
							<li>${review.comment}</li>

							<c:forEach var="reviewComments" items="${review.reviewComments}">
								<c:if test="${empty reviewComments.reviewComments}">
									<ul>
										<li>${reviewComments.reviewComment.comment}</li>
									
										<c:if test="${!empty reviewComments.comment}">
											<ul>
												<li>${reviewComments.comment}</li>
											</ul>
										</c:if>
									</ul>
								</c:if>
							</c:forEach>


						</ul>
					</c:if>
				</c:forEach>
			</ul>
		</c:otherwise>
	</c:choose>


	<c:choose>
		<c:when test="${empty destination.reviews}">
			<p>There are no reviews entered for this destination</p>
		</c:when>
		<c:otherwise>

			<ul>
				<lh>Reviews</lh>
				<c:forEach var="review" items="${destination.reviews}">
					<c:if test="${review.destination.user != review.user}">
						<li>By ${review.user.username} on ${review.reviewDate}</li>
						<ul>
							<li>${review.comment}</li>
							<c:forEach var="reviewComments" items="${review.reviewComments}">
								<c:if test="${empty reviewComments.reviewComments}">
									<ul>
									<li>By ${reviewComments.reviewComment.user.username} on ${reviewComments.reviewComment.createdDate}</li>
										<li>${reviewComments.reviewComment.comment}</li>
										<c:if test="${!empty reviewComments.comment}">
											<ul>
											<li>By </li>
												<li>${reviewComments.comment}</li>
											</ul>
										</c:if>
									</ul>
								</c:if>
							</c:forEach>
						</ul>
					</c:if>
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