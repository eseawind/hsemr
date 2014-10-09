<%-- 
    Document   : adminHomePage
    Created on : Sep 24, 2014, 5:05:18 PM
    Author     : Jocelyn
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@include file="protect.jsp" %>

<!DOCTYPE html>
<html>
    <head>
        <link rel="stylesheet" href="css/foundation.css" />
        <%@include file="/topbar/topbar.jsp" %>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Hospital Ward Management System for NP Health Sciences</title>
         
    </head>
    <body>
        <h1>Welcome, lecturer</h1>
    <center><jsp:include page="viewScenarioLecturer.jsp" /></center>
    </body>
</html>
