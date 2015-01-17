<%-- 
    Document   : viewScenarioAdmin
    Created on : Oct 8, 2014, 10:34:55 PM
    Author     : Administrator
--%>

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

        <!--CSS-->
        <link rel="stylesheet" href="css/foundation.css" />
        <link rel="stylesheet" href="css/original.css" />
        <script type="text/javascript" src="js/humane.js"></script>
        <script src="js/vendor/modernizr.js"></script>

        <!-- ADMIN TOP BAR-->
        <%@include file="/topbar/topbarAdmin.jsp" %>

        <!--POP UP BOX-->

        <title>NP Health Sciences | Case Management</title>
    </head>

    <body style="font-size:14px; background-color: #ffffff">
    <center><br/><br/><h1>Case Management</h1>

        <form action ="ProcessResetAll" method="post">
            <input type = "submit" class="deletebutton tiny" onclick="if (!resetConfirmation())
                                    return false" value="Reset All" >
            
        </form>

        </center>
        <div class="large-12 columns" style="padding-top: 20px;">
            <%  //Retrieve all the successful messages 
                String success = "";
                if (session.getAttribute("success") != null) {
                    success = (String) session.getAttribute("success");
                    session.setAttribute("success", "");
                }

            %>
        <!--Retrieve all scenarios from scenarioDAO-->
        <%List<Scenario> scenarioList = ScenarioDAO.retrieveAll();%>

        <!--TABLE-->
        <table class="responsive">
            <col width="5%">
            <col width="5%">
            <col width="5%">
            <col width="20%">
            <col width="30%">
            <col width="15%">
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
                    int status = scenario.getScenarioStatus();
                    String admissionInfo = scenario.getAdmissionNote();%>

            <tr>
                <td><%=scenarioID%></td>
                <td><%=scenarioName%></td>
                <td><% if (status == 1) {%>
                    <font color= limegreen>Activated</font>
                    <%} else {%>
                    <font color= red>Deactivated</font>
                    <%}%></td>
                <td><%=scenarioDescription%></td>
                <td><%=admissionInfo%></td>

                <!--ACTIVATE-->
                <td>
                    <form action ="ProcessActivateScenarioAdmin" method ="POST">
                        <input type="hidden" name="scenarioID" value="<%=scenarioID%>">
                        <% if (status == 1) {%>
                        <input type ="submit" class="button tiny" value = "deactivate">
                        <input type="hidden" name="status" value="deactivated">
                        <%} else {
                            Scenario activatedScenario = ScenarioDAO.retrieveActivatedScenario();
                            if (activatedScenario != null) { %>
                        <input type ="submit" class="button tiny" onclick="if (!activateConfirmation())
                                    return false" value="activate" >
                        <%} else { %>
                        <input type ="submit" class="button tiny" value="activate">
                        <% }
                            }%>
                        <input type="hidden" name="status" value="activated">
                    </form>

                    <!--EDIT-->
                    <form action ="editScenario.jsp" method ="POST">
                        <input type="hidden" name="scenarioID" value="<%=scenarioID%>">
                        <input type = "submit" class="button tiny" value="edit">
                    </form>

                    <!--DELETE-->    
                    <form action ="ProcessDeleteScenario" method ="POST">
                        <input type="hidden" name="scenarioID" value="<%=scenarioID%>">
                        <% if (status == 1) {
                        %>
                        <input type = "submit" class="deletebutton tiny" value="delete" disabled>
                        <% } else {
                        %>
                        <input type = "submit" class="deletebutton tiny" onclick="if (!deleteConfirmation())
                                    return false" value="delete" >
                        <% } %>
                    </form>
                </td>  
            </tr>
            <%}%>  
        </table> 
    </div>

    <!--Scripts-->
    <script src="js/vendor/jquery.js"></script>
    <script src="js/foundation.min.js"></script>
    <script>
                            $(document).ready(function () {
                                $(document).foundation();
                                var humaneSuccess = humane.create({baseCls: 'humane-original', addnCls: 'humane-original-success', timeout: 2000, clickToClose: true});

                                var success1 = "<%=success%>";
                                if (success1 !== "") {
                                    humaneSuccess.log(success1);
                                }
                            });
    </script>
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
        
        function resetConfirmation() {
            var resetButton = confirm("Resetting will delete ALL information, you will not be able to retrieve them. Please ensure you have exported the documents before resetting. ")
            if (resetButton) {
                return true;
            }
            else {
                return false;
            }
        }

        function activateConfirmation() {
            var activateButton = confirm("Only one case can be activate each round. Activating this case will deactivate the rest.")
            if (activateButton) {
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
