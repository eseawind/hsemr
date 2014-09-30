<%-- 
    Document   : viewAdminAccounts
    Created on : Sep 30, 2014, 08:13:50 PM
    Author     : weiyi.ngow.2012
--%>

<%@page import="entity.Nurse"%>
<%@page import="entity.Lecturer"%>
<%@page import="java.util.List"%>
<%@page import="java.util.List"%>
<%@page import="entity.Admin"%>
<%@page import="dao.NurseDAO"%>
<%@page import="dao.LecturerDAO"%>
<%@page import="dao.AdminDAO"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@include file="protect.jsp" %>
<!DOCTYPE html>
<html>
    <head>
        <link rel="stylesheet" href="css/foundation.css" />
        <link rel="stylesheet" href="responsive-tables.css">
        <script src="responsive-tables.js"></script>
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
        <title>Accounts Management</title>
    </head>
    <body>
        <%            
            List<Admin> adminList = AdminDAO.retrieveAll();
        %>

        <div class="row" style="padding-top: 30px;">
            <div class="large-centered large-12 columns">
                <center>
                    <h1>Administrator Accounts Management</h1>

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
                            for (Admin admin : adminList) {
                        %>
                        <tr>
                            <td> <%=admin.getAdminID()%> </td>
                            <td> <%=admin.getAdminPassword()%> </td>
                            <td> 
                                <form action="editAccount.jsp" method="post">
                                    <input type="hidden" name="userID" value="<%=admin.getAdminID()%>">
                                    <input type="hidden" name="password" value="<%=admin.getAdminPassword()%>">
                                    <input type="hidden" name="type" value="admin">
                                    <input type="submit" class="button tinytable" value="edit">
                                </form>
                            </td>
                            <%
                                String userLoggedIn = (String) session.getAttribute("user");
                            %>
                            <td>
                                <form action="ProcessDeleteAccount" method="post">
                                    <input type="hidden" name="userID" value="<%=admin.getAdminID()%>">
                                    <input type="hidden" name="password" value="<%=admin.getAdminPassword()%>">
                                    <input type="hidden" name="type" value="admin">
                                    <%
                                        if (userLoggedIn != null && userLoggedIn.equals(admin.getAdminID())) {
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
                        <input type="hidden" name="type" value="admin">
                        <input type="submit" class="button tiny" value="Create New Account">
                    </form>

                </center>

            </div>
        </div>
    </body>
</html>
