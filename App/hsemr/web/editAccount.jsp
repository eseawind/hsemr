<%-- 
    Document   : editAccount
    Created on : Sep 30, 2014, 8:33:50 PM
    Author     : weiyi.ngow.2012
--%>

<%@page import="entity.PracticalGroup"%>
<%@page import="entity.Lecturer"%>
<%@page import="java.util.List"%>
<%@page import="java.util.List"%>
<%@page import="entity.Admin"%>
<%@page import="dao.PracticalGroupDAO"%>
<%@page import="dao.LecturerDAO"%>
<%@page import="dao.AdminDAO"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@include file="protectPage/protectAdmin.jsp" %>
<!DOCTYPE html>
<html>
    <head>
        <link rel="stylesheet" href="css/foundation.css" />
        <link rel="stylesheet" href="responsive-tables.css">
        <script src="responsive-tables.js"></script>
        <%@include file="/topbar/topbarAdmin.jsp" %>

        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Edit Accounts</title>
    </head>
    <body> 
        <br/>
        <br/>
    <center>
        <%
            String userID = "";
            String location = "";
            if (request.getParameter("userID") != null) { 
                userID = request.getParameter("userID"); 
                session.setAttribute("userID", userID);
                if (request.getParameter("type").equals("admin")) {
                    location = "viewAdminAccounts.jsp";
                    session.setAttribute("location", "viewAdminAccounts.jsp");
                   
               } else if (request.getParameter("type").equals("lecturer")) {
                    location = "viewLecturerAccounts.jsp";
                    session.setAttribute("location", "viewLecturerAccounts.jsp");
                } else {
                    location = "viewPracticalGroupAccounts.jsp";
                    session.setAttribute("location", "viewPracticalGroupAccounts.jsp");
                }
            } else { 
                userID = (String)session.getAttribute("userID");
                location = (String) session.getAttribute("location");
            }
            
        %>
        
        <h1>Edit <%=userID%>'s details</h1></center>
        <div class="row" style="width:27%;">   
           
            <%

                String error = (String) request.getAttribute("error");
                if (error != null) {
            %>
            <div data-alert class="alert-box alert radius">
                <%=error%>
                <a href="#" class="close">&times;</a></div>
                <%
                    }

                %> 

            <form action = "ProcessEditAccount" method = "post">
                <div class="row">
                    <br/>
                <!--User ID-->
                <label><strong>User ID</strong>
                    <div class="row collapse">
                        <div class="small-9 columns">
                            <input type="text" id="userID" name="userID" value="<%=userID%>" readonly>
                        </div>
                    </div> 
                </label>
                <br/>

                <!--Password-->
                <label><strong>New Password</strong>
                    <div class="row collapse">
                        <div class="small-9 columns">
                            <input type="password" id="password" name="password" required autofocus>
                        </div>
                    </div> 
                </label>  
                <br/>
                <!--Confirm Password-->
                <label><strong>Confirm Password</strong>
                    <div class="row collapse">
                        <div class="small-9 columns">
                            <input type="password" id="confirmPassword" name="confirmPassword" required>
                        </div>
                    </div> 
                </label>  
                <br/>

                <input type="hidden" id="right-label" name="type" value="<%=request.getParameter("type")%>">

                    
                  
                    <input type="submit" class="button tiny" value="Save"> 
                    <input type="button" value="Cancel" class="button tiny" onClick="window.location = '<%=location%>'"/>
                </div>
            </form>
        </div>
    </body>
</html>
