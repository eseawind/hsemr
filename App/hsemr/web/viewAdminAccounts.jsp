<%-- 
    Document   : viewAdminAccounts
    Created on : Sep 30, 2014, 08:13:50 PM
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

        <!--Web Title-->
        <title>EMR | User Management | Admin</title>

        <link rel="stylesheet" href="css/foundation.css" />
        <link rel="stylesheet" href="css/original.css" />
        <script type="text/javascript" src="js/humane.js"></script>
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
    </head>
    <body>
        <%            List<Admin> adminList = AdminDAO.retrieveAll();
        %>
        <div class="row" style="padding-top: 30px;">
            <div class="large-centered large-12 columns">
                <center><h1>Administrator Accounts Management</h1><br/><br/>
                    <%
                        String success = "";

                        if (session.getAttribute("success") != null) {

                            success = (String) session.getAttribute("success");
                            session.setAttribute("success", "");

                        }
                    %>
                    <!--TABLE-->
                    <table class="responsive" id="cssTable">
                        <col width="30%">
                        <col width="30%">
                        <col width="10%">
                        <col width="10%">
                        <thead>
                            <tr>
                                <th>User ID</th>
                                <th>Password</th>
                                <th colspan="2" align="center" valign="middle">Actions</th>
                            </tr>
                        </thead>
                        <%
                            for (Admin admin : adminList) {
                        %>
                        <tr>
                            <td> <%=admin.getAdminID()%> </td>
                            <td> ************** </td>
                            <td> 
                                <form action="editAccount.jsp" method="post">
                                    <input type="hidden" name="userID" value="<%=admin.getAdminID()%>">
                                    <input type="hidden" name="password" value="<%=admin.getAdminPassword()%>">
                                    <input type="hidden" name="type" value="admin">
                                    <center><input type="submit" class="button tinytable" value="edit"></center>
                                </form>
                            </td>
                            <%
                                String userLoggedIn = (String) session.getAttribute("admin");
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
                                    <center><div class style="padding-top:7px"><b><font size="2" color="#368a55">LOGGED IN</font></b></div></center>
                                                <%
                                                } else {
                                                %>
                                    <center><input type="submit" class="button tinytable" onclick="if (!deleteConfirmation())
                                                return false" value="delete" ></center>
                                        <%
                                            }
                                        %>
                                </form>
                            </td>
                            <%
                                }
                            %>
                        </tr>

                    </table><br/><br/><br/>

                    <!--Create New Account button-->
                    <form action="createAccount.jsp" method="post">
                        <input type="hidden" name="type" value="admin">
                        <input type="submit" class="button small" value="Create New Account">
                    </form>
                </center>
            </div>
        </div>
        <!--Scripts-->
        <script src="js/vendor/jquery.js"></script>
        <script src="js/foundation.min.js"></script>
        <script>

                                        $(document).ready(function() {
                                            $(document).foundation();
                                            var humaneSuccess = humane.create({baseCls: 'humane-original', addnCls: 'humane-original-success', timeout: 1000, clickToClose: true})

                                            var success1 = "<%=success%>";
                                            if (success1 !== "") {
                                                humaneSuccess.log(success1);
                                            }

                                        });
        </script>
        <script type="text/javascript" src="js/humane.js"></script>
    </body>

</html>
