<%-- 
    Document   : editPracticalGroupAccount
    Created on : Oct 15, 2014, 2:50:03 PM
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
        <link rel="stylesheet" href="css/foundation.css" />
        <link rel="stylesheet" href="responsive-tables.css">
        <link rel="stylesheet" href="css/original.css" />
        <script type="text/javascript" src="js/humane.js"></script>
        <script src="responsive-tables.js"></script>
        <%@include file="/topbar/topbarAdmin.jsp" %>

        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>NP Health Sciences | Administrator Accounts Management | Edit Practical Group Accounts</title>
    </head>
    <body>
        <%                String userID = "";
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
            <div class="row" style="width:400px; padding-top: 50px">
                <center><h1>Edit <%=userID%>'s details</h1></center>


                <%

                    String error = (String) request.getAttribute("error");
                    if (error == null) {
                        error = "";
                    }
                %>

                <form action = "ProcessEditAccount" method = "post">
                    <br/>
                    <!--User ID-->
                    <label><strong>User ID</strong>
                        <input type="text" id="userID" name="userID" value="<%=userID%>" readonly>
                    </label>
                    <br/>

                    <!--Password-->
                    <label><strong>New Password</strong>
                        <input type="password" id="password" name="password" autofocus>
                    </label>  
                    <br/>
                    <!--Confirm Password-->
                    <label><strong>Confirm Password</strong>
                        <input type="password" id="confirmPassword" name="confirmPassword" >
                    </label>  
                    <br/>
                    <!--Lecturer In-charge-->
                    <label><strong>Lecturer-in-charge</strong>
                        <select name="lecturerID">
                            <%
                                List<Lecturer> lecturerList = LecturerDAO.retrieveAll();
                                PracticalGroup pg = PracticalGroupDAO.retrieve(userID);
                                String lecturerID = pg.getLecturerID();
                                for (Lecturer lecturer : lecturerList) {

                                    if (lecturer.getLecturerID().equals(lecturerID)) {%>
                            <option value="<%=lecturer.getLecturerID()%>" selected><%=lecturer.getLecturerID()%></option>
                            <% } else {%>
                            <option value="<%=lecturer.getLecturerID()%>"><%=lecturer.getLecturerID()%></option>
                            <%
                                    }
                                }
                            %>
                        </select>
                    </label>  
                    <br/><br/>

                    <input type="hidden" id="right-label" name="type" value="<%=request.getParameter("type")%>">
                    <center><input type="submit" class="button tiny" value="Save"> 
                        <input type="button" value="Cancel" class="button tiny" onClick="window.location = '<%=location%>'"/>
                    </center>
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