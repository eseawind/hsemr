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
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>NP Health Sciences | Lecturer Accounts Management</title>
    </head>
    <body>
        <%            List<Lecturer> lecturerList = LecturerDAO.retrieveAll();

        %>
        <div class="row" style="padding-top: 30px;">
            <div class="large-centered large-12 columns">
                <center>
                    <h1>Lecturer Accounts Management</h1><br/><br/>
                        <%
                        String success = ""; 
                        String error = "";
                        if (session.getAttribute("success") != null) {

                            success = (String) session.getAttribute("success");
                            session.setAttribute("success", "");
                        
                        }
                        if (session.getAttribute("error") != null) {

                            error = (String) session.getAttribute("error");
                            session.setAttribute("error", "");
                        
                        }
                        %>
                    <table class="responsive" id="cssTable">
                        <col width="30%">
                        <col width="30%">
                        <col width="10%">
                        <col width="10%">
                        <thead>
                        <tr>
                            <th><b>User ID</b></th>
                            <th><b>Password</b></th>
                            <td colspan="2" align="center" valign="middle"><b>Actions</b></td>
                        </tr>
                        </thead>
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
                                    <div class style="padding-top:7px"><b><font color="#368a55">LOGGED IN</font></b></div>
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

                    </table><br/><br/><br/>
                    <form action="createAccount.jsp" method="post">
                        <input type="hidden" name="type" value="lecturer">
                        <input type="submit" class="button small" value="Create New Account">
                    </form>

                </center>
            </div>
        </div>
        <script src="js/vendor/jquery.js"></script>
        <script src="js/foundation.min.js"></script>
        <script>
                $(document).ready(function () {
                    $(document).foundation();
                    var humaneSuccess = humane.create({baseCls: 'humane-original', addnCls: 'humane-original-success', timeout: 2000, clickToClose: true})
                    var humaneError = humane.create({baseCls: 'humane-original', addnCls: 'humane-original-error', timeout: 10000, clickToClose: true})

                    var success1 = "<%=success%>";
                    var error1 = "<%=error%>";
                    if (success1 !== "") {
                        humaneSuccess.log(success1);
                    } else if (error1 !== "") {
                        humaneError.log(error1);
                    }

                });
            </script>
            <script type="text/javascript" src="js/humane.js"></script>     
    </body>
</html>
