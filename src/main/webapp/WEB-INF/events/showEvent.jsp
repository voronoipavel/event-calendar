<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix = "fmt" uri = "http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<link rel="stylesheet" type="text/css" href="/css/style.css">
	<title>Display Event Page</title>
	<meta name="viewport" content="width=device-width, initial-scale=1">
	<link rel="stylesheet" href="/webjars/bootstrap/4.1.3/css/bootstrap.min.css" />
	<link rel="stylesheet" type="text/css" href="/css/style.css">
</head>
<body>
<div class="container">
	<nav class="navbar navbgit commit -m "first commit"ar-expand-lg navbar-dark bg-dark">
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
		<div class="col-md-6">
		 	<div class="card" style="">
  				<div class="card-header text-white bg-secondary">
    				<c:out value="${event.name}"></c:out>
  				</div>
  				<div class="card-body">
  					<p class="card-text">Host: <c:out value="${event.host.firstName} ${event.host.lastName}"></c:out></p>
  					<p class="card-text">Date: <fmt:formatDate type="date" dateStyle="long" value="${event.date}" /></p>
  					<p class="card-text">Location: <c:out value="${event.city} ${event.state}"></c:out></p>
  					<p class="card-text">People Attending:</p>
  					<ul class="list-unstyled">
						<c:forEach var="a" items="${attendees}" >
							<li style="padding-left: 50px;">
								<c:out value="${a.firstName} ${a.lastName}"></c:out>
							</li>
						</c:forEach>
					</ul>
  				</div>
  			</div>
  			<div class="">
				<div class="card" style="">
					<div class="card-header text-white bg-secondary">
						Add a comment:
					</div>
					<div class="card-body">
						<form:form action="/comments/new/${event.id}" modelAttribute="comment" method="POST">
							<div class="form-group">
    							<form:textarea type="text" class="form-control" path="content" placeholder="Add Comment"/>
    							<p class="invalid"><form:errors path="content" class=""/><p>
    						</div>
    						<div class="form-group">
    							<button type="submit" class="btn btn-block btn-outline-dark"><span class="glyphicon glyphicon-log-in"></span>Submit</button>
    						</div>
						</form:form>
					</div>
				</div>
  			</div>
		</div>
		<div class="col-md-6">
			<div class="card">
				<div class="card-header text-white bg-secondary">
						Comments on this Event: <c:out value="${event.comments.size()}" />
				</div>
				<div class="card-body">
					<div style="overflow-y: scroll; height:300px;">
  						<ul class="list-unstyled">
  							<c:forEach items="${event.comments}" var="com">
								<li class="">
									<blockquote class="blockquote text-right">
										<c:out value="${com.content}" />
										<footer class="blockquote-footer"><c:out value="${com.user.firstName} ${com.user.lastName}"/></footer>
									</blockquote>
								</li>
							</c:forEach>
  						</ul>
  					</div>
  				</div>
  			</div>
		</div>
	</div>
</div>
		


	
		<c:if test="${event.comments.size() > 0}">
 	
		</c:if>
<script src="/webjars/jquery/3.1.1/jquery.min.js"></script>
<script src="/webjars/bootstrap/4.1.3/js/bootstrap.min.js"></script>
</body>
</html>