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
<title>Currency Info</title>
</head>
<body class="bg-dark text-light" >
	<div class="container-fluid">
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
				    	<a href="/dashboard" class="btn text-white m-1">Dashboard</a>
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
	    <div class="d-flex" style="height: 100px;">
  			<div class="vr"></div>
		</div>
		<div class="container-fluid">
		
			<div class="row align-items-start">
				<div class="container-fluid">
					<div class=" row row-cols-auto">
					
						<div class="nsr col border-bottom m-x-left-1">
							<div class="container-fluid  border-right">
								<div class="row align-items-start">
									<div class=" row row-cols-auto">	
									<h1 class="col"><c:out value="${currency.name }"/></h1>
									<p class="col row align-items-center  "><c:out value="${currency.symbol }"/></p>
									<p>Rank: ${currency.cmc_rank }</p>
									</div>
								</div>
							</div>
						</div>
					<div class="addToWatchlist col pr-3 mr-5">
						<div class="row align-items-center mt-4" >
							<div class="col">
								<c:choose>
									<c:when test="${WatchlistItemId == null }">
										<div class="row">
											<form:form action="/info/${currency.id}/add_to_watchlist" method="post" modelAttribute="thisWatchlist" class="form">
															
												<div class="form-group col align-self-center">
													<form:label path="apiId" for="apiId"></form:label>
													<form:input path="apiId" type="hidden"  name="apiId" id="apiId" class="form-control"/>
																
												</div>
												
												<form:hidden path="watcher" value="${user.id }"/>
												<input type="submit" value="Add To Watchlist" class="btn btn-outline-primary">
														
											</form:form>
										</div>
									</c:when>
									<c:otherwise>
										<div class="row mt-4">
											<form class="delete-form" action="/${WatchlistItemId}/remove_from_watchlist" method="POST">
												<div class="form-group ">
													
													<input type="hidden" name="_method" value="delete">
													<input type="submit" value="Remove From Watchlist" class="btn btn-outline-danger m-y-top-2">
												</div>
											</form>
										</div>
									</c:otherwise>
								</c:choose>
							</div>
						</div>
			 		</div>
			 		
			 		
					<div class="d-flex justify-content-start bd-highlight">
                    <div class="d-flex justify-content-start bd-highlight">
                        <div class="d-flex justify-content-start bd-highlight mt-5">
                            <div class="d-flex justify-content-start ms-5">
                                <h3 class="bd-highlight ps-5">Current Price:</h3>
                            </div>
                        <div class ="d-flex justify-content-center mt-1">
                            <div class ="">
                            <c:set var = "checkPrice" value="${currency.quote.USD.percent_change_24h }"/>
                            <c:choose>
                                <c:when test="${fn:contains(checkPrice, '-')}">
                                    <div class="d-flex flex-row">
                                        <div class="col ps-1">
                                            <h4 class="text-danger fas fa-sort-down"></h4>
                                        </div>
                                        <div class="col">
                                            <h4 class="text-danger pe-2"> $${currency.quote.USD.price } </h4>
                                        </div>
                                    </div>
                                </c:when>
                                <c:otherwise>
                                    <div class="d-flex flex-row">
                                        <div class="col ps-1">
                                            <h4 class="text-success fas fa-caret-up"></h4>
                                        </div>
                                        <div class="col">
                                            <h4 class="text-success pe-2">  $${currency.quote.USD.price } </h4>
                                        </div>
                                    </div>
                                </c:otherwise>
                            </c:choose>
                         </div>
                            <!-- PERCENT CHANGE -->
						<c:set var = "checkPercent" value="${currency.quote.USD.percent_change_24h }"/>
                            <c:choose>
                                <c:when test="${fn:contains(checkPercent, '-')}">
                                <div>
                                    <span class="badge bg-danger"> ${currency.quote.USD.percent_change_24h }% </span>
                                </div>

                                </c:when>
                                <c:otherwise>
                                  <div>
                                    <span class="badge bg-success"> ${currency.quote.USD.percent_change_24h }% </span>
                                </div>
                                </c:otherwise>
                            </c:choose>
                                </div>
                        </div>
                    </div>
                </div>
                
					<div class="addPosition col-lg offset-md-2 border-bottom border-left pr-5">
						<div class="container border-dark mr-5 pr-5">
							<div class="head">
								<h4>Add to your positions</h4>
							</div>
							<strong>
								<p class="text-sm-left" style="font-size: larger;">${createError}</p>
							</strong>
							<div class="form">
								<form:form action="/info/${currency.id}/create_position" method="post" modelAttribute="position" class="form">
									<form:hidden path="apiId" value="${currency.id }"/>
									<div class="form-group">
										<form:errors path="positionSize" class="errors"/>
										<form:label path="positionSize" for="positionSize">Position Size</form:label>
										<form:input path="positionSize" type="float" name="positionSize" id="positionSize" class="form-control"/>
										
									</div>
									<form:hidden path="owner" value="${user.id }"/>
									<input type="submit" value="Add To Positions" class="btn btn-outline-primary m-3">
								</form:form>
							</div>
						</div>
						
					</div>
					</div>
				</div>
				
			</div>
			
		</div>	

		<div class="container-fluid ">
			<div class="row align-items-center m-3">
				
					<div class="supply col">
						<h3 class="m-3">Circulating Supply</h3>
						<p class="m-4"> ${currency.circulating_supply } ${currency.symbol }</p>
						
						<c:if test="${currency.max_supply != null}">
                        <p>${currency.circulating_supply/currency.max_supply * 100}%</p>
                            <div class="progress w-50" style="height: 4px;">
                                  <div class="progress-bar bg-success" role="progressbar" style="width: ${currency.circulating_supply/currency.max_supply * 100}%"></div>
                            </div>
                        </c:if>
						
						<h3 class="m-3">Max Supply</h3>
						<p class="m-4">${currency.max_supply } ${currency.symbol }</p>
						<h3 class="m-3">Total Supply</h3>
						<p class="m-4"> ${currency.total_supply } ${currency.symbol }</p>
					</div>
					<div class="marketCap col ">
						<div class="container border-bottom-0">
							<h3 class="m-3">Market Cap</h3>
							<p class="m-4">$${currency.quote.USD.market_cap }</p>
							<h3 class="m-3">Fully diluted Market Cap</h3>
							<p class="m-4">$${currency.quote.USD.fully_diluted_market_cap }</p>
						</div>
					</div>
					<div class="volume col">
						<h3  class="m-3">Volume 24hr</h3>
						<p class="m-4">$${currency.quote.USD.volume_24h }</p>
						<p class="m-4">${currency.quote.USD.volume_change_24h }%</p>
					</div>
				
			</div>
		</div>
	</div>
</body>
</html>