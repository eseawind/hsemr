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
        <title>NP Health Sciences | Accounts Management</title>
    </head>
    <body>
        <%            List<PracticalGroup> practicalGroupList = PracticalGroupDAO.retrieveAll();

        %>
        <div class="row" style="padding-top: 30px;">
            <div class="large-centered large-12 columns">
                <center>
                    <h1>Practical Group Accounts Management</h1>
                    <div class ="large-11">
                         <div class ="medium-11">
                        <%if (session.getAttribute("successNurse") != null) {%>
                        <div data-alert class="alert-box success radius">
                           <%=session.getAttribute("successNurse")%>
                            <a href="#" class="close">&times;</a>
                        </div>
                        <%
                            session.setAttribute("successNurse",null);                        
                            }
                        %>
                    </div>
                    <table class="responsive" id="cssTable">
                        <col width="25%">
                        <col width="25%">
                        <col width="25%">
                        <col width="10%">
                        <col width="10%">
                        <tr>
                            <td>User Id</td>
                            <td>Password</td>
                            <td>Lecturer Id</td>
                            <td colspan="2" align="center" valign="middle">Actions</td>
                        </tr>
                        <%
                            for (PracticalGroup practicalGroup : practicalGroupList) {
                        %>
                        <tr>
                            <td> <%=practicalGroup.getPracticalGroupID()%> </td>
                            <td> ************** </td>
                            <td> <%=practicalGroup.getLecturerID()%> </td>
                            <td> 
                                <form action="editPracticalGroupAccount.jsp" method="post">
                                    <input type="hidden" name="userID" value="<%=practicalGroup.getPracticalGroupID()%>">
                                    <input type="hidden" name="password" value="<%=practicalGroup.getPracticalGroupPassword()%>">
                                    <input type="hidden" name="lecturerID" value="<%=practicalGroup.getLecturerID()%>">
                                    <input type="hidden" name="type" value="nurse">
                                    <input type="submit" class="button tinytable" value="edit">
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
                    <form action="createPracticalGroupAccount.jsp" method="post">
                        <input type="hidden" name="type" value="nurse">
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