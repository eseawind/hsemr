<%-- 
    Document   : createAccount
    Created on : Sep 30, 2014, 8:24:24 PM
    Author     : weiyi.ngow.2012
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@include file="protectPage/protectAdmin.jsp" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link rel="stylesheet" href="css/foundation.css" />
        <link rel="stylesheet" href="responsive-tables.css">
        <script src="responsive-tables.js"></script>
        <%@include file="/topbar/topbarAdmin.jsp" %>
        <title>Create Account</title>
    </head>
    <body>     
        <div class="large-centered large-12 columns">
            <center>


                <%                    
                    String location = "";
                    String userType = "";
                    if (request.getParameter("type") != null && !request.getParameter("type").equals("")) {
                        if (request.getParameter("type").equals("admin")) {
                            location = "viewAdminAccounts.jsp";
                            session.setAttribute("type", "admin");
                            userType = "Admin";
                        } else if (request.getParameter("type").equals("lecturer")) {
                            location = "viewLecturerAccounts.jsp";
                            userType = "Lecturer";
                            session.setAttribute("type", "lecturer");
                        } else {
                            location = "viewPracticalGroupAccounts.jsp";
                            userType = "Practical Group";
                            session.setAttribute("type", "nurse");
                        }
                    } else if (session.getAttribute("type") != null && !session.getAttribute("type").equals("")) {
                        if (session.getAttribute("type").equals("admin")) {
                            location = "viewAdminAccounts.jsp";
                            userType = "Admin";
                        } else if (session.getAttribute("type").equals("lecturer")) {
                            location = "viewLecturerAccounts.jsp";
                            userType = "Lecturer";
                        } else {
                            location = "viewPracticalGroupAccounts.jsp";
                            userType = "Practical Group";
                        }
                    }
                %>
                <h1>Create Account</h1>
                <h4>Account Type: <%=userType%><br></h4></center>
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
                        String userID = "";

                        if (request.getParameter("userID") != null || !userID.equals("")) {
                            userID = (String) request.getParameter("userID");
                        }

                    %> 



                <form action="ProcessCreateAccount" method="post">
                    <div class="row">
                        <br/>
                        <!--User ID-->
                        <label><strong>User ID</strong>
                            <div class="row collapse">
                                <div class="small-9 columns">
                                    <input type="text" id="userID" name="userID" value="<%=userID%>" required autofocus>
                                </div>
                            </div> 
                        </label>
                        <br/>

                        <!--Password-->
                        <label><strong>Password</strong>
                            <div class="row collapse">
                                <div class="small-9 columns">
                                    <input type="password" id="password" name="password" required>
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

                        <input type="submit" class="button tiny" value="Add account"> 

                        <input type="button" value="Cancel" class="button tiny" onClick="window.location = '<%=location%>'"/>
                    </div>
                </form>   
            </div>
        </div>

    </body>
</html>
