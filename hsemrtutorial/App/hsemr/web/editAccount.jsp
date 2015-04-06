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
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">

        <!--Web Title-->
        <title>EMR | User Management | Edit Account</title>

        <link rel="stylesheet" href="css/foundation.css" />
        <link rel="stylesheet" href="responsive-tables.css">
        <link rel="stylesheet" href="css/original.css" />
        <script type="text/javascript" src="js/humane.js"></script>
        <script src="responsive-tables.js"></script>
        <%@include file="/topbar/topbarAdmin.jsp" %>

    </head>
    <body> 
        <%            String userID = "";
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
                userID = (String) session.getAttribute("userID");
                location = (String) session.getAttribute("location");
            }

        %>
        <div class="large-10 large-centered columns">  
            <div class="row" style="width:500px; padding-top: 50px">
                <center><h1>Edit <%=userID%>'s details</h1></center><br/>
                    <%
                        String error = (String) request.getAttribute("error");
                        if (error == null) {
                            error = "";
                        }
                    %>

                <form action = "ProcessEditAccount" method = "post">
                    <br/>
                    <div class="panelCase">
                        <!--User ID-->
                        <label><strong>User ID</strong>
                            <input type="text" id="userID" name="userID" value="<%=userID%>" readonly>
                        </label>
                        <br/>

                        <!--Password-->
                        <label><strong>New Password</strong>
                            <input type="password" id="password" name="password" required autofocus>
                        </label>  
                        <br/>

                        <!--Confirm Password-->
                        <label><strong>Confirm Password</strong>
                            <input type="password" id="confirmPassword" name="confirmPassword" required>
                        </label>  
                    </div>
                    <br/>
                    <input type="hidden" id="right-label" name="type" value="<%=request.getParameter("type")%>">
                    <br/>
                    <table style="border-color: white; width:500px">
                        <col width="50%">
                        <col width="50%">
                        <tr>
                            <td><center><input type="button" value="Cancel" class="button small" onClick="window.location = '<%=location%>'"/></center> </td>
                        <td><center><input type="submit" class="button important" value="Save"></center></td>
                        </tr>
                    </table>
                        
                </form>
            </div>
        </div>
        <script>

            $(document).ready(function() {
                $(document).foundation();
                var humaneError = humane.create({baseCls: 'humane-original', addnCls: 'humane-original-error', timeout: 1000, clickToClose: true})

                var error1 = "<%=error%>";
                if (error1 !== "") {
                    humaneError.log(error1);
                }

            });
        </script>
    </body>
</html>
