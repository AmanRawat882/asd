<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1" %>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
        <%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
            <%@ page import="java.util.Date" %>
                <%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>

                    <!DOCTYPE html>
                    <html>

                    <head>
                        <meta charset="UTF-8">
                        <meta http-equiv="X-UA-Compatible" content="IE=edge">
                        <meta name="viewport" content="width=device-width, initial-scale=1.0">
                        <link rel="stylesheet"
                            href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.0/dist/css/bootstrap.min.css"
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
                        <title>Audit Questions</title>
                        <style>
                            body {
                                background: #fff;
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

                            form {
                                background: #0de0e0;
                            }

                            h4 {
                                color: #000;

                            }

                            .heading {
                                font-size: medium;
                            }
                        </style>
                    </head>

                    <body>
                        <div class="fixed-header">
                            <%@ include file="common/header.jsp" %>
                        </div>

                        <div class="container">

                            <h4 class=" m-4 display-5 text-center"></h4>

                            <div class="row">
                                <div class="col-sm-6">
                                    <img src="/images/audit.png" width=90%>
                                </div>

                                <div class="col-sm-6">
                                    <form:form action="/questions" method="post" modelAttribute="questions"
                                        class="px-5 py-4 border rounded">
                                        <c:forEach var="emp" items="${questions.questionsEntity}" varStatus="status">
                                            <h5 class="mt-3">${emp.question}</h5>
                                            <form:hidden path="questionsEntity[${status.index}].questionId"
                                                value="${emp.questionId }" />
                                            <form:hidden path="questionsEntity[${status.index}].question"
                                                value="${emp.question }" />
                                            <form:hidden path="questionsEntity[${status.index}].auditType"
                                                value="${emp.auditType }" />
                                            <div class="input-group">
                                                <div class="input-group-prepend">
                                                    <div class="input-group-text">
                                                        <form:radiobutton
                                                            path="questionsEntity[${status.index}].response" value="yes"
                                                            required="required" />
                                                    </div>
                                                </div>
                                                <form:label class="form-control"
                                                    path="questionsEntity[${status.index}].response">Yes</form:label>

                                                <div class="input-group-prepend">
                                                    <div class="input-group-text">
                                                        <form:radiobutton
                                                            path="questionsEntity[${status.index}].response"
                                                            value="no" />
                                                    </div>
                                                </div>
                                                <form:label class="form-control"
                                                    path="questionsEntity[${status.index}].response">No</form:label>


                                            </div>

                                        </c:forEach>
                                        <input type="Submit" value="Submit" class="btn btn-success btn-block mt-3" />

                                    </form:form>
                                </div>


                            </div>
                        </div>

                    </body>

                    </html>