<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Create an account</title>
<jsp:include page="bootstrapHead.jsp" />
</head>
<body>
<jsp:include page="navbar.jsp" />

<div class="container text-center" style="padding-top: 200px;">
  <div class="row">
    <div class="col-sm-5 col-md-6"><img
				src="https://cdn-icons-png.flaticon.com/512/201/201623.png" style="width: 250px; height: auto; "></div>
    <div class="col-sm-5 offset-sm-2 col-md-6 offset-md-0" style="padding-left: 100px;">

	<div class="card" style="width: 25rem;">
  		<div class="card-body">
	   		<h5 class="card-title">Create Account</h5>
	<form action="createUserAccount.do" method="POST">
 		
 		 <input name="firstName" placeholder="First Name" type="text"
			    class="form-control" required aria-label="Sizing example input"
				aria-describedby="inputGroup-sizing-lg">
				
 		 <input name="lastName" placeholder="Last Name" type="text"
			    class="form-control" required aria-label="Sizing example input"
				aria-describedby="inputGroup-sizing-lg">
				
 		 <input name="email" placeholder="Email" type="text"
			    class="form-control" required aria-label="Sizing example input"
				aria-describedby="inputGroup-sizing-lg">
				
 		 <input name="username" placeholder="User Name" type="text"
			    class="form-control" required aria-label="Sizing example input"
				aria-describedby="inputGroup-sizing-lg">
				
 		 <input name="password" placeholder="Password" type="text"
			    class="form-control" required aria-label="Sizing example input"
				aria-describedby="inputGroup-sizing-lg"><br>
 		
 		<input type="submit" value="Create Account" class="btn btn" style="background-color: #7BC2BC; color: white;" />
		 		<hr>
		 		
			</form>
		 		 <div class="list-group-item">
   					 <form action="login.do" >
						<input type="submit" value="Login to Existing Account" class="btn btn" style="background-color: #7BC2BC; color: white;"/>
					</form> <br>
  				</div>
  		</div>
	</div>
	
	
	
    </div>
  </div>
</div>
<hr>
	<jsp:include page="footer.jsp" />
	<jsp:include page="bootstrapFoot.jsp" />
</body>
</html>