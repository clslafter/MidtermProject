<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Log in Page</title>
<jsp:include page="bootstrapHead.jsp" />
</head>
<body>
<jsp:include page="navbar.jsp" />


<div class="container text-center" style="padding-top: 200px;">
  <div class="row">
    <div class="col-sm-5 col-md-6"><img
				src="https://cdn-icons-png.flaticon.com/512/201/201623.png" style="width: 250px; height: auto; "></div>
    <div class="col-sm-5 offset-sm-2 col-md-6 offset-md-0" style="padding-left: 100px;">
	<c:choose>
		<c:when test="${userError != null }" >
			<p style="font-weight: bold;">${userError}</p>
		</c:when>
	</c:choose>	
	
	
	<div class="card" style="width: 25rem;">
  		<div class="card-body">
	   		<h5 class="card-title">Login</h5>
	   	
			<form action="login.do" method="POST">
		
				
				<input name="username" placeholder="username" type="text"
					   class="form-control" required aria-label="Sizing example input"
					   aria-describedby="inputGroup-sizing-lg">
					   
				<input name="password" placeholder="password" type="text"
					   class="form-control" required aria-label="Sizing example input"
					   aria-describedby="inputGroup-sizing-lg"><br>
				
				
				
		 		<!-- <input type="text" id="username" name="username" required><br>
		
				<label for="password">Password:</label>
		 		<input type="password" id="password" name="password" required><br> -->
		 	
		 		<input type="submit" value="Log In" class="btn btn" style="background-color: #7BC2BC; color: white;" />
		 		<hr>
		 		
			</form>
		 		 <div class="list-group-item">
   					 <form action="createAccount.do" >
						<input type="submit" value="Create Account" class="btn btn" style="background-color: #7BC2BC; color: white;"/>
					</form> <br>
  				</div>
  		</div>
	</div>
	
	
	
    </div>
  </div>
</div>
<jsp:include page="bootstrapFoot.jsp" />
</body>
</html>