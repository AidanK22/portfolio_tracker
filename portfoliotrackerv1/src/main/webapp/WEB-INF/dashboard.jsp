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
	<div class="container">
		<div class="header">
	    
	    	<h1>Welcome <c:out value="${user.firstName } ${user.lastName}"/>!</h1>
	    	<a href="/logout" class="btn btn-danger m-2">Logout</a>
	    	<a href="/addposition" class="btn btn-primary m-2">Add Position</a>
	    </div>
	    <div class="watchlist">
	    	<table class="table">
		    	<tr class="table-dark">
		    	
		    		<th>Symbol</th>
		    		<th>Price</th>
		    		<th>Change</th>
		    		
		    	</tr>		
		    	<c:forEach items="${user.watchlist}" var="watchlistItem" varStatus="loop">
		    		<c:forEach items="${currencies}" var="currency">
		    			<c:if test="${watchlistItem.apiId == currency.id}">
				    		<tr>
								<td><p>Symbol: ${currency.symbol}</p></td>
								<td><p>Price: ${currency.quote.usd.price}</p></td>
								<td><p>Percent change: ${currency.quote.usd.percentChange24h}</p></td>
							</tr>
						</c:if>
					</c:forEach>
		    	</c:forEach>
	    	</table>
	    </div>
	    <div class="test">
			<c:forEach var="currency" items="${currencies}" varStatus="loop">
				<p >Name: ${currency.name}</p>
				<p >Symbol: ${currency.symbol}</p>
				<p >Price: ${currency.quote.usd.price }</p>
				<p >Percent change: ${currency.quote.usd.percentChange24h }</p>
				
			</c:forEach>
		</div>
	</div>
</body>
</html>