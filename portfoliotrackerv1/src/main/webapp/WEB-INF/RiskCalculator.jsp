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
<body class="bg-dark text-light">
<div class="container-fluid ">
		<div class="navbar fixed-top row align-items-start  ps-3 pe-3 bg-dark border-bottom">
		
			<Div class="container-fluid">
			
				<div class=" row row-cols-auto">
				
			    	<div class="  navbar-text">
			    		<c:choose>
			    			<c:when test="${ user != null }">
					    		<div class="navbrand font-size-md text-white">
						    		<h1 class="color-light">Welcome <c:out value="${user.firstName }"/> |</h1>
						  
						    	</div>
					    	</c:when>
					    	<c:otherwise>
					    		<div class="navbrand font-size-md text-white">
						    		<h1 class="color-light">Welcome <c:out value="${noUser }"/> |</h1>
						    	</div>
					    	</c:otherwise>
				    	</c:choose>
				    </div>
				    <div class=" navbar-text ">
				    	<a href="/dashboard" class="btn text-white m-1 ">Dashboard</a>
				    </div>
				    <div class=" navbar-text ">
				    	<a href="/top200" class="btn text-white m-1 m-right-5">Top 200 coins</a>
				    </div>
				    <div class=" navbar-text ">
				    	<a href="/risk_calculator" class="btn text-white m-1 m-right-5 disabled">Risk Calculator</a>
				    </div>
				    <div class=" navbar-text ">
					    <div class="dropdown ">
						          <a class="nav-link dropdown-toggle text-white mt-1" href="#" id="navbarDarkDropdownMenuLink" role="button" data-bs-toggle="dropdown" aria-expanded="false">
						            Settings
						          </a>
						          <ul class="dropdown-menu dropdown-menu-dark" aria-labelledby="navbarDarkDropdownMenuLink">
						          	<li><a class="dropdown-item" href="/account_details/${user.id }">Account Details</a></li>
						          	<c:choose>
						    			<c:when test="${ user != null }">
								    		
									    		<li><a class="dropdown-item text-danger" href="/logout">Logout</a></li>
									  
								    	</c:when>
								    	<c:otherwise>
								    		<li><a class="dropdown-item text-primary" href="/logout">Sign In</a></li>
								    	</c:otherwise>
							    	</c:choose>
						            
						            
						          </ul>
					    </div>
				    </div>
			    </div>
			    
			    <form action="/search" method="get"class="d-flex">
			    	<input class="form-control me-2" type="search" name="symbol" placeholder="Search Symbol" aria-label="Search">
			    	<button class="btn btn-outline-dark bg-light" type="submit">Search</button>
			    </form>
			    
			</div>
	    </div>
	    <div class="d-flex" style="height: 100px;">
  			<div class="vr"></div>
		</div>
		<div class="container bg-light">

				<div class=" position-absolute top-50 start-50 translate-middle">
					<div class="container p-5 border-dark">
				        <h1>EXPECTED OUTCOME CALCULATOR</h1>
				        <div class="cform ">
				            <form action="/calculate" method="POST">
				                
				                <div class="form-group m-2">
					                <label for="amountRisked">Amount Risked</label>
					                <div class="col">
					                	<span class="currency"><input name="amountRisked" type="number" step="0.01"></span>
									</div>
								</div>
								<div class="form-group m-2">
					                <label for="potentialProfit">Potential Profit</label>
					                <div class="col">
					                	<span class="currency"><input name="potentialProfit" type="number" step="0.01"></span>
									</div>
								</div>
								<div class="form-group m-2">
					                <label for="probability">% Probability</label>
					                <div class="col">
					                	<span class="probability"><input name="probability" type="number"></span>
									</div>
								</div>
								<div class="form-group m-2">
				                	<button class="btn btn-outline-primary m-2" type="submit">Calculate</button>
				                </div>
				            </form>
				        </div>
				        <div class="position_details">
				            <h2>Position Details:</h2>
				            <p>amount risked: <c:out value="${aRisked}"/></p>
				            <p>potential profit: <c:out value="${pProfit}"/></p>
				            <p>probability: <c:out value="${prob}"/></p>
				        </div>
				        <div class="rrr">
				            <h2>Risk to Reward Ratio:</h2>
				            <h4><c:out value="${rrr}"/></h4>
				        </div>
				        <div class="eo">
				            <h2> Expected Outcome:</h2>
				            <p>10 Occurences</p>
				            <h4><c:out value="${eo}"/></h4>
				        </div>
					</div>
				</div>
			</div>
    </div>
</body>
</html>