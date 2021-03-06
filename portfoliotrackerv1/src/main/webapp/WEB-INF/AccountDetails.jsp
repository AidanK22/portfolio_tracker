<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ taglib prefix = "c" uri = "http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix = "fmt" uri = "http://java.sun.com/jsp/jstl/fmt" %>
<%@ page isErrorPage="true" %>  
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
<body class="bg-dark">
	<div class="container-fluid height-full bg-dark p-1">
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
			<div class="col-auto bg-dark m-3 offset-md-3 p-2 text-white ">
				<div class="row">
					<div class="col">
						<h3>Account Details</h3>
					</div>
					<div class="col">
						<strong>
							<p class="text-sm-left" style="font-size: larger;">${editFirstError}</p>
						</strong>
						<strong>
							<p class="text-sm-left" style="font-size: larger;">${editLastError}</p>
						</strong>
						<strong>
							<p class="text-sm-left" style="font-size: larger;">${editEmailError}</p>
						</strong>
						<strong>
							<p class="text-sm-left" style="font-size: larger;">${editEmailUniError}</p>
						</strong>
					</div>
					
				</div>
			</div>
		</div>
		<div class="row justify-content-center">
			
		</div>
		<div class="row">
			
			<div class="col bg-dark m-4 pt-5 pb-5 border">
				
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
				<div class="row p-1">
				 	<div class="col col-lg-auto" >
						<div class="container bg-light rounded p-2" >
							
							<h5 class="card-title">Account Value</h5>
							<h6>$<c:out value="${accountValue }"/></h6>
							<h5 class="card-title">Your Positions (${amountOfPositions})</h5>
							<div class="datatable-inner table-responsive ps ps--active-y" style="overflow: auto; position: relative; max-height: 620px;">
							
								<table id="dtDynamicVerticalScrollExample" class="table  table-sm card-text border bg-light" >
									<tr class="table-dark ">
											    	
							    		<th class="ps-3 pt-2">Symbol</th>
							    		<th class="">Position Size</th>
							    		<th class="">Current Price</th>
							    		<th class="">Position Value</th>
							    		<th class="">Percent of Portfolio</th>
							    		<th class="pe-3 pt-2">Actions</th>
											    		
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
			    </div>
			</div>
			<div class="col-3 bg-dark m-4 pt-5 pb-5 text-white border">
				<div class="col-auto bg-dark m-3 offset-md-3  text-white ">
				<div class="row p-2 border-bottom">
					<h4 class=" ">User Info</h5>
				</div>
				<div class="row p-2 ">
					<div class="col border-bottom">
						<h5>First Name: <c:out value="${user.firstName }"/></h5>
					</div>
					<div class="col-auto">
						<button type="button" class="btn btn-outline-primary" data-bs-toggle="modal" data-bs-target="#editfirstname">
						  Edit 
						</button>
					</div>
					<!-- Modal to Edit First Name-->
					<div class="modal fade" id="editfirstname" data-bs-backdrop="static" data-bs-keyboard="false" tabindex="-1" aria-labelledby="staticBackdropLabel" aria-hidden="true">
					  <div class="modal-dialog modal-dialog-centered">
					    <div class="modal-content border bg-dark">
					      <div class="modal-header">
					        <h5 class="modal-title color-black" id="staticBackdropLabel">Edit User Info</h5>
					        <button type="button bg-white" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
					      </div>
					      <div class="modal-body">
					      	<strong>
								<p class="text-sm-left" style="font-size: larger;">${editFirstError}</p>
							</strong>
							<h5>Current first name: ${user.firstName}</h5>
					     	<div class="">
								<form:form action="/editFirstName/${user.id }/update" method="post" modelAttribute="user" class="form">
									<input type="hidden" name="_method" value="put">
									
									<div class="form-group">
										<form:errors path="firstName" class="errors"/>
										<form:label path="firstName" for="firstName">Edit First Name</form:label>
										<form:input path="firstName" type="string" name="firstName" id="firstName" value="${user.firstName}" class="form-control"/>
										
									</div>
									
								
									<div class="modal-footer mt-4">
					        			<input type="submit" value="Confirm" class="btn btn-outline-primary m-2">
					      			</div>
								</form:form>
							</div>
					      </div>
					      
					    </div>
					  </div>
					</div>
				</div>
				<div class="row p-2 ">
					<div class="col border-bottom">
						<h5>Last Name: <c:out value="${user.lastName }"/></h5>
					</div>
					
					<div class="col-auto">
						<button type="button" class="btn btn-outline-primary" data-bs-toggle="modal" data-bs-target="#editlastname">
						  Edit 
						</button>
					</div>
					<!-- Modal to Edit First Name-->
					<div class="modal fade" id="editlastname" data-bs-backdrop="static" data-bs-keyboard="false" tabindex="-1" aria-labelledby="staticBackdropLabel" aria-hidden="true">
					  <div class="modal-dialog modal-dialog-centered">
					    <div class="modal-content border bg-dark">
					      <div class="modal-header">
					        <h5 class="modal-title color-black" id="staticBackdropLabel">Edit User Info</h5>
					        <button type="button bg-white" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
					      </div>
					      <div class="modal-body">
					      	<strong>
								<p class="text-sm-left" style="font-size: larger;">${editLastError}</p>
							</strong>
							<h5>Current last name: ${user.lastName}</h5>
					     	<div class="">
								<form:form action="/editLastName/${user.id }/update" method="post" modelAttribute="user" class="form">
									<input type="hidden" name="_method" value="put">
									
									<div class="form-group">
										<form:errors path="lastName" class="errors"/>
										<form:label path="lastName" for="lastName">Edit Last Name</form:label>
										<form:input path="lastName" type="string" name="lastName" id="lastName" value="${user.lastName}" class="form-control"/>
										
									</div>
									
								
									<div class="modal-footer mt-4">
					        			<input type="submit" value="Confirm" class="btn btn-outline-primary m-2">
					      			</div>
								</form:form>
							</div>
					      </div>
					      	
					    </div>
					  </div>
					</div>
				</div>
				<div class="row p-2">
					<div class="col border-bottom">
						<h5>Email: <c:out value="${user.email}"/></h5>
					</div>
					<div class="col-auto">
						<button type="button" class="btn btn-outline-primary" data-bs-toggle="modal" data-bs-target="#editEmail">
						  Edit 
						</button>
					</div>
					<!-- Modal to Edit First Name-->
					<div class="modal fade" id="editEmail" data-bs-backdrop="static" data-bs-keyboard="false" tabindex="-1" aria-labelledby="staticBackdropLabel" aria-hidden="true">
					  <div class="modal-dialog modal-dialog-centered">
					    <div class="modal-content border bg-dark">
					      <div class="modal-header">
					        <h5 class="modal-title color-black" id="staticBackdropLabel">Edit User Info</h5>
					        <button type="button bg-white" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
					      </div>
					      <div class="modal-body">
					      	<strong>
								<p class="text-sm-left" style="font-size: larger;">${editEmailError}</p>
							</strong>
							<h5>Current email: ${user.email}</h5>
					     	<div class="">
								<form:form action="/editEmail/${user.id }/update" method="post" modelAttribute="user" class="form">
									<input type="hidden" name="_method" value="put">
									
									<div class="form-group">
										<form:errors path="email" class="errors"/>
										<form:label path="email" for="email">Edit Email</form:label>
										<form:input path="email" type="string" name="email" id="email" value="${user.email}" class="form-control"/>
									</div>
									
									<div class="modal-footer mt-4">
					        			<input type="submit" value="Confirm" class="btn btn-outline-primary m-2">
					      			</div>
								</form:form>
							</div>
					      </div>
					      	
					    </div>
					  </div>
					</div>
				</div>
				<div class="row p-2 border-bottom">
					<h4 class="mt-2 ">Account Overview</h5>
				</div>
				<div class="row p-2">
					<h5 class="mt-2">Account Value: $${accountValue}</h5>
				</div>
				<div class="row p-2">
					<h5>Amount of Positions: ${amountOfPositions}</h5>
				</div>
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