<%-- 
    Document   : viewScenarioAdmin
    Created on : Oct 8, 2014, 10:34:55 PM
    Author     : Administrator
--%>

<%@page import="entity.Lecturer"%>
<%@page import="dao.LecturerDAO"%>
<%@page import="entity.LecturerScenario"%>
<%@page import="dao.LecturerScenarioDAO"%>
<%-- 
    Document   : viewCaseAdmin
    Created on : Sep 19, 2014, 3:56:39 PM
    Author     : Administrator
--%>
<!--IMPORTS-->
<%@page import="entity.Scenario"%>
<%@page import="java.util.List"%>
<%@page import="dao.ScenarioDAO"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@include file="protectPage/protectAdmin.jsp" %>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="utf-8" />
        <meta name="viewport" content="width=device-width, initial-scale=1.0" />

        <!--Web Title-->
        <title>EMR | Case Management | Manage Case</title>

        <!--CSS-->
        <link rel="stylesheet" href="css/foundation.css" />
        <link rel="stylesheet" href="css/original.css" />
        <script type="text/javascript" src="js/humane.js"></script>
        <script src="js/vendor/modernizr.js"></script>

        <!-- ADMIN TOP BAR-->
        <%@include file="/topbar/topbarAdmin.jsp" %>
        <script language="javascript" type="text/javascript">
            function showHide(shID) {
                if (document.getElementById(shID)) {
                    if (document.getElementById(shID + '-show').style.display != 'none') {
                        document.getElementById(shID + '-show').style.display = 'none';
                        document.getElementById(shID).style.display = 'block';
                    }
                    else {
                        document.getElementById(shID + '-show').style.display = 'inline';
                        document.getElementById(shID).style.display = 'none';
                    }
                }
            }
        </script>
        <style type="text/css">

            /* This CSS is used for the Show/Hide functionality. */
            .more {
                display: none;}
            a.showLink, a.hideLink {
                text-decoration: none;
                color: #007095;
                font-weight: bold;
                padding-left: 2px;
                background: transparent url(down.gif) no-repeat left; }
            a.hideLink {
                background: transparent url(up.gif) no-repeat left; }
            a.showLink:hover, a.hideLink:hover {
                border-bottom: 1px solid #007095; }
            </style>

        </head>

        <body style="font-size:14px; background-color: #ffffff;">
        <div class="row" style="padding-top: 30px; width: 300px;">
            <center><h1>Case Management</h1></center><br/>
            <form action ="ProcessResetAll" method="post">
                <input type = "submit" class="resetbutton tiny" onclick="if (!resetConfirmation())
                            return false" value="Reset All Cases" >
            </form>
        </div>

        <div class="large-12 columns" style="padding-top: 0px;">
            <%                //Retrieve all the successful messages 
                String success = "";
                if (session.getAttribute("success") != null) {
                    success = (String) session.getAttribute("success");
                    session.setAttribute("success", "");
                }

            %>
            <!--Retrieve all scenarios from scenarioDAO-->
            <%List<Scenario> scenarioList = ScenarioDAO.retrieveAll();%>

            <!--TABLE-->
            <table>
                <col width="2%">
                <col width="5%">
                <col width="5%">
                <col width="30%">
                <col width="53%">
                <col width="5%">
                <thead>
                    <tr>
                        <th>ID</th>
                        <th>Name</th>
                        <th>Status</th>
                        <th>Description</th>
                        <th>Admission Information</th>
                        <th>Action</th>

                    </tr>
                </thead>
                <!--Loop through the scenarioList and retrieve each detail-->
                <% for (Scenario scenario : scenarioList) {
                        String scenarioID = scenario.getScenarioID();
                        String scenarioName = scenario.getScenarioName();
                        String scenarioDescription = scenario.getScenarioDescription();
                        LecturerScenario lecScenario = LecturerScenarioDAO.retrieve(scenarioID); // if lecScenario == null, then it is NOT activated

                        String admissionInfo = scenario.getAdmissionNote();%>

                <tr>
                    <td><%=scenarioID%></td>
                    <td><%=scenarioName%></td>
                    <td><%
                        if (lecScenario != null) {
                        %>
                        <font color= "green"><b>Activated</b></font> by<br>

                        <%
                            List<String> lecActivatedList = LecturerScenarioDAO.retrieveLecturerActivatedScenario(scenarioID);

                            for (int i = 0; i < lecActivatedList.size(); i++) {
                                String lecturer = lecActivatedList.get(i);

                                if (i == lecActivatedList.size() - 1) {
                                    out.println(lecturer);
                                } else {
                                    out.println(lecturer + ", ");
                                }
                            }
                        %>
                        <%} else {%>
                        <font color= "red">Deactivated</font>
                        <%}

                        %></td>
                    <td>
                        <%                            int first = 0;
                            for (int i = 0; i < scenarioDescription.length(); i++) {
                                first = scenarioDescription.indexOf(".") + 1;
                                if (first == -1) {
                                    first = 0;
                                }
                            }

                            if (first == 0) {
                                out.println(scenarioDescription.substring(0, scenarioDescription.length()));
                            } else {
                                out.println(scenarioDescription.substring(0, first));
                        %>
                        <a href="#" id="<%=scenarioID%>-show" class="showLink" onclick="showHide('<%=scenarioID%>');
                                return false;">See more > </a>
                        <div id="<%=scenarioID%>" class="more">
                            <%
                                String more1 = scenarioDescription.substring(first, scenarioDescription.length());
                                out.println("<br>" + more1);
                                first = 0;
                            %>
                            <a href="#" id="<%=scenarioID%>-hide" class="hideLink" onclick="showHide('<%=scenarioID%>');
                                    return false;"> < Hide</a>
                        </div>
                        <% } %>
                    </td>
                    <td>
                        <%
                            int start = 0;
                            for (int i = 0; i < admissionInfo.length(); i++) {
                                start = admissionInfo.indexOf("Healthcare");
                                if (start == -1) {
                                    start = 0;
                                }
                            }

                            if (start == 0) {
                                out.println(admissionInfo.substring(0, admissionInfo.length()));
                            } else {
                                int newStart = admissionInfo.lastIndexOf(".", start);
                                out.println(admissionInfo.substring(0, newStart + 1));

                                String scenarioID2 = scenarioID + scenarioID;
                        %>
                        <a href="#" id="<%=scenarioID2%>-show" class="showLink" onclick="showHide('<%=scenarioID2%>');
                                return false;">See Healthcare Provider's Order > </a>
                        <div id="<%=scenarioID2%>" class="more">
                            <%
                                String more = admissionInfo.substring(start, admissionInfo.length());
                                out.println("<br>" + more);
                                start = 0;
                            %>
                            <a href="#" id="<%=scenarioID2%>-hide" class="hideLink" onclick="showHide('<%=scenarioID2%>');
                                    return false;"> < Hide Healthcare Provider's Order</a>
                        </div>
                        <% }%>
                    </td>


                    <!--ACTIVATE-->
                    <td><center>
                    <form action ="viewCaseAdmin.jsp" method ="POST">
                        <input type="hidden" name="scenarioID" value="<%=scenarioID%>">
                        <input type ="submit" class="button tiny" value = "View Full Case">
                    </form>    

                    <%                    if (lecScenario != null) { //it is activated by some lecturer

                    %>



                    <form action ="deactivateScenarioAdmin.jsp" method ="POST">
                        <input type ="submit" class="button tiny" value = "Deactivate">
                        <input type="hidden" name="status" value="deactivated">
                        <input type="hidden" name="scenarioID" value="<%=scenarioID%>">
                        <input type="hidden" name="status" value="activated">
                    </form>

                    <form action ="activateScenarioAdmin.jsp" method ="POST">    
                        <input type ="submit" class="button tiny" value = "Activate">
                        <input type="hidden" name="status" value="deactivated">
                        <input type="hidden" name="scenarioID" value="<%=scenarioID%>">
                        <input type="hidden" name="status" value="activated">
                    </form>
                    <%} else { // it is not activated, only show activated button%>
                    <form action ="activateScenarioAdmin.jsp" method ="POST">
                        <input type ="submit" class="button tiny" value="Activate" >

                        <% }

                        %>
                        <input type="hidden" name="scenarioID" value="<%=scenarioID%>">
                        <input type="hidden" name="status" value="activated">
                    </form>

                    <!--EDIT-->
                    <form action ="editScenario.jsp" method ="POST">
                        <input type="hidden" name="scenarioID" value="<%=scenarioID%>">
                        <%

                            if (lecScenario != null) {
                        %>
                        <!--<input type = "submit" class="button tiny" value="edit" disabled>-->
                        <center><font size="2" color="#666666">Unable to edit activated case.</font></center>

                        <% } else { %>
                        <input type = "submit" class="button tiny" value="Edit">
                        <% }%>
                    </form>

                    <!--DELETE-->    
                    <form action ="ProcessDeleteScenario" method ="POST">
                        <input type="hidden" name="scenarioID" value="<%=scenarioID%>">
                        <%
                            if (lecScenario != null) {

                        %>
                        <!--<input type = "submit" class="deletebutton tiny" value="delete" disabled>-->
                        <center><font size="2" color="#666666">Unable to delete activated case.</font></center>

                        <% } else {
                        %>


                        <input type = "submit" class="deletebutton tiny" onclick="if (!deleteConfirmation())
                                    return false" value="Delete" >

                        <% }%>
                    </form>
                </center></td>  
                </tr>
                <%}%>  
            </table> 
            <br/><br/><br/>
        </div>

        <!--Scripts-->
        <script src="js/vendor/jquery.js"></script>
        <script src="js/foundation.min.js"></script>
        <script>
                            $(document).ready(function() {
                                $(document).foundation();
                                var humaneSuccess = humane.create({baseCls: 'humane-original', addnCls: 'humane-original-success', timeout: 2000, clickToClose: true});

                                var success1 = "<%=success%>";
                                if (success1 !== "") {
                                    humaneSuccess.log(success1);
                                }
                            });
        </script>
        <script type="text/javascript">
            function resetConfirmation() {
                var resetButton = confirm("Resetting will deactivate all cases and delete ALL information, you will not be able to retrieve them. Please ensure you have exported the documents before resetting. ")
                if (resetButton) {
                    return true;
                }
                else {
                    return false;
                }
            }

        </script>

        <script type="text/javascript">
            function deleteConfirmation() {
                var deleteButton = confirm("Are you sure you want to permanently delete the case? You will not be able to retrieve them after you have deleted. ")
                if (deleteButton) {
                    return true;
                }
                else {
                    return false;
                }
            }

        </script>

        <script type="text/javascript" src="js/humane.js"></script>
    </body>
</html>
