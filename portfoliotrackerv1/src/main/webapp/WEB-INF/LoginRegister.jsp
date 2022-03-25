<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ taglib prefix = "c" uri = "http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix = "fmt" uri = "http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
<!-- for Bootstrap CSS -->
	<link rel="stylesheet" href="/webjars/bootstrap/css/bootstrap.min.css" />
	<!-- For any Bootstrap that uses JS or jQuery-->
	<script src="/webjars/jquery/jquery.min.js"></script>
	<script src="/webjars/bootstrap/js/bootstrap.min.js"></script>
<meta charset="ISO-8859-1">
<title>Login or Register</title>
</head>
<body>
<div class="container-fluid  bg-dark p-2">
	<div class="row">
		<div class="col-6 offset-md-3 align-self-center">
			<div class="row m-2 p-2 w-75 text-white">
				<div class="col">
					<div class="row">
						<h1>Welcome to AK's Portfolio Tracker</h1>
					</div>
					<div class="row justify-content-start">
						<div class="col-6">
							<h4>Please register or login</h4>
						</div>
						
					</div>
				</div>
				
			</div>
			<div class="row m-2">
			
				<div class="col p-3 bg-light rounded m-2 border">
		            <h2>Register</h2>
					<div class=" container">
						<div class="container p-3 mb-2">
		
							<strong>
								<p class="text-lg-left" style="font-size: larger;"><form:errors path="user.*"/></p>
							</strong>
		
						</div>
					</div>
					<form:form action="/register" method="POST" class="m-1" modelAttribute="user">
	
						<div class="form-group m-1">
							<form:label path="firstName">First Name</form:label>
							<form:input class="form-control" path="firstName" />
						</div>
						<div class="form-group m-1">
							<form:label path="lastName">Last Name</form:label>
							<form:input class="form-control" path="lastName" />
						</div>
						<div class="form-group m-1">
							<form:label path="email">Email</form:label>
							<form:input type="email" class="form-control" path="email" />
						</div>
						<div class="form-group m-1">
							<form:label path="password">Password</form:label>
							<form:password class="form-control" path="password" />
						</div>
						<div class="form-group m-1">
							<form:label path="passwordConfirmation">Confirm Password</form:label>
							<form:password class="form-control" path="passwordConfirmation" />
						</div>
			
						<input type="submit" name="" id="" value="Register" class="btn btn-primary m-2">
					</form:form>
		
				</div>
				
			</div>
			<div class="row  m-2 mb-3">
				<div class="col p-3 bg-light rounded m-2 mb-5 border">
					<h2>Login</h2>
	
					<div class=" container">
						<div class="container p-3 mb-2">
		
							<strong>
								<p class="text-lg-left" style="font-size: larger;">${loginError}</p>
							</strong>
		
						</div>
					</div>
					<form action="/login" method="POST" class="m-1">
						<div class="form-group m-1">
							<label for="email">Email</label>
							<input type="email" name="email" id="email" class="form-control" />
						</div>
						<div class="form-group m-1">
							<label for="password">Password</label>
							<input type="password" name="password" id="password" class="form-control" />
						</div>
						<input type="submit" value="Login" class="btn btn-primary m-2">
					</form>
				</div>
			</div>
		</div>
		<div class="col p-2 m-3">
			<a class="text-white" href="/dashboard">View site as guest</a>
		</div>
	</div>
</div>
</body>
</html>