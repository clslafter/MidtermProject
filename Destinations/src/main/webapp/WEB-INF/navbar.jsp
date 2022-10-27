<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<nav class="navbar navbar-expand-md navbar-light bg-light sticky-top">
  <div class="container-fluid">
    <a class="navbar-brand" href="welcome.do"><img src="https://cdn-icons-png.flaticon.com/512/201/201623.png" style="width: 50px;  height: 50px;" ></a>
    <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav" aria-controls="navbarNav" aria-expanded="false" aria-label="Toggle navigation">
      <span class="navbar-toggler-icon"></span>
    </button>
    <div class="collapse navbar-collapse" id="navbarNav">
      <ul class="navbar-nav ml-auto">
       <c:choose>
       <c:when test = "${user == null}">
        <li class="nav-item">
          <a class="nav-link active" aria-current="page" href="login.do">Home</a>
        </li>
        <li class="nav-item">
          <a class="nav-link" href="createAccount.do">Create Account</a>
        </li>
        <li class="nav-item">
          <a class="nav-link" href="login.do">Login</a>
        </li>
       </c:when>
       <c:otherwise>
        <li class="nav-item">
          <a class="nav-link active" aria-current="page" href="home.do">Home</a>
        </li>
        <li class="nav-item">
          <a class="nav-link" href="showUserProfile.do">My Profile</a>
        </li>
        <li class="nav-item">
          <a class="nav-link" href="createDestination.do">Create New Destination</a>
        </li>
        <li class="nav-item">
          <a class="nav-link" href="logout.do">Logout</a>
        </li>
       </c:otherwise>
       </c:choose>
       
        
      </ul>
    </div>
  </div>
</nav>