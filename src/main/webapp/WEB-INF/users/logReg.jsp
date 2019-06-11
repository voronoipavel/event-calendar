<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>Login Registration Page</title>
	<meta name="viewport" content="width=device-width, initial-scale=1">
	<link rel="stylesheet" href="/webjars/bootstrap/4.1.3/css/bootstrap.min.css" />
	<link rel="stylesheet" type="text/css" href="/css/style.css">
</head>
<body>
	<div class="container" id="log_reg">
		<div id="canvas-container">
   			<canvas></canvas>
		</div>
		<div class="row">
			<div class="col-md-4 offset-md-2">
				<div class="card text-white bg-secondary mb-3">
					<div class="card-header">
						<h3>Login</h3>
					</div>
					<div class="card-body">
    					<form method="post" action="/login" class="">
    						<c:if test="${error != null}">
    							<div class="alert alert-danger">
    								<strong><c:out value="${error}"></c:out></strong>
    							</div>
    						</c:if>
    						<div class="form-group">
    							<span class="input-group-addon">
    								<span class="glyphicon glyphicon-user"></span>
    							</span>
    							<input type="text" class="form-control" name="email" placeholder="Email"/>
    						</div>
    						<div class="form-group">
    							<span class="input-group-addon">
    								<span class="glyphicon glyphicon-lock"></span>
    							</span>
    							<input type="password" class="form-control" name="password" placeholder="Password"/>
    						</div>
    						<div class="form-group">
    							<button type="submit" class="btn btn-default btn-block" ><span class="glyphicons glyphicons-log-in"></span> Login</button>
    						</div>
   						 </form>
					</div>
				</div>
			</div>
			<div class="col-md-4">
				<div class="card text-white bg-secondary mb-3">
					<div class="card-header">
						<h3>Registration</h3>
					</div>
					<div class="card-body">
						<form:form method="POST" action="/registration" class="form-signin form-horizontal" modelAttribute="user">
    						<div class="form-group">
    							<form:input type="text" class="form-control" path="firstName" placeholder="First Name"/>
    							<p class="invalid"><form:errors path="firstName" class=""/><p>
    						</div>
    						<div class="form-group">
    							<form:input type="text" class="form-control" path="lastName" placeholder="Last Name"/>
    							<p class="invalid"><form:errors path="lastName" class=""/><p>
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
    							<form:input type="text" class="form-control" path="email" placeholder="Email"/>
    							<p class="invalid"><form:errors path="email" class=""/><p>
    						</div>
    						<div class="form-group">
    							<form:input type="password" class="form-control" path="password" placeholder="Password"/>
    							<p class="invalid"><form:errors path="password" class=""/><p>
    						</div>
    						<div class="form-group">
    							<form:input type="password" class="form-control" path="passwordConfirmation" placeholder="Confirm Password"/>
    							<p class="invalid"><form:errors path="passwordConfirmation" class=""/><p>
    						</div>
    						<div class="form-group">
    							<button type="submit" class="btn btn-default btn-block" ><span class="glyphicon glyphicon-log-in"></span> Register</button>
    						</div>
   						</form:form>
					</div>
				</div>
			</div>
		</div>
	</div>
<script>
	var ctx = document.querySelector("canvas").getContext("2d"),
    dashLen = 220, dashOffset = dashLen, speed = 7,
    txt = "Rendevous", x = 30, i = 0;

	ctx.font = "50px Comic Sans MS, cursive, TSCu_Comic, sans-serif";
	ctx.lineWidth = 5; ctx.lineJoin = "round"; ctx.globalAlpha = 2/3;
	ctx.strokeStyle = ctx.fillStyle = "#eff2f7";

	(function loop() {
  		ctx.clearRect(x, 0, 60, 150);
  		ctx.setLineDash([dashLen - dashOffset, dashOffset - speed]);
  		dashOffset -= speed;
  		ctx.strokeText(txt[i], x, 90);

  		if (dashOffset > 0) requestAnimationFrame(loop);
  		else {
    		ctx.fillText(txt[i], x, 90);
    		dashOffset = dashLen;
    		x += ctx.measureText(txt[i++]).width + ctx.lineWidth * Math.random();
    		ctx.setTransform(1, 0, 0, 1, 0, 3 * Math.random());
    		ctx.rotate(Math.random() * 0.005);
    		if (i < txt.length) requestAnimationFrame(loop);
  			}
		})();
</script>

<script src="/webjars/jquery/3.1.1/jquery.min.js"></script>
<script src="/webjars/bootstrap/4.1.3/js/bootstrap.min.js"></script>
</body>
</html>