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
<title>Dashboard</title>
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
				    	<a href="/top200" class="btn text-white m-1 m-right-5">Top 200 coins</a>
				    </div>
				    
			    </div>
			    
			    <form action="/search" method="get"class="d-flex">
			    	<input class="form-control me-2" type="search" name="symbol" placeholder="Search Symbol" aria-label="Search">
			    	<button class="btn btn-outline-dark bg-light" type="submit">Search</button>
			    </form>
			    
			</div>
	    </div>
	    <div class="d-flex" style="height: 30px;">
  			<div class="vr"></div>
		</div>
	    <div class="card-group mt-5">
	    
	    		
	    
		    	<div class="watchlist col align-self-start border border-dark">
			    	<div class="col">
				    	<div class="card h-460">
					    	<div class="card-body">
					    	
					    		<h5 class="card-title">Your WatchList</h5>
					    		<div class="datatable-inner table-responsive ps ps--active-y" style="overflow: auto; position: relative; max-height: 460px;">
							    	<div class="datatable-inner table-responsive ps ps--active-y" style="overflow: auto; position: relative; max-height: 460px;">
								    	
								    	<table id="dtDynamicVerticalScrollExample" class="table  table-sm card-text" >
									    	<tr class="table-light">
									    	
									    		<th class="fixed-cell th-sm">Symbol</th>
									    		<th class="fixed-cell th-sm">Price</th>
									    		<th class="fixed-cell th-sm">Change</th>
									    		
									    	</tr>		
									    	<c:forEach items="${user.watchlist}" var="watchlistItem" varStatus="loop">
									    		<c:forEach items="${currencies}" var="currency">
									    			<c:if test="${watchlistItem.apiId == currency.id}">
											    		<tr>
															<td><a href="info/${currency.id }" class="btn text-dark btn-outline-light">${currency.symbol}</a></td>
															<td><p>$${currency.quote.usd.price}</p></td>
															<td><p>${currency.quote.usd.percentChange24h}%</p></td>
														</tr>
													</c:if>
												</c:forEach>
									    	</c:forEach>
								    	</table>
							    	</div>
								</div> 
								
								   
						    </div>
						    <div class="card-footer">
						    	<small class="text-muted">${currency.lastUpdated }</small>
						    </div>
					    </div>
					</div>
			    </div>
			    <div class="accountvalue col align-self-start border border-dark">
				    <div class="col">
					    <div class="card h-460">
					    
						    <div class="card-body">
						    
						    	<h5 class="card-title">Account Value</h5>
						    	<h6>$65,000</h6>
						    	
						    </div>
						    <div class="card-footer">
						    	<small class="text-muted">${currency.lastUpdated }</small>
						    </div>
						    
						</div>
						
					</div>
				</div>
				<div class="container col align-self-start border border-dark ">
					
					<div class="col col-lg-auto  ">
						<div class="card h-4600">
						    <div class="card-body">
						    	<h5 class="card-title">Top Coins</h5>
						    	<div class="datatable-inner table-responsive ps ps--active-y" style="overflow: auto; position: relative; max-height: 460px;">
							    	<div class="datatable-inner table-responsive ps ps--active-y" style="overflow: auto; position: relative; max-height: 460px;">
						    
								    	
								    	<table id="dtDynamicVerticalScrollExample" class="table table-sm card-text">
										    	<tr class="table-light">
										    		
										    		<th class="fixed-cell th-sm">Name</th>
										    		<th class="fixed-cell th-sm">Symbol</th>
										    		<th class="fixed-cell th-sm">Price</th>
										    		<th class="fixed-cell th-sm">Change</th>
										    		
										    	</tr>		
			
										    		<c:forEach items="${currencies}" var="currency">
			
												    		<tr>
												    			<td>${currency.name}</td>
																<td><a href="info/${currency.id }" class="btn text-dark btn-outline-light">${currency.symbol}</a></td>
																<td><p>$${currency.quote.usd.price}</p></td>
																<td><p>${currency.quote.usd.percentChange24h}%</p></td>
															</tr>
			
													</c:forEach>
			
									    	</table>
								    
						    		</div>
						    	</div>
						    
						    </div>
						    <div class="card-footer">
						    	<small class="text-muted">${currency.lastUpdated }</small>
						    </div>
					    </div>
				    </div>
				    <div class="col m-2">
					
					</div>
			    </div>
			    
			    
		    
	    </div>
	    <div class="container">
	    	<div class="col  m-2">
					
			</div>
			
		    <div class="col col-lg-auto " >
		    	<div class=" " >
					    <h5 class="card-title">Your Positions</h5>
						<table  class="table  table-sm card-text border" >
							<tr class="table-light">
									    	
					    		<th class="">Symbol</th>
					    		<th class="">Current Price</th>
					    		<th class="">Position Size</th>
					    		<th class="">Position Value</th>
					    		<th class="">Actions</th>
									    		
					    	</tr>		
				    	<c:forEach items="${user.positions}" var="position" varStatus="loop">
				    		<c:forEach items="${currencies}" var="currency">
				    			<c:if test="${position.apiId == currency.id}">
						    		<tr>
										<td><a href="info/${currency.id }" class="btn text-dark btn-outline-light">${currency.symbol}</a></td>
										<td><p>$${currency.quote.usd.price}</p></td>
										<td><p>${position.positionSize}</p></td>
										<td><p>$${position.positionSize * currency.quote.usd.price}</p></td>
										<td class="text-start"><a href="/position/${position.id}/edit" class="btn btn-sm text-dark btn-outline-light">Edit</a>|
										<form class="delete-form" action="/position/${position.id}/delete" method="POST">
										<input type="hidden" name="_method" value="delete">
										<input type="submit" value="Close" class="btn btn-sm text-danger m-2"></form></p></td>
										 
									</tr>
								</c:if>
							</c:forEach>
				    	</c:forEach>
				    </table>
			    </div>
			</div>
			</
		</div>
		
	</div>
</body>
</html>