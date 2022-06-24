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
<body class="bg-dark">
	<div class="container-fluid pe-3 bg-dark">
		<div class="navbar fixed-top row align-items-start ps-3 pe-3 bg-dark border-bottom">
		
			<Div class="container-fluid">
			
				<div class=" row row-cols-auto">
				
			    	<div class="  navbar-text p-2">
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
				    	<a href="/dashboard" class="btn text-white m-1 disabled">Dashboard</a>
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
						          	<c:choose>
						          		<c:when test="${user != null }">
						          			<li><a class="dropdown-item" href="/account_details/${user.id }">Account Details</a></li>
						            	</c:when>
						            	<c:otherwise>
						            		<li><a class="dropdown-item" href="/">Account Details</a></li>
						            	</c:otherwise>
						            </c:choose>
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
	    <div class="d-flex" style="height: 85px;">
  			<div class="vr"></div>
		</div>
		<div class="row p-2">
			<div class="col ">
				<!-- TradingView Widget BEGIN -->
				<div class="tradingview-widget-container" style="width: 100%; height: 50px;">
				  <div class="tradingview-widget-container__widget"></div>
				  <div class="tradingview-widget-copyright border-top"><a href="https://www.tradingview.com/markets/" rel="noopener" target="_blank"><span class="blue-text offset-lg-11 ">Markets</span></a> by TradingView</div>
				  <script type="text/javascript" src="https://s3.tradingview.com/external-embedding/embed-widget-ticker-tape.js" async>
				  {
				  "symbols": [
				    {
				      "proName": "FOREXCOM:SPXUSD",
				      "title": "S&P 500"
				    },
				    {
				      "proName": "BITSTAMP:BTCUSD",
				      "title": "Bitcoin"
				    },
				    {
				      "proName": "BITSTAMP:ETHUSD",
				      "title": "Ethereum"
				    },
				    {
				      "description": "XRP",
				      "proName": "BITSTAMP:XRPUSD"
				    },
				    {
				      "description": "Terra",
				      "proName": "BITFINEX:LUNAUSD"
				    },
				    {
				      "description": "Avalanche",
				      "proName": "BITFINEX:AVAXUSD"
				    },
				    {
				      "description": "Polkadot",
				      "proName": "BITFINEX:DOTUSD"
				    },
				    {
				      "description": "Polygon",
				      "proName": "BINANCEUS:MATICUSD"
				    },
				    {
				      "description": "Cosmos",
				      "proName": "COINBASE:ATOMUSD"
				    },
				    {
				      "description": "Litecoin",
				      "proName": "COINBASE:LTCUSD"
				    },
				    {
				      "description": "Chainlink",
				      "proName": "BITFINEX:LINKUSD"
				    },
				    {
				      "description": "Algorand",
				      "proName": "COINBASE:ALGOUSD"
				    },
				    {
				      "description": "Elrond",
				      "proName": "BITFINEX:EGLDUSD"
				    },
				    {
				      "description": "Monero",
				      "proName": "BITFINEX:XMRUSD"
				    }
				  ],
				  "showSymbolLogo": true,
				  "colorTheme": "dark",
				  "isTransparent": true,
				  "displayMode": "adaptive",
				  "locale": "en"
				}
				  </script>
				</div>
				<!-- TradingView Widget END -->
			</div>
		</div>
	    <div class="card-group mt-1 p-1">
	    
	    		
	    
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
										    	<c:when test="${user.watchlist.size() != 0 && user.watchlist.size() != null}">
										    		<c:forEach items="${user.watchlist}" var="watchlistItem" varStatus="loop">
										    		<c:forEach items="${pcurrencies}" var="pcurrency">
										    			<c:if test="${watchlistItem.apiId == pcurrency.id}">
												    		<tr style="vertical-align: baseline;">
																<td><a href="info/${pcurrency.id }" class="btn text-dark btn-outline-light">${pcurrency.symbol}</a></td>
																<td >
																<!-- PRICE  -->
																<c:set var = "checkPrice" value="${pcurrency.quote.USD.percent_change_24h}"/>
																<c:choose>
																	
																	<c:when test="${fn:contains(checkPrice, '-')}">
									                                            <h4 class="text-danger fs-5">$<fmt:formatNumber type="number" maxFractionDigits="7" value="${pcurrency.quote.USD.price}"/></h4>
																	</c:when>
																	<c:otherwise>
								                                            <h4 class="text-success pe-2 fs-5">$<fmt:formatNumber type="number" maxFractionDigits="7" value="${pcurrency.quote.USD.price}"/></h4>
																</c:otherwise>
																</c:choose>
																</td>
																<td style="display:flex; align-items: center;">
																<!-- PERCENT CHANGE -->
																	<c:set var = "checkPercent" value="${pcurrency.quote.USD.percent_change_24h}%"/>
																	<c:choose>
																		<c:when test="${fn:contains(checkPercent, '-')}">
																			<div class="d-flex ">
										                                        <div class="col ">
										                                            <h4 class="text-danger fas fa-sort-down ps-1 me-1 fs-5"></h4>
										                                        </div>
										                                        <div class="col">
										                                            <h4 class="text-danger fs-5"><fmt:formatNumber type="number" maxFractionDigits="3" value="${pcurrency.quote.USD.percent_change_24h}"/>%</h4>
										                                        </div>
									                                    	</div>
																		</c:when>
																		<c:otherwise>
																		<div class="d-flex flex-row">
																			<div class="col ps-1">
									                                            <h4 class="text-success fas fa-caret-up pe-1 me-1 fs-5"></h4>
									                                        </div>
									                                    
									                                        <div class="col">
									                                            <h4 class="text-success pe-2 fs-5"><fmt:formatNumber type="number" maxFractionDigits="3" value="${pcurrency.quote.USD.percent_change_24h}"/>%</h4>
									                                        </div>
									                                    </div>
																				
																		</c:otherwise>
																	</c:choose>
																</td>
															</tr>
														</c:if>
													</c:forEach>
										    	</c:forEach>
										    	</c:when>
										    	<c:otherwise>	
										    		<tr>
										    			<td><p>Your WatchList is empty</td>
										    		</tr>
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
			    <div class="row">
				    <div class="row-fluid ">
					    <div class="accountvalue col align-self-start border border-dark mt-1">
						    <div class="col-auto">
							    <div class="card ">
							    
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
						<div class="col col-sm me-3">
						<!-- TradingView Widget BEGIN -->
						<div class="tradingview-widget-container">
						  <div class="tradingview-widget-container__widget"></div>
						  <div class="tradingview-widget-copyright"><a href="https://www.tradingview.com/markets/cryptocurrencies/key-events/" rel="noopener" target="_blank"><span class="blue-text">Daily cryptocurrency news</span></a> by TradingView</div>
						  <script type="text/javascript" src="https://s3.tradingview.com/external-embedding/embed-widget-timeline.js" async>
						  {
						  "feedMode": "market",
						  "market": "crypto",
						  "colorTheme": "dark",
						  "isTransparent": true,
						  "displayMode": "regular",
						  "width": "100%",
						  "height": "100%",
						  "locale": "en"
						}
						  </script>
						</div>
						<!-- TradingView Widget END -->	
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
			
												    		<tr style="vertical-align: baseline;">
												    			<td>${currency.name}</td>
																<td><a href="info/${currency.id }" class="btn text-dark btn-outline-light">${currency.symbol}</a></td>
																<td>
																<!-- PRICE  -->
																<c:set var = "checkPrice" value="${currency.quote.usd.percentChange24h }"/>
																<c:choose>
																	
																	<c:when test="${fn:contains(checkPrice, '-')}">
																		<h4 class="text-danger fs-5">$<fmt:formatNumber type="number" maxFractionDigits="7" value="${currency.quote.usd.price }"/></h4>
																	</c:when>
																	<c:otherwise>
																		<h4 class="text-success fs-5">$<fmt:formatNumber type="number" maxFractionDigits="7" value="${currency.quote.usd.price }"/></h4>
																	</c:otherwise>
																</c:choose>
																</td>
																<td>
																<!-- PERCENT CHANGE -->
																	<c:set var = "checkPercent" value="${currency.quote.usd.percentChange24h }"/>
																	<c:choose>
																		<c:when test="${fn:contains(checkPercent, '-')}">
																			<div class="d-flex ">
										                                        <div class="col ">
										                                            <h4 class="text-danger fas fa-sort-down ps-1 fs-5"></h4>
										                                        </div>
										                                        <div class="col">
										                                            <h4 class="text-danger pe-3 fs-5"><fmt:formatNumber type="number" maxFractionDigits="3" value="${currency.quote.usd.percentChange24h}"/>%</h4>
										                                        </div>
									                                    	</div>
																		</c:when>
																		<c:otherwise>
																			<div class="d-flex flex-row">
																			<div class="col ps-1">
									                                            <h4 class="text-success fas fa-caret-up pe-1 fs-5"></h4>
									                                        </div>
									                                    
									                                        <div class="col">
									                                            <h4 class="text-success pe-3 fs-5"><fmt:formatNumber type="number" maxFractionDigits="3" value="${currency.quote.usd.percentChange24h}"/>%</h4>
									                                        </div>
									                                    	</div>
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
	    <div class="row">
	    	<div class="col  m-2">
					
			</div>
			
		    <div class="col-7 " >
		    	<div class="container bg-light rounded p-2" >
					<h5 class="card-title">Your Positions (${amountOfPositions})</h5>
					<div class="datatable-inner table-responsive ps ps--active-y" style="overflow: auto; position: relative; max-height: 620px;">
					
						<table id="dtDynamicVerticalScrollExample" class="table  table-sm card-text border bg-light" >
							<tr class="table-dark">
									    	
					    		<th class="">Symbol</th>
					    		<th class="">Position Size</th>
					    		<th class="">Current Price</th>
					    		<th class="">Position Value</th>
					    		<th class="">Percent of Portfolio</th>
					    		<th class="">Actions</th>
									    		
					    	</tr>
					    	<c:choose>
					    		<c:when test="${user.positions == null || user.positions.size() == 0 }">
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
			<div class="col col-sm me-3">
				<!-- TradingView Widget BEGIN -->
				<div class="tradingview-widget-container">
				  <div class="tradingview-widget-container__widget"></div>
				  <div class="tradingview-widget-copyright"><a href="https://www.tradingview.com/markets/cryptocurrencies/key-events/" rel="noopener" target="_blank"><span class="blue-text">Daily cryptocurrency news</span></a> by TradingView</div>
				  <script type="text/javascript" src="https://s3.tradingview.com/external-embedding/embed-widget-timeline.js" async>
				  {
				  "feedMode": "market",
				  "market": "crypto",
				  "colorTheme": "dark",
				  "isTransparent": true,
				  "displayMode": "regular",
				  "width": "100%",
				  "height": "100%",
				  "locale": "en"
				}
				  </script>
				</div>
				<!-- TradingView Widget END -->	
			</div>
			
		</div>
		<div class="row m-2">
		
		</div>
	</div>
</body>
</html>