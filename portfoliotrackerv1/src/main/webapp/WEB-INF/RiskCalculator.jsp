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
<div class="wrap">
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
				    	<a href="/dashboard" class="btn text-white m-1 m-right-5">Dashboard</a>
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
        <h1>EXPECTED OUTCOME CALCULATOR</h1>
        <div class="cform">
            <form action="/calculate" method="POST">
                
                <ul>
                    <li><label for="amountRisked">Amount Risked</label></li>
                    <li><span class="currency"><input name="amountRisked" type="number" step="0.01"></span></li>

                    <li><label for="potentialProfit">Potential Profit</label></li>
                    <li><span class="currency"><input name="potentialProfit" type="number" step="0.01"></span></li>

                    <li><label for="probability">% Probability</label></li>
                    <li><span class="probability"><input name="probability" type="number"></span><li>

                    <li><button type="submit">Calculate</button></li>
                </ul>
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
</body>
</html>