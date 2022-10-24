<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
     <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>All Users</title>
</head>
<body>
<H1>List of all Users</H1>

Current Users:
	<table class="table table-dark table-striped">
		<thead>
			<tr>
				<th scope="col">ID</th>
				<th scope="col">Username</th>
				<th scope="col">Full Name</th>
				<th scope="col">Role</th>
				<th scope="col">Enabled</th>
				<th scope="col">Edit Enabled</th>
				
			</tr>
		</thead>
		<c:forEach items="${users}" var="user">
			<tbody>
				<tr>
					<td scope="row">${user.id}</td>
					<td>${user.username}</td>
					<td>${user.firstName} ${user.lastName}</td>
					<td>${user.role }</td>
					<td>${user.enabled}</td>

					
					<td>
					<form action="adminEditEnable.do" action="POST">
						<input type="hidden" name="id" value="${user.id}" /> 
						<input class="form-check-input" type="radio" name="enabled"
							value="1" /> Enable <input class="form-check-input" TYPE="radio"
							name="enabled" value="0" /> Disable
						<input name = "submit" type="submit" value="Update"/>

					</form>
				</td>
				</tr>
			</tbody>
		</c:forEach>
	</table>
</body>
</html>