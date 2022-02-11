<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ taglib prefix = "c" uri = "http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix = "fmt" uri = "http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib uri = "http://java.sun.com/jsp/jstl/functions" prefix = "fn" %>
<!DOCTYPE html>
<html>
<head>
<!-- for Bootstrap CSS -->
	<link rel="stylesheet" href="/webjars/bootstrap/css/bootstrap.min.css" />
	<!-- For any Bootstrap that uses JS or jQuery-->
	<script src="/webjars/jquery/jquery.min.js"></script>
	<script src="/webjars/bootstrap/js/bootstrap.min.js"></script>
	<script src='https://kit.fontawesome.com/a076d05399.js' crossorigin='anonymous'></script>
<meta charset="ISO-8859-1">
<title>Dashboard</title>
</head>
<body>
	<div class="container-fluid bg-light p-0 bg-dark">
		<div class="navbar fixed-top row align-items-start p-1 bg-dark border-bottom">
		
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
				    <div class=" navbar-text ">
				    	<a href="/risk_calculator" class="btn text-white m-1 m-right-5">Risk Calculator</a>
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
	    
	    		
	    
		    	<div class="watchlist col align-self-start border border-dark mt-1 m-3">
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
									    	<c:choose>
										    	<c:when test="${user.watchlist == null }">
										    		<tr>
										    			<td><p>Your WatchList is empty</td>
										    		</tr>
										    	</c:when>
										    	<c:otherwise>	
										    	<c:forEach items="${user.watchlist}" var="watchlistItem" varStatus="loop">
										    		<c:forEach items="${pcurrencies}" var="pcurrency">
										    			<c:if test="${watchlistItem.apiId == pcurrency.id}">
												    		<tr style="vertical-align: baseline;">
																<td><a href="info/${pcurrency.id }" class="btn text-dark btn-outline-light">${pcurrency.symbol}</a></td>
																<td>
																<!-- PRICE  -->
																<c:set var = "checkPrice" value="${pcurrency.quote.USD.percent_change_24h}"/>
																<c:choose>
																	
																	<c:when test="${fn:contains(checkPrice, '-')}">
																		<h4 class="text-danger fas fa-sort-down">$<fmt:formatNumber type="number" maxFractionDigits="7" value="${pcurrency.quote.USD.price}"/></h4>
																	</c:when>
																	<c:otherwise>
																		<h4 class="text-success fas fa-caret-up">$<fmt:formatNumber type="number" maxFractionDigits="7" value="${pcurrency.quote.USD.price}"/></h4>
																	</c:otherwise>
																</c:choose>
																</td>
																<td>
																<!-- PERCENT CHANGE -->
																	<c:set var = "checkPercent" value="${pcurrency.quote.USD.percent_change_24h}%"/>
																	<c:choose>
																		<c:when test="${fn:contains(checkPercent, '-')}">
																			<h4 class="text-danger fas fa-sort-down"><fmt:formatNumber type="number" maxFractionDigits="3" value="${pcurrency.quote.USD.percent_change_24h}"/>%</h4>
																		</c:when>
																		<c:otherwise>
																			<h4 class="text-success fas fa-caret-up"> <fmt:formatNumber type="number" maxFractionDigits="3" value="${pcurrency.quote.USD.percent_change_24h}"/>%</h4>
																		</c:otherwise>
																	</c:choose>
																</td>
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
						    <div class="card-footer">
						    	<small class="text-muted">${currency.lastUpdated }</small>
						    </div>
					    </div>
					</div>
			    </div>
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
				<div class="container col align-self-start border border-dark m-1">
					
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
			
												    		<tr style="vertical-align: center;">
												    			<td>${currency.name}</td>
																<td><a href="info/${currency.id }" class="btn text-dark btn-outline-light">${currency.symbol}</a></td>
																<td>
																<!-- PRICE  -->
																<c:set var = "checkPrice" value="${currency.quote.usd.percentChange24h }"/>
																<c:choose>
																	
																	<c:when test="${fn:contains(checkPrice, '-')}">
																		<h4 class="text-danger fas fa-sort-down">$<fmt:formatNumber type="number" maxFractionDigits="7" value="${currency.quote.usd.price }"/></h4>
																	</c:when>
																	<c:otherwise>
																		<h4 class="text-success fas fa-caret-up">$<fmt:formatNumber type="number" maxFractionDigits="7" value="${currency.quote.usd.price }"/></h4>
																	</c:otherwise>
																</c:choose>
																</td>
																<td>
																<!-- PERCENT CHANGE -->
																	<c:set var = "checkPercent" value="${currency.quote.usd.percentChange24h }"/>
																	<c:choose>
																		<c:when test="${fn:contains(checkPercent, '-')}">
																			<h4 class="text-danger fas fa-sort-down"><fmt:formatNumber type="number" maxFractionDigits="3" value="${currency.quote.usd.percentChange24h}"/>%</h4>
																		</c:when>
																		<c:otherwise>
																			<h4 class="text-success fas fa-caret-up"> <fmt:formatNumber type="number" maxFractionDigits="3" value="${currency.quote.usd.percentChange24h}"/>%</h4>
																		</c:otherwise>
																	</c:choose>
																</td>
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
		    	<div class="container bg-light rounded p-2" >
					    <h5 class="card-title">Your Positions (${amountOfPositions})</h5>
						<table  class="table  table-sm card-text border bg-light" >
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
			</
		</div>
		
	</div>
</body>
</html>