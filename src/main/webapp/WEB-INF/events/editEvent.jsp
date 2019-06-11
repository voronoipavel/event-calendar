<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page isErrorPage="true" %> 
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>

<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>Edit Event Page</title>
	<meta name="viewport" content="width=device-width, initial-scale=1">
	<link rel="stylesheet" href="/webjars/bootstrap/4.1.3/css/bootstrap.min.css" />
	<link rel="stylesheet" type="text/css" href="/css/style.css">
</head>
<body>
<div class="container">
	<nav class="navbar navbar-expand-lg navbar-dark bg-dark">
  			<div class="collapse navbar-collapse" id="navbarTogglerDemo01">
    			<a class="navbar-brand" href="#">Rendezvous</a>
    			<ul class="navbar-nav mr-auto mt-2 mt-lg-0">
      				<li class="nav-item active">
        				<a class="nav-link" href="/home">Home <span class="sr-only">(current)</span></a>
      				</li>
      				<li class="nav-item">
        				<a class="nav-link" href="/logout">Logout</a>
      				</li>
    			</ul>
  			</div>
	</nav>
	<div class="row">
		<div class="col-md-4 offset-md-4" style="padding-top: 100px;">
			<div class="card" style="">
  				<div class="card-header text-white bg-secondary">
    				Edit this Event
  				</div>
  				<div class="card-body">
  					<form:form method="PUT" action="/events/${event.id}/edit" modelAttribute="event">
   						<div class="form-group">
    						<form:input type="text" class="form-control" path="name" placeholder="Event Name"/>
    						<p class="invalid"><form:errors path="name" class=""/><p>
    					</div>
    					<div class="form-group">
    						<input value="${dateStr}" name="date" type="date"/>
    					</div>	
        				<div class="form-row">
    						<div class="form-group col-md-9">
    							<form:input type="text" class="form-control" path="city" placeholder="City"/>
    							<p class="invalid"><form:errors path="city" class=""/><p>
    						</div>
    						<div class="form-group col-md-3">
    							<div class="input-group input-group-md">
    								<form:select path="state" class="form-control">
        								<c:forEach var="loc" items="${locations}">
        									<form:option value="${loc}"><c:out value="${loc}"></c:out></form:option>
        								</c:forEach>
        							</form:select>
    							</div>
    						</div>
    					</div>
    					<div class="form-group">
    						<button type="submit" class="btn btn-block btn-outline-dark"><span class="glyphicon glyphicon-log-in"></span>Submit</button>
    					</div>	
    				</form:form>
  				</div>
			</div>
		</div>
	</div>
</div>
<script src="/webjars/jquery/3.1.1/jquery.min.js"></script>
<script src="/webjars/bootstrap/4.1.3/js/bootstrap.min.js"></script>
</body>
</html>