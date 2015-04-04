<%-- 
    Document   : viewPracticalGroupAccounts
    Created on : Oct 15, 2014, 2:04:52 PM
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
        <title>EMR | User Management | Practical Group</title>
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
        <%            List<PracticalGroup> practicalGroupList = PracticalGroupDAO.retrieveAll();

        %>
        <div class="row" style="padding-top: 30px;">
            <div class="large-centered large-12 columns">
                <center><h1>Practical Group Accounts Management</h1><br/><br/>
                    <%                          String success = "";

                        if (session.getAttribute("success") != null) {

                            success = (String) session.getAttribute("success");
                            session.setAttribute("success", "");

                        }
                    %>


                    <table class="responsive" id="cssTable">
                        <col width="20%">
                        <col width="20%">
                        <col width="20%">
                        <col width="10%">
                        <col width="10%">
                        <thead>
                            <tr>
                                <th>User ID</th>
                                <th>Password</th>
                                <th>Lecturer-in-charge</th>
                                <th colspan="2" align="center" valign="middle">Actions</th>
                            </tr>
                        </thead>
                        <%
                            for (PracticalGroup practicalGroup : practicalGroupList) {
                        %>
                        <tr>
                            <td> <%=practicalGroup.getPracticalGroupID()%> </td>
                            <td> ********** </td>
                            <td> <%=practicalGroup.getLecturerID()%> </td>
                            <td> 
                                <form action="editPracticalGroupAccount.jsp" method="post">
                                    <input type="hidden" name="userID" value="<%=practicalGroup.getPracticalGroupID()%>">
                                    <input type="hidden" name="password" value="<%=practicalGroup.getPracticalGroupPassword()%>">
                                    <input type="hidden" name="lecturerID" value="<%=practicalGroup.getLecturerID()%>">
                                    <input type="hidden" name="type" value="nurse">
                                    <center><input type="submit" class="button tinytable" value="edit"></center>
                                </form>
                            </td>
                            <%
                                String userLoggedIn = (String) session.getAttribute("nurse");
                            %>
                            <td>
                                <form action="ProcessDeleteAccount" method="post">
                                    <input type="hidden" name="userID" value="<%=practicalGroup.getPracticalGroupID()%>">
                                    <input type="hidden" name="type" value="nurse">
                                    <%
                                        if (userLoggedIn != null && userLoggedIn.equals(practicalGroup.getPracticalGroupID())) {
                                    %>
                                    <!--<input type = "submit" class="button tinytable" value="delete" disabled>-->
                                    <center><div class style="padding-top:7px"><b><font color="#368a55">LOGGED IN</font></b></div></center>
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
                    <form action="createPracticalGroupAccount.jsp" method="post">
                        <input type="hidden" name="type" value="nurse">
                        <input type="submit" class="button small" value="Create New Account">
                    </form>
                </center>
            </div>
        </div>
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