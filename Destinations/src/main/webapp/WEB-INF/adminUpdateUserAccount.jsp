<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<table class="table table-dark table-striped">
		<thead>
			<tr>
				<th scope="col">ID</th>
				<th scope="col">Username</th>
				<th scope="col">Full Name</th>
				<th scope="col">Role</th>
				<th scope="col">Enabled</th>
			</tr>
		</thead>
			<tbody>
				<tr>
					<td scope="row">${user.id}</td>
					<td>${user.username}</td>
					<td>${user.firstName} ${user.lastName}</td>
						<td>
							<form action="userUpdated.do" method="POST">
							${user.role }
							</form>
						</td>
						<td>${user.enabled}</td>
				</tr>
			</tbody>
	</table>
</body>
</html>