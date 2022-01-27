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
<title>Insert title here</title>
</head>
<body>
	<div class="container-fluid bg-light p-0">
		<div class="navbar fixed-top row align-items-start p-1 bg-secondary border border-dark">
		
			<Div class="container-fluid">
			
				<div class=" row row-cols-auto">
				
			    	<div class="  navbar-text">
			    		<div class="navbrand font-size-md text-white">
				    		<h1 class="color-light">Welcome <c:out value="${user.firstName }"/> |</h1>
				  
				    	</div>
				    </div>
				    
				    <div class=" navbar-text">
				    	<a href="/logout" class="btn text-danger m-1">Logout</a>
				    </div>
				    
				    <div class=" navbar-text ">
				    	<a href="/dashboard" class="btn text-white m-1">Dashboard</a>
				    </div>
				    
				    <div class=" navbar-text ">
				    	<a href="/top200" class="btn text-white m-1 m-right-5">Top 200 coins</a>
				    </div>
				    
			    </div>
			    
			    <form action="/search" method="get"class="d-flex">
			    	<input class="form-control me-2" type="search" name="symbol" placeholder="Search Symbol" aria-label="Search">
			    	<button class="btn btn-outline-dark bg-light" type="submit">Search</button>
			    </form>
			    
			</div>
	    </div>
	    <div class="d-flex" style="height: 80px;">
  			<div class="vr"></div>
		</div>
		<div class="container">

				<div class=" position-absolute top-50 start-50 translate-middle">
					<div class="container p-5 border-outline-dark">
						<div  class="title">
							<h3>Edit your position in ${currency.name }, ${currency.symbol }</h3>
							<h5 class="m-3">Currently trading at: $${currency.quote.USD.price }</h5>
						</div>
						<strong>
							<p class="text-sm-left" style="font-size: larger;">${updateError}</p>
						</strong>
						<div class="">
							<form:form action="/position/${position.id}/update" method="post" modelAttribute="position" class="form">
								<input type="hidden" name="_method" value="put">
								
								<div class="form-group">
									<form:errors path="positionSize" class="errors"/>
									<form:label path="positionSize" for="positionSize">Position Size</form:label>
									<form:input path="positionSize" type="int" name="positionSize" id="positionSize" value="${position.positionSize}" class="form-control"/>
									
								</div>
								<p>Current position value with ${position.positionSize} ${currency.symbol} = $${position.positionSize * currency.quote.USD.price}</p>
								<form:hidden path="owner" value="${user.id }"/>
							
								<input type="submit" value="Update Size" class="btn btn-outline-primary m-2">
							</form:form>
						</div>
						<div class="row m-top-3">
							<form class="delete-form" action="/position/${position.id}/delete" method="POST">
								<input type="hidden" name="_method" value="delete">
								<input type="submit" value="Close Position" class="btn btn-outline-danger m-2">
							</form>
							
							
						</div>
					</div>
			</div>
			
		</div>
		
	</div>
</body>
</html>