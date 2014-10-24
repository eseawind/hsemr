<%-- 
    Document   : adminHomePage
    Created on : Sep 24, 2014, 5:05:18 PM
    Author     : Jocelyn
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@include file="protectPage/protectLecturer.jsp" %>

<!DOCTYPE html>
<html>
    <head>
        <link rel="stylesheet" href="css/foundation.css" />
        <%@include file="/topbar/topbarLecturer.jsp" %>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Hospital Ward Management System for NP Health Sciences</title>
         
    </head>
    <body>
<div class="row" style="padding-top: 30px;">
            <div class="large-centered large-12 columns">
                <center>
                    <h1>Select case to view details</h1></center>
            </div></div>
    <center><jsp:include page="viewScenarioLecturer.jsp" /></center>
    </body>
</html>
