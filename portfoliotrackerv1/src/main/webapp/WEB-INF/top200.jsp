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
<title>Top 200</title>
</head>
<body>
<div class="container-fluid bg-dark">
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
				    	<a href="/top200" class="btn text-white m-1 m-right-5 disabled">Top 200 coins</a>
				    </div>
				    <div class=" navbar-text ">
				    	<a href="/risk_calculator" class="btn text-white m-1 m-right-5">Risk Calculator</a>
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
		<div class="container bg-light p-3 rounded">
			<div class="title">
				<h3>Top 200</h3>
				<p>Crypto assets sorted by market cap.</p>
			</div>
			
		    <div class="data-table bg-light">
				<table class="table">
				    <tr class="table-dark">
				    	
				    	<th>#</th>
				    	<th>Name</th>
				    	<th>Price</th>
				    	<th>24h % Change</th>
				    	<th>7d % Change</th>
				    	<th>Market Cap</th>
				    	<th>Volume</th>
				    		
				    </tr>		
	
				    	<c:forEach items="${currencies}" var="currency">
	
					    		<tr style="vertical-align: baseline;">
					    			<td><p>${currency.cmcRank }</p></td>
									<td ><a href="info/${currency.id }" class="btn text-dark btn-outline-light">${currency.name} ${currency.symbol}</a></td>
									<td><p>$${currency.quote.usd.price}</p></td>
									<td><fmt:formatNumber type="number" maxFractionDigits="2" value="${currency.quote.usd.percentChange24h}"/>%</td>
									<td><p>${currency.quote.usd.percentChange7d}%</p></td>
									<td><p>$${currency.quote.usd.marketCap}</p></td>
									<td><p>$${currency.quote.usd.volume24h}</p></td>
								</tr>
						</c:forEach>
			    </table>
			 </div>  
		 </div>
</div>
</body>
</html>