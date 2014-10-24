<%-- 
    Document   : viewLecturerAccounts
    Created on : Sep 30, 2014, 8:43:50 PM
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
        <meta charset="utf-8" />
        <meta name="viewport" content="width=device-width, initial-scale=1.0" />
        <link rel="stylesheet" href="css/foundation.css" />
        <script src="js/vendor/modernizr.js"></script>
        <%@include file="/topbar/topbarAdmin.jsp" %>
        <script type="text/javascript">

            function deleteConfirmation() {
                var deleteButton = confirm("Are you sure you want to delete? ")
                if (deleteButton) {
                    return true;
                }
                else {
                    return false;
                }
            }

        </script>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Lecturer Accounts Management</title>
    </head>
    <body>
        <%            List<Lecturer> lecturerList = LecturerDAO.retrieveAll();

        %>
        <div class="row" style="padding-top: 30px;">
            <div class="large-centered large-12 columns">
                <center>
                    <h1>Lecturer Accounts Management</h1>
        
                    <div class ="large-11">
                          
                        <%if (session.getAttribute("successLecturer") != null) {%>
                        <div data-alert class="alert-box success radius">
                           <%=session.getAttribute("successLecturer")%>
                            <a href="#" class="close">&times;</a>
                        </div>
                        <%
                            session.setAttribute("successLecturer",null);                        
                            }
                        %>
                        
                        <%

                            String error = (String) session.getAttribute("error");
                            if (error != null) {
                                %>
                                <div data-alert class="alert-box alert radius">
                                 <%=error%>
                           <a href="#" class="close">&times;</a></div>
                            <%
                            } session.setAttribute("error", null);
                    %>
                    <table class="responsive" id="cssTable">
                        <col width="40%">
                        <col width="40%">
                        <col width="10%">
                        <col width="10%">
                        <tr>
                            <td>User Id</td>
                            <td>Password</td>
                            <td colspan="2" align="center" valign="middle">Actions</td>
                        </tr>
                        <%
                            for (Lecturer lecturer : lecturerList) {
                        %>
                        <tr>
                            <td> <%=lecturer.getLecturerID()%> </td>
                            <td> ************** </td>
                            <td> 
                                <form action="editAccount.jsp" method="post">
                                    <input type="hidden" name="userID" value="<%=lecturer.getLecturerID()%>">
                                    <input type="hidden" name="password" value="<%=lecturer.getLecturerPassword()%>">
                                    <input type="hidden" name="type" value="lecturer">
                                    <input type="submit" class="button tinytable" value="edit">
                                </form>
                            </td>
                            <%
                                String userLoggedIn = (String) session.getAttribute("lecturer");

                            %>
                            <td>
                                <form action="ProcessDeleteAccount" method="post">
                                    <input type="hidden" name="userID" value="<%=lecturer.getLecturerID()%>">
                                    <input type="hidden" name="password" value="<%=lecturer.getLecturerPassword()%>">
                                    <input type="hidden" name="type" value="lecturer">
                                    <%
                                        if (userLoggedIn != null && userLoggedIn.equals(lecturer.getLecturerID())) {
                                    %>
                                    <!--<input type="submit" class="button tinytable" value="delete" disabled>-->
                                    Logged in
                                    <%
                                    } else {
                                    %>
                                    <input type="submit" class="button tinytable" onclick="if (!deleteConfirmation())
                                                return false" value="delete" >
                                    <%
                                        }
                                    %>
                                </form>
                            </td>
                            <%
                                }
                            %>
                        </tr>

                    </table>
                    <form action="createAccount.jsp" method="post">
                        <input type="hidden" name="type" value="lecturer">
                        <input type="submit" class="button tiny" value="Create New Account">
                    </form>

                </center>

            </div>
        </div>
        <script src="js/vendor/jquery.js"></script>
        <script src="js/foundation.min.js"></script>
        <script>
                                        $(document).foundation();
        </script>       
    </body>
</html>
