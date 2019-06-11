<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix = "fmt" uri = "http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>Home Page</title>
	<meta name="viewport" content="width=device-width, initial-scale=1">
	<link rel="stylesheet" href="/webjars/bootstrap/4.1.3/css/bootstrap.min.css" />
	<link rel="stylesheet" type="text/css" href="/css/style.css">
</head>
<body>
	<div class="container">
		<nav class="navbar navbar-expand-lg navbar-dark bg-dark">
  		<button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarTogglerDemo01" aria-controls="navbarTogglerDemo01" aria-expanded="false" aria-label="Toggle navigation">
    		<span class="navbar-toggler-icon"></span>
  		</button>
  			<div class="collapse navbar-collapse" id="navbarTogglerDemo01">
    			<a class="navbar-brand" href="#">Calendar</a>
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
		<div class="greet">
			<h4>Welcome, <c:out value="${user.firstName} ${user.lastName}"/></h4>
			<h5>Here are the events in your area:</h5>
		</div>
		<div class="table1">
			<table class="table table-sm table-hover">
  				<thead>
   					<tr>
      					<th>Name</th>
            			<th>Date</th>
            			<th>Location</th>
            			<th>Host</th>
            			<th>Action/Status</th>
    				</tr>
  				</thead>
  				<tbody>
					<c:forEach var="l" items="${local}">
        				<tr>
            				<td><a href="/events/${l.id}"><c:out value="${l.name}"/></a></td>
            					<td><fmt:formatDate type="date" dateStyle="long" value="${l.date}" /></td>
            					<td><c:out value="${l.city} ${l.state}"></c:out></td>
            					<td><c:out value="${l.host.firstName}"></c:out></td>
           
            				<td>
            				<c:choose>
            					<c:when test="${l.host.id == user.id}">
            						<a href="/events/${l.id}/edit">Edit</a>
            						<a href="/events/${l.id}/delete">Delete</a>
            					</c:when>
            					<c:when test="${l.users.contains(user)}">
            						<a href="/events/cancel/${l.id}">Cancel</a>
            					</c:when>
            					<c:otherwise>
            						<a href="/events/join/${l.id}">Join</a>
            					</c:otherwise>
            				</c:choose>
            				</td>
        				</tr>
        			</c:forEach>
  				</tbody>
			</table>
		</div>	
		<div class="greet">
			<h5>Here are the events in other areas:</h5>
		</div>
		<div class="table1">
			<table class="table table-sm table-hover">
				<thead>
   					<tr>
      					<th>Name</th>
            			<th>Date</th>
            			<th>Location</th>
            			<th>Host</th>
            			<th>Action/Status</th>
    				</tr>
  				</thead>
  				<tbody>
  					<c:forEach var="e" items="${events}" >
        				<tr>
            				<td><a href="/events/${e.id}"><c:out value="${e.name}"/></a></td>
            				<td><fmt:formatDate type="date" dateStyle="long" value="${e.date}" /></td>
            				<td><c:out value="${e.city} ${e.state}"></c:out></td>
            				<td><c:out value="${e.host.firstName}"></c:out></td>
            				<td>
            				<c:choose>
            					<c:when test="${e.users.contains(user)}">
            						<a href="/events/cancel/${e.id}">Cancel</a>
            					</c:when>
            					<c:when test="${e.host.id == user.id}">
            						<a href="/events/cancel/${e.id}">Cancel</a>
            					</c:when>
            					<c:otherwise>
            						<a href="/events/join/${e.id}">Join</a>
            					</c:otherwise>
            				</c:choose>
            				</td>
        				</tr>
        			</c:forEach>
  				</tbody>
			</table>
		</div>
		<div class="table1">
			<div class="card" style="width: 18rem;">
  				<div class="card-header text-white bg-secondary">
    				Create an Event
  				</div>
  				<div class="card-body">
  					<form:form method="POST" action="/events" modelAttribute="event">
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
<script src="/webjars/jquery/3.1.1/jquery.min.js"></script>
<script src="/webjars/bootstrap/4.1.3/js/bootstrap.min.js"></script>
</body>
</html>