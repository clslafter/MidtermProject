<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Update User</title>
<jsp:include page="bootstrapHead.jsp" />
</head>
<body>
<jsp:include page="navbar.jsp" />
<div class="container-fluid">
<h1>Update ${user.username}'s profile</h1>

	<form action="updateUserInfo.do" method="POST">
	
		<input name="id" value="${user.id}" type="hidden" />

		<label for="firstName">First name:</label>
 		<input type="text" id="firstName" name="firstName" value="${user.firstName}"><br>
  
  		<label for="lastName">Last name:</label>
  		<input type="text" id="lastName" name="lastName" value="${user.lastName}"><br>
  		
  		<label for="email">Email address:</label>
  		<input type="text" id="email" name="email" value="${user.email}" ><br>
 		
 		<label for="username">User name:</label>
  		<input type="text" id="username" name="username" value="${user.username}"><br>
 		
 		<label for="password">Password: </label>
  		<input type="text" id="password" name="password" value="${user.password}"><br>
  		
  		<h2>Bio</h2>
  		
  		
		<textarea name="bio" class="form-control" rows="3">${user.bio}</textarea>
		
  		
  		<h2>Address(optional)</h2>
  		
  		<input name="id" value="${address.id}" type="hidden" />
  		
  		<label for="street">Street:</label>
 		<input type="text" id="street" name="street" value="${address.street}"><br>
  
  		<label for="city">City:</label>
  		<input type="text" id="city" name="city" value="${address.city}"><br>
  		
  		<label for="stateProvince">State/Province:</label>
  		<input type="text" id="stateProvince" name="stateProvince" value="${address.stateProvince}" ><br>
 		
 		<label for="zip">ZipCode:</label>
  		<input type="text" id="zip" name="zip" value="${address.zip}"><br>
 		
 		<label for="country">Country: </label>
  		<input type="text" id="country" name="country" value="${address.country}"><br>
  		<hr>
  		<input type="submit" value="Update My Account" class="btn btn-primary" />
		
	</form>
	<br>
	<form action="deleteAccount.do" action="POST">
		<input type="hidden" name="id" value="${user.id}" /> 
		<input type="submit" value="Delete My Account" class="btn btn-primary"/>
	</form> <br>
  		
  	</div>
<jsp:include page="bootstrapFoot.jsp" />
</body>
</html>