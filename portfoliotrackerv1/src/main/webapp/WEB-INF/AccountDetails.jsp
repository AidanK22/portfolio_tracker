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
	<div class="container-fluid bg-dark p-1">
		<div class="navbar fixed-top row align-items-start p-1 bg-dark border-bottom">
		
			<Div class="container-fluid">
			
				<div class=" row row-cols-auto">
				
			    	<div class="  navbar-text">
			    		<div class="navbrand font-size-md text-white">
				    		<h1 class="color-light">Welcome <c:out value="${user.firstName }"/> |</h1>
				  
				    	</div>
				    </div>
				    <div class=" navbar-text ">
				    	<a href="/dashboard" class="btn text-white m-1">Dashboard</a>
				    </div>
				    <div class=" navbar-text ">
				    	<a href="/top200" class="btn text-white m-1 m-right-5">Top 200 coins</a>
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
						          	<li><a class="dropdown-item disabled" href="/account_details">Account Details</a></li>
						            <li><a class="dropdown-item text-danger" href="/logout">Logout</a></li>
						            
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
		<div class="row justify-content-center">
			<div class="col-auto bg-dark m-3 offset-md-3 text-white border">
				<h3>Account Details</h3>
			</div>
		</div>
		<div class="row justify-content-center">
			<div class="col-auto bg-dark m-3 offset-md-3 p-3 text-white border">
				<h5>First Name: <c:out value="${user.firstName }"/></h5>
				<h5>Last Name: <c:out value="${user.lastName }"/></h5>
				<h5>Email: <c:out value="${user.email}"/></h5>
				
			</div>
		</div>
		<div class="row">
			
			<div class="col bg-dark m-4 p-3  border">
				
				<div class="row">
					<div class="accountvalue col align-self-start border border-dark mt-1">
					    <div class="col">
						    <div class="card h-460">
						    
							    <div class="card-body">
							    
							    	<h5 class="card-title">Account Value</h5>
							    	<h6>$<c:out value="${accountValue }"/></h6>
							    	
							    </div>
							    <div class="card-footer">
							    	<small class="text-muted">${currency.lastUpdated }</small>
							    </div>
							    
							</div>
							
						</div>
					</div>
				</div>
				<div class="row">
				 	<div class="col col-lg-auto" >
						<div class="container bg-light rounded p-2" >
							    <h5 class="card-title">Your Positions (${amountOfPositions})</h5>
								<table  class="table  table-sm card-text border-rounded border bg-light" >
									<tr class="table-light">
											    	
							    		<th class="">Symbol</th>
							    		<th class="">Position Size</th>
							    		<th class="">Current Price</th>
							    		<th class="">Position Value</th>
							    		<th class="">Percent of Portfolio</th>
							    		<th class="">Actions</th>
											    		
							    	</tr>
							    	<c:choose>
							    		<c:when test="${user.positions == null }">
							    			<tr>
												<td><p>Your Positions are empty</td>
											</tr>
							    		</c:when>
							    		<c:otherwise>		
									    	<c:forEach items="${user.positions}" var="position" varStatus="loop">
									    		<c:forEach items="${pcurrencies}" var="pcurrency">
													<c:if test="${position.apiId == pcurrency.id }">
														<tr style="vertical-align: baseline;">
															<td><a href="info/${pcurrency.id }" class="btn text-dark btn-outline-light">${pcurrency.symbol}</a></td>
															<td><p>${position.positionSize}</p></td>
															<td>$<fmt:formatNumber type="number" maxFractionDigits="7" value="${pcurrency.quote.USD.price}"/></td>
															
															<td>$<fmt:formatNumber type="number" maxFractionDigits="5" value="${position.positionSize * pcurrency.quote.USD.price}"/></td>
															<td><fmt:formatNumber type="number" maxFractionDigits="2" value="${position.positionSize * pcurrency.quote.USD.price / accountValue * 100}"/>%</td>
															<td style="display:flex; align-items: center;" class="text-start"><a href="/position/${position.id}/edit" class="btn btn-sm text-dark btn-outline-light">Edit</a>|
															<form class="delete-form" action="/position/${position.id}/delete" method="POST">
															<input type="hidden" name="_method" value="delete">
															<input type="submit" value="Close" class="btn btn-sm text-danger m-2"></form></p></td>
															 
														</tr>
													</c:if>
													
												</c:forEach>
					  				    	</c:forEach>
				  				    	</c:otherwise>
		  				    		</c:choose>
						    </table>
					    </div>
					</div>
			    </div>
			</div>
			<div class="col-3 bg-dark m-4 ms-5 text-white border">
				
			</div>
		</div>
	</div>
</body>
</html>