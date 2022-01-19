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
		
		</div>
		<div class="nsr">
			<h1>${curreny.name }</h1>
			<p>${currency.symbol }</p>
			<p>Rank: ${currency.cmcRank }</p>
		</div>
		<div class="addToWatchlist">
		
		</div>
		<div class="price">
			<h2>Current Price: $${currency.quote.usd.price } ${currency.quote.usd.percentChange24h }%</h2>
			
		</div>
		<div class="supply">
			<h3>Circulating Supply</h3>
			<p>${currency.circulatingSupply } ${currency.symbol }</p>
			<h3>Max Supply</h3>
			<p>${currency.maxSupply }</p>
			<h3>Total Supply</h3>
			<p>${currency.totalSupply }</p>
		</div>
		<div class="marketCap">
			<h3>Market Cap</h3>
			<p>${currency.quote.usd.marketCap }</p>
			<h3>Fully diluted Market Cap</h3>
			<p>${currency.quote.usd.fullyDilutedMarketCap }</p>
		</div>
		<div class="volume">
			<h3>Volume 24hr</h3>
			<p>${currency.quote.usd.volume24h }</p>
			<p>${currency.quote.usd.volumeChange24h }</p>
		</div>
	</div>
</body>
</html>