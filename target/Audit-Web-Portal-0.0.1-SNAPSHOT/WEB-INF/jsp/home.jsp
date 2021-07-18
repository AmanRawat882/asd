<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1" %>
	<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>


		<!DOCTYPE html>
		<html>

		<head>
			<meta charset="UTF-8">
			<meta http-equiv="X-UA-Compatible" content="IE=edge">
			<meta name="viewport" content="width=device-width, initial-scale=1.0">
			<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.0/dist/css/bootstrap.min.css"
				integrity="sha384-B0vP5xmATw1+K9KRQjQERJvTumQW0nPEzvF6L/Z6nronJ3oUOFUFpCjEUQouq2+l"
				crossorigin="anonymous">
			<script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"
				integrity="sha384-DfXdz2htPH0lsSSs5nCTpuj/zy4C+OGpamoFVy38MVBnE+IbbVYUew+OrCXaRkfj"
				crossorigin="anonymous"></script>
			<script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.1/dist/umd/popper.min.js"
				integrity="sha384-9/reFTGAW83EW2RDu2S0VKaIzap3H66lZH81PoYlFhbGU+6BZp6G7niu735Sk7lN"
				crossorigin="anonymous"></script>
			<script src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.0/dist/js/bootstrap.min.js"
				integrity="sha384-+YQ4JLhjyBLPDQt//I+STsc9iw4uQqACwlvpslubQzn4u2UU2UFM80nGisd026JF"
				crossorigin="anonymous"></script>

			<title>Project Details - Audit Management System</title>
			<style>
				form {
					margin: auto;
					background: #69d0ff;
				}

				.fixed-header {
					background-color: gainsboro;
					position: sticky;
				}

				.logout {
					border-radius: 8px;
					background-color: black;
					padding: 6px 10px;
					align-items: center;
				}


				h1 {
					color: #FFF;
				}

				.container {
					margin: 3% auto;
				}
			</style>
		</head>

		<body>
			<div class="fixed-header">
				<%@ include file="common/header.jsp" %>
			</div>


			<div class="container">

				<h2 class="text-center m-5" style="color:darkorange">Project Details</h2>

				<form:form action="/AuditCheckListQuestions" modelAttribute="projectDetails" method="post"
					class="px-5 py-4 border rounded">

					<div class="form-group">
						<form:label path="projectName">Project Name</form:label>
						<form:input path="projectName" required="required" class="form-control" id="ProjectName" />

					</div>
					<div class="form-group">
						<form:label path="projectManagerName">Project Manager Name</form:label>
						<form:input path="projectManagerName" required="required" class="form-control"
							id="ProjectManagerName" />
					</div>
					<div class="form-group">
						<form:label path="applicationOwnerName">Application Owner</form:label>
						<form:input path="applicationOwnerName" required="required" class="form-control"
							id="ApplicationOwnerName" />
					</div>

					<div class="form-group">
						<label for="AuditType">Audit Type</label>
						<form:form modelAttribute="auditType">
							<div class="input-group">
								<div class="input-group-prepend">
									<div class="input-group-text">
										<form:radiobutton path="auditType" required="required" id="internal"
											value="Internal" name="audittype"
											aria-label="Radio button for following text input" />
									</div>
								</div>
								<label for="Internal" class="form-control"> Internal</label>

								<div class="input-group-prepend">
									<div class="input-group-text">
										<form:radiobutton path="auditType" id="sox" value="SOX" name="audittype"
											aria-label="Radio button for following text input" />
									</div>
								</div>
								<label for="SOX" class="form-control"> SOX</label>
							</div>
							<div class="btn-block">
								<input type="submit" class="btn btn-success mt-3" value="Submit">
								<input type="reset" class="btn btn-success mt-3" value="Reset">
							</div>
						</form:form>
					</div>





				</form:form>
			</div>
		</body>

		</html>