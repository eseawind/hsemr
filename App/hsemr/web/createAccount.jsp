<%-- 
    Document   : createAccount
    Created on : Sep 30, 2014, 8:24:24 PM
    Author     : weiyi.ngow.2012
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@include file="protect.jsp" %>
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
        <div class="row" style="padding-top: 30px;">
            <div class="large-centered large-12 columns">
                <center>
                    <h1>Create Account</h1>
                    <h4>Account Type: <%=request.getParameter("type")%><br></h4>
                        <%

                            String error = (String) request.getAttribute("error");
                            if (error != null) {
                                out.println(error);
                            }

                        %> 

                    <form action="ProcessCreateAccount" method="post">
                        <div class="row">
                            <div class="large-8 columns">
                                <div class="row">
                                    <div class="small-7 columns">
                                        <label for="userID" class="right inline">User ID</label>
                                        <label for="password" class="right inline">Password</label>
                                    </div>
                                    <div class="small-5 columns">
                                        <input type="text" id="userID" name="userID" required autofocus>
                                        <input type="text" id="password" name="password" required>
                                        <input type="hidden" id="right-label" name="type" value="<%=request.getParameter("type")%>">
                                    </div>
                                    <input type="submit" class="button tiny" value="Add account"> 


                                    <%

                                        String location = "";
                                        if (request.getParameter("type").equals("admin")) {
                                            location = "viewAdminAccounts.jsp";
                                        } else if (request.getParameter("type").equals("lecturer")) {
                                            location = "viewLecturerAccounts.jsp";
                                        } else {
                                            location = "viewNurseAccounts.jsp";
                                        }
                                    %>
                                    <input type="button" value="Cancel" class="button tiny" onClick="window.location = '<%=location%>'"/>
                                </div>
                            </div>
                        </div>
                    </form>
                </center>   
            </div>
        </div>
    </body>
</html>
