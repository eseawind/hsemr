<%-- 
    Document   : createPracticalGroupAccount
    Created on : Oct 15, 2014, 2:37:12 PM
    Author     : weiyi.ngow.2012
--%>

<%@page import="dao.LecturerDAO"%>
<%@page import="java.util.ArrayList"%>
<%@page import="entity.Lecturer"%>
<%@page import="java.util.List"%>
<%@page import="java.util.List"%>
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
        <div class="row" style="padding-top: 30px;">
            <div class="large-centered large-12 columns">
                <center>
                    <h1>Create Account</h1>
                    <h4>Account Type: practical group<br></h4>
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

                    <form action="ProcessCreateAccount" method="post">
                        <div class="row">
                            <div class="large-8 columns">
                                <div class="row">
                                    <div class="small-7 columns">
                                        <label for="userID" class="right inline">User ID</label>
                                        <label for="password" class="right inline">Password</label>
                                        <label for="lecturerID" class="right inline">Lecturer in-charge</label>
                                    </div>
                                    <div class="small-5 columns">
                                        <input type="text" id="userID" name="userID" required autofocus>
                                        <input type="text" id="password" name="password" required>
                                        <select name="lecturerID">
                                            <% 
                                                List<Lecturer> lecturerList = LecturerDAO.retrieveAll();
                                                for(Lecturer lecturer: lecturerList) {
                                                    %>
                                                    <option value="<%=lecturer.getLecturerID()%>"><%=lecturer.getLecturerID()%></option>
                                                    <%
                                                }
                                            %>
                                        </select>
                                        <input type="hidden" id="right-label" name="type" value="<%=request.getParameter("type")%>">
                                    </div>
                                    <input type="submit" class="button tiny" value="Add account"> 


                                    <%

                                        String location = "";
                                        if (request.getParameter("type") != null && !request.getParameter("type").equals("")) {
                                            if (request.getParameter("type").equals("admin")) {
                                                location = "viewAdminAccounts.jsp";
                                            } else if (request.getParameter("type").equals("lecturer")) {
                                                location = "viewLecturerAccounts.jsp";
                                            } else {
                                                location = "viewPracticalGroupAccounts.jsp";
                                            }
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
