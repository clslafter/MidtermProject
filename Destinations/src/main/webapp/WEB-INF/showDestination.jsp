<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>Destination Page</title>
		<jsp:include page="bootstrapHead.jsp" />
	</head>
<body>
	<jsp:include page="navbar.jsp" />
<div class="container-fluid">
	
	<div class="container-fluid text-center">
		<div class="row">
		    <div class="col-md-8">
		    
		    
		    <div class="card" style="background-color: #FAF4F0; color: E5E5E5;">
		 		 <div class="card-body">
		   		 <h5 class="card-title">${destination.name}</h5>
		    	<p class="card-text">Created by ${destination.user.username}
				<c:choose>
					<c:when test="${empty destination.createDate}"></c:when>
					<c:otherwise>on ${destination.createDateFormatted}<br></c:otherwise>
				</c:choose>
				<c:choose>
					<c:when test="${empty destination.lastEdited}"></c:when>
					<c:otherwise>Last edited on ${destination.lastEdited}</c:otherwise>
				</c:choose></p>
		    	<p class="card-text"><small class="text-muted">Last updated 3 mins ago</small></p>
		 	</div>
		 		<c:choose>
				<c:when test="${empty destination.imageUrl}">
					<p>This destination does not yet have a main image</p>
				</c:when>
				<c:otherwise>
		  			<img src="${destination.imageUrl}" class="card-img-bottom" alt="...">
				</c:otherwise>
			</c:choose>
			</div>
			
		   
					
					<c:choose>
						<c:when test="${empty destination.images}">
							<p>There are no extra images entered for this destination</p>
						</c:when>
						<c:otherwise>
								<h5>More Images</h5>
									<ul>
								
										<li style="list-style: none;">
											<form action="createDestinationImage.do" method="POST">
												<input type="hidden" value="${destination.id}" name="destinationId">
												<input type = "text" name = "imageUrl" placeholder="Insert Image Url" >
												<input type = "text" name = "caption" placeholder="Insert Image Caption">
												<input type = "submit" value = "Add Image">
											</form>
										</li>
							
   				 				 
								<c:forEach var="image" items="${destination.images}">
    							
									<div class="card mb-3" style="max-width: 1000px;">
									 <div class="row g-0">
									   <div class="col-md-4">
									<img src="${image.imageUrl}" class="card-img-top" style="max-height: 200px;"/>
									</div>
									 <div class="col-md-8">
									<div class="card-body">
									  <p class="card-text">
									<c:choose>
										<c:when test="${empty image.caption}">
				
										</c:when>
										<c:otherwise>
											<ul>
												<li style="list-style: none;">${image.caption}</li>
											</ul>
										</c:otherwise>
									</c:choose>
									<c:choose>
										<c:when test="${empty image.imageDate}">
				
										</c:when>
										<c:otherwise>
											<ul>
												<li style="list-style: none;">Posted by ${image.user.username}</li>
												<li style="list-style: none;">${image.imageDateFormatted}</li>
											</ul>
											<hr>
										</c:otherwise>
									</c:choose>
										<c:if test="${isAdmin || image.user.id == user.id }">
												<li style="list-style: none;">
													<form action="updateDestinationImage.do" method="POST">
														<input type="hidden" value="${destination.id }" name="destinationId">
														<input type="hidden" value="${image.id}" name="id">
														<input type = "text" name = "imageUrl" value = "${image.imageUrl}">
														<input type = "text" name = "caption" value = "${image.caption}">
														<input type = "submit" value = "Edit Image">
													</form>
													<form action="deleteDestinationImage.do" method="POST">
														<input type="hidden" value="${destination.id}" name="destinationId">
														<input type="hidden" value="${image.id}" name="id">
														<input type = "submit" value = "Remove Image">
													</form>
												</li>
											</c:if>
									</p>
									</div>
									</div>
										</div>
    						
    							</div>
								</c:forEach>
   				 		
							</ul>
						</c:otherwise>
					</c:choose>
		    </div>
  			
	 		<div class="col-6 col-md-4">
	  
	 			<div class="card" style="background-color: #FAF4F0; color: E5E5E5;">
  					<div class="card-body">
   					<h3>Description</h3>
   					<c:choose>
						<c:when test="${empty destination.description}">
							<p>This destination does not yet have a description</p>
						</c:when>
						<c:otherwise>
							<p>${destination.description}</p>
						</c:otherwise>
					</c:choose>
					</div>
  				</div>
  				
  				<div class="card" style="background-color: #FAF4F0; color: E5E5E5;">
  					<div class="card-body">
  					 	<h3>Location</h3>
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
  					</div>
  				</div>
  				<div class="card" style="background-color: #FAF4F0; color: E5E5E5;">
  					<div class="card-body">
  					<h3>Go To Website</h3>
  					<c:choose>
						<c:when test="${empty destination.websiteUrl}">
							<p>This destination does not yet have a web page</p>
						</c:when>
						<c:otherwise>
							<a href="${destination.websiteUrl}" target="_blank">${destination.name}'s web page</a>
							<br>
						</c:otherwise>
					</c:choose>
  					</div>
  				</div>
  				
    		
    
	<!-- insert other destination details here -->
		<div class="card" style="background-color: #FAF4F0; color: E5E5E5;">
  			<div class="card-body">
  				<h3>Type Of Destination</h3>
					<c:choose>
						<c:when test="${empty destination.categories}">
							<p>There are no categories entered for this destination</p>
						</c:when>
						<c:otherwise>
							<ul>
								<c:forEach var="category" items="${destination.categories}">
									<li style="font-weight: bold; list-style: none;">${category.name}</li>
								</c:forEach>
							</ul>
						</c:otherwise>
					</c:choose>
				</div>
			</div>

		<div class="card" style="background-color: #FAF4F0; color: E5E5E5;">
  			<div class="card-body">
  				<h3>Features</h3>
					<c:choose>
						<c:when test="${empty destination.features}">
							<p>There are no features entered for this destination</p>
						</c:when>
						<c:otherwise>
							<ul class="list-group list-group-flush">
								<c:forEach var="feature" items="${destination.features}">
									<li style="font-weight: bold; list-style: none;">${feature.name}</li>
									<c:choose>
										<c:when test="${empty feature.description}">
				
										</c:when>
										<c:otherwise>
											<ul>
												<li class="list-group-item" style="background-color: #FAF4F0; color: E5E5E5;">${feature.description}</li>
											</ul>
										</c:otherwise>
									</c:choose>
									<hr>
								</c:forEach>
							</ul>
						</c:otherwise>
				</c:choose>
			</div>
		</div>

		<div class="card" style="background-color: #FAF4F0; color: E5E5E5;">
  			<div class="card-body">
  				<h3>Pricing</h3>
					<c:choose>
						<c:when test="${empty destination.prices}">
							<p>There are no prices listed for this destination. Not even
								free.</p>
						</c:when>
						<c:otherwise>
							<ul class="list-group list-group-flush">
								<c:forEach var="price" items="${destination.prices}">
									 <li style="font-weight: bold; list-style: none;">${price.pricingType.name}: ${price.amount}
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
												<li class="list-group-item" style="background-color: #FAF4F0; color: E5E5E5;">${price.description}</li>
											</ul>
										</c:otherwise>
									</c:choose>
											<hr>
								</c:forEach>
							</ul>
						</c:otherwise>
					</c:choose>
				</div>
			</div>
			</div>
		</div>
	</div>


	
	

	<c:choose>
		<c:when test="${empty destination.reviews}">
			<p>There are no reviews entered for this destination</p>
		</c:when>
		<c:otherwise>

				<h2 style="font-weight: bold;">Destination Author's Review</h2>
			<ul>
				<c:forEach var="review" items="${destination.reviews}">
					<c:if test="${review.destination.user == review.user}">
						<li>By ${review.user.username} on ${review.reviewDateFormatted}:
							${review.comment}</li>
							<c:if test="${isAdmin || review.user.id == user.id}">
								<li>
									<form action="updateDestinationReview.do" method="POST">
										<input type="hidden" value="${destination.id }" name="destinationId">
										<input type = "text" name = "comment" value = "${review.comment}">
										<input type = "submit" value = "Edit Review">
									</form>
									<form action="deleteDestinationReview.do" method="POST">
										<input type="hidden" value="${destination.id}" name="destinationId">
										<input type = "submit" value = "Remove Review">
									</form>
								</li>
							</c:if>
						<c:forEach var="reviewComment" items="${review.reviewComments}">
							<c:choose>
								<c:when test="${empty review.reviewComments}">
								</c:when>
								<c:otherwise>
									<ul>
										<li>By ${reviewComment.user.username} on
											${reviewComment.createdDateFormatted}: ${reviewComment.comment}</li>
											<c:if test="${isAdmin || reviewComment.user.id == user.id }">
												<li>
													<form action="updateReviewComment.do" method="POST">
														<input type="hidden" value="${review.destination.id}" name="destinationId">
														<input type="hidden" value="${review.user.id}" name="reviewUserId">
														<input type="hidden" value="${reviewComment.id}" name="id">
														<input type = "text" name = "comment" value = "${reviewComment.comment}">
														<input type = "submit" value = "Edit Comment">
													</form>
														<form action="deleteReviewComment.do" method="POST">
														<input type="hidden" value="${review.destination.id}" name="destinationId">
														<input type="hidden" value="${review.user.id}" name="reviewUserId">
														<input type="hidden" value="${reviewComment.id}" name="id">
														<input type = "submit" value = "Remove Comment">
													</form>
												</li>
										</c:if>
									</ul>
								</c:otherwise>
							</c:choose>
						</c:forEach>
					<ul>
						<li>
							<form action="createReviewComment.do" method="POST">
								<input type="hidden" value="${destination.id}" name="destinationId">
								<input type="hidden" value="${review.user.id}" name="reviewUserId">
								<input type = "text" name = "reviewComment" >
								<input type = "submit" value = "Add Comment">
							</form>
						</li>					
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

			<h2 style="font-weight: bold;">Reviews</h2>
				<ul>
					<c:if test="${userReview == null}">
						<li>
							<form action="createDestinationReview.do" method="POST">
								<input type="hidden" value="${destination.id }" name="destinationId">
								<input type = "text" name = "comment" >
								<input type = "submit" value = "Add Review">
							</form>
						</li>
					</c:if>
				<c:forEach var="review" items="${destination.reviews}">
					<c:if test="${review.destination.user != review.user}">
						<li>By ${review.user.username} on ${review.reviewDateFormatted}:
							${review.comment}</li>
							<c:if test="${isAdmin || review.user.id == user.id }">
								<li>
									<form action="updateDestinationReview.do" method="POST">
										<input type="hidden" value="${destination.id }" name="destinationId">
										<input type = "text" name = "comment" value = "${review.comment}">
										<input type = "submit" value = "Edit Review">
									</form>
									<form action="deleteDestinationReview.do" method="POST">
										<input type="hidden" value="${destination.id}" name="destinationId">
										<input type = "submit" value = "Remove Review">
									</form>
								</li>
							</c:if>
						<ul>
							<c:forEach var="reviewComment" items="${review.reviewComments}">
								<c:choose>
									<c:when test="${empty review.reviewComments}">
									</c:when>
									<c:otherwise>
											<li>By ${reviewComment.user.username} on
												${reviewComment.createdDateFormatted}: ${reviewComment.comment}</li>
											<c:if test="${isAdmin || reviewComment.user.id == user.id}">
												<li>
													<form action="updateReviewComment.do" method="POST">
														<input type="hidden" value="${review.destination.id}" name="destinationId">
														<input type="hidden" value="${review.user.id}" name="reviewUserId">
														<input type="hidden" value="${reviewComment.id}" name="id">
														<input type = "text" name = "comment" value = "${reviewComment.comment}">
														<input type = "submit" value = "Edit Comment">
													</form>
													<form action="deleteReviewComment.do" method="POST">
														<input type="hidden" value="${review.destination.id}" name="destinationId">
														<input type="hidden" value="${review.user.id}" name="reviewUserId">
														<input type="hidden" value="${reviewComment.id}" name="id">
														<input type = "submit" value = "Remove Comment">
													</form>
												</li>
											</c:if>
									</c:otherwise>
								</c:choose>
							</c:forEach>
						<li>
							<form action="createReviewComment.do" method="POST">
								<input type="hidden" value="${destination.id}" name="destinationId">
								<input type="hidden" value="${review.user.id}" name="reviewUserId">
								<input type = "text" name = "reviewComment" >
								<input type = "submit" value = "Add Comment">
							</form>
						</li>
						</ul>
					</c:if>
				</c:forEach>
			</ul>
		</c:otherwise>
	</c:choose>
<c:if test="${isAdmin || destination.user.id == user.id}">
	<form action="updateDestination.do" action="POST">
		<input type="hidden" name="id" value="${destination.id}" /> <input
			type="submit" value="Edit Destination" class="btn btn-primary" />
	</form>
	<br>

	<form action="deleteDestination.do" action="POST">
		<input type="hidden" name="id" value="${destination.id}" /> <input
			type="submit" value="Delete Destination" class="btn btn-primary" />
	</form>
	</c:if>
	<br>

	<jsp:include page="bootstrapFoot.jsp" />
 </div>
</body>
</html>