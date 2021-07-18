<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1" %>
	<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
		<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
			<!DOCTYPE html>
			<html>

			<head>
				<title>Audit Management System</title>
				<link rel="stylesheet" type="text/css" href="css/style.css">
				<link href="https://fonts.googleapis.com/css?family=Poppins:600&display=swap" rel="stylesheet">
				<script src="https://kit.fontawesome.com/a81368914c.js"></script>
				<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css"
					integrity="sha384-ggOyR0iXCbMQv3Xipma34MD+dH/1fQ784/j6cY/iJTQUOhcWr7x9JvoRxT2MZw1T"
					crossorigin="anonymous">
				<meta name="viewport" content="width=device-width, initial-scale=1">
				<style type="text/css">
					* {
						padding: 0;
						margin: 0;
						box-sizing: border-box;
					}


					.logo {
						margin: 2% 0;
						height: 100px;
						width: 100px;
					}

					.container {
						width: 100%;
						height: auto;
						overflow: hidden;
						margin: auto;
						align-items: center;
					}


					.login-container {
						width: 450px;
						margin: 3% auto;
						padding: 20px;
						align-content: center;
						align-items: center;
						display: block;
						background-color: white;
						border-radius: 15px;
					}

					.mydiv {
						width: 380px;
						margin: auto;
					}

					.btn {
						width: 130px;
						border-radius: 20px;
						margin: auto;
						align-self: center;
					}

					.form-group .form-control {
						width: 350px;
						border: 0;
						background-color: transparent;
					}

					footer {
						width: 100%;
						bottom: 0px;
						position: absolute;
					}
				</style>
			</head>

			<body style="background-image: url(/images/bluegr.jpg); background-size: cover;">
				<div class="container">
					<div class="login-container">
						<h2>
							<center>Audit Management System</center>
						</h2><br>
						<center>
							<img src="/images/icon.png" class="logo"><br>
							<h3>Login</h3><br>
						</center>
						<form:form action="/home" modelAttribute="user" method="post" class="form-inline">
							<div class="mydiv">
								<div class="form-group">
									<i class="fas fa-user"></i>&emsp;
									<form:input type="text" path="userId" placeholder="Username" class="form-control"
										required="required" />
								</div>

								<hr>
								<div class="form-group">
									<i class="fas fa-lock"></i>&emsp;
									<form:input type="password" path="password" placeholder="Password"
										class="form-control" required="required" />
								</div>
								<hr>
								<c:choose>
									<c:when test="${msg != null}">
										<center>
											<div>
												<h3 style="color: red;">${msg}. </h3><br>
											</div>
										</center>
									</c:when>
								</c:choose>
								<div class="form-group">
									<input type="submit" class="btn btn-primary" value="Login">
									<input type="reset" class="btn btn-primary" value="Reset">
								</div>
							</div>
						</form:form>
					</div>
				</div>
				<footer>
					<%@ include file="common/footer.jsp" %>
				</footer>
			</body>

			</html>