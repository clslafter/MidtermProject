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
<div class="container-fluid">
<H1>Hello, ${user.firstName}!</H1>

<!-- list of all destinations -->



	<table class="table table" style="background-color: #7BC2BC; color: white;">
		<thead>
			<tr style="text-align: center; vertical-align: middle;">
				<th scope="col">Name</th>
				<th scope="col">Description</th>
				<th scope="col">City</th>
				<th scope="col">Reset Sort</th>
			</tr>
		</thead>
		<tbody>
			<tr >
				<td style="text-align: center; vertical-align: middle;">
					<form action="sortByName.do">
						<div class="input-group input-group-lg">
							<span class="input-group-text">Name </span> <input name="name"
								value="${destination.name}" placeholder="Insert Name" type="text"
								class="form-control" aria-label="Sizing example input"
								aria-describedby="inputGroup-sizing-lg"> <input
								name="submit" type="submit" value="Search" class="btn btn-light"/>
						</div>

					</form></td>

				<td style="text-align: center; vertical-align: middle;">
					<form action="sortByDescription.do">
						<div class="input-group input-group-lg">
							<span class="input-group-text">Description </span> <input
								name="description" value="${destination.description}" placeholder="Insert Keyword" type="text"
								class="form-control" aria-label="Sizing example input"
								aria-describedby="inputGroup-sizing-lg"> <input
								name="submit" type="submit" value="Search" class="btn btn-light" />
						</div>
					</form>

				</td>
				
				<td style="text-align: center; vertical-align: middle;">
					<form action="sortByCity.do">
						<div class="input-group input-group-lg">
							<span class="input-group-text">City </span> <input
								name="city" value="${destination.address.city}" placeholder="Insert City" type="text"
								class="form-control" aria-label="Sizing example input"
								aria-describedby="inputGroup-sizing-lg"> <input
								name="submit" type="submit" value="Search" class="btn btn-light" />
						</div>
					</form>

				</td>

				
				
				<td style="text-align: center; vertical-align: middle;">
				<form action="home.do">
				<input class="btn btn-light" name="submit" type="submit" value="Reset" />
				</form>
				</td>
			</tr>
		</tbody>
	</table>


	<c:forEach var="destination" items="${destinations}">
	<c:if test = "${destination.enabled == true }">
	
	<div class="card mb-3" style="max-width: 1000px;">
  		<div class="row g-0">
    	<div class="col-md-4">
     	 <img src="${destination.imageUrl}" class="img-fluid rounded-start">
    </div>
    <div class="col-md-8">
      <div class="card-body">
        <h5 class="card-title">${destination.name}</h5>
        <p class="card-text">${destination.description}</p>
        <p class="card-text"><small class="text-muted">Posted On: ${destination.createDateFormatted}</small></p>
        <p class="card-text"><small class="text-muted">Creator: <a href ="showOtherUsers.do?uid=${destination.user.id}">${destination.user.username}</a></small></p>
        
        <form action="showOtherUsers.do">
		<input type="hidden" name="uid" value="${destination.user.id}" /> 
		<input type="submit" value="View Creator's Profile" class="btn btn" style="background-color: #7BC2BC; color: white;" />
		</form>
		<br>
        <form action="showDestination.do">
		<input type="hidden" name="did" value="${destination.id}" /> 
		<input type="submit" value="View Destination" class="btn btn" style="background-color: #7BC2BC; color: white;" />
		</form>
       
      </div>
    </div>
  </div>
</div>
	
	
	

	</c:if>
	</c:forEach><br>

<!-- search destinations and sort options -->



</div>
<jsp:include page="footer.jsp" />
<jsp:include page="bootstrapFoot.jsp" />
</body>
</html>