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
	<script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
	<script src="https://cdnjs.cloudflare.com/ajax/libs/Chart.js/3.7.1/chart.min.js" integrity="sha512-QSkVNOCYLtj73J4hbmVoOV6KVZuMluZlioC+trLpewV8qMjsWqlIQvkn1KGX2StWvPMdWGBqim1xlC8krl1EKQ==" crossorigin="anonymous" referrerpolicy="no-referrer"></script>
	
<meta charset="ISO-8859-1">
<title>Account Details</title>
</head>
<body>
	<div class="container-fluid bg-dark p-1">
		<div class="navbar fixed-top row align-items-start  ps-3 pe-3 bg-dark border-bottom">
		
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
			
		</div>
		<div class="row">
			
			<div class="col bg-dark m-4 p-3  border">
				
				<%-- <div class="row">
					<div class="accountvalue col align-self-start border border-dark mt-1">
					    <div class="col">
						    <div class="card h-460">
						    
							    <div class="card-body">
							    
							    	<h5 class="card-title">Account Value</h5>
							    	<h6>$<c:out value="${accountValue }"/></h6>
							    	
							    </div>
							    
							</div>
							
						</div>
					</div>
				</div> --%>
				<div class="row">
				 	<div class="col col-lg-auto" >
						<div class="container bg-light rounded p-2" >
							<h5 class="card-title">Account Value</h5>
							<h6>$<c:out value="${accountValue }"/></h6>
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
			</div>
			<div class="col-3 bg-dark m-4 text-white border">
				<div class="col-auto bg-dark m-3 offset-md-3 p-3 text-white border">
				<h5 class=" border-bottom">User Info</h5>
				<h5>First Name: <c:out value="${user.firstName }"/></h5>
				<h5>Last Name: <c:out value="${user.lastName }"/></h5>
				<h5>Email: <c:out value="${user.email}"/></h5>
				<h5 class="mt-3 border-bottom">Account Overview</h5>
				<h5 class="mt-3">Account Value: $${accountValue}</h5>
				<h5>Amount of Positions: ${amountOfPositions}</h5>
			</div>
			</div>
			<div class="col bg-dark m-4 p-3  border">
				<div>
  					<canvas id="myChart"></canvas>
				</div>
				
				<script>
					export const CHART_COLORS = {
						  red: 'rgb(255, 99, 132)',
						  orange: 'rgb(255, 159, 64)',
						  yellow: 'rgb(255, 205, 86)',
						  green: 'rgb(75, 192, 192)',
						  blue: 'rgb(54, 162, 235)',
						  purple: 'rgb(153, 102, 255)',
						  grey: 'rgb(201, 203, 207)'
						};
				
					  const labels = [
					    'January',
					    'February',
					    'March',
					    'April',
					    'May',
					    'June',
					  ];
						
					  const data = {
					    labels: labels,
					    datasets: [{
					      label: 'My First dataset',
					      backgroundColor: Object.values(Utils.CHART_COLORS),
					      borderColor: 'rgb(255, 99, 132)',
					      data: [0, 10, 5, 2, 20, 30, 45],
					    }]
					  };
					
					  const config = {
					    type: 'pie',
					    data: data,
					    options: {
					    	responsive: true,
					        plugins: {
					            legend: {
					              position: 'top',
					            },
					            title: {
					              display: true,
					              text: 'Chart.js Pie Chart'
					            }
					          }}
					  };
				</script>
				
				<script>
					  const myChart = new Chart(
					    document.getElementById('myChart'),
					    config
					  );
				</script>
			</div>
		</div>
	</div>
</body>
</html>