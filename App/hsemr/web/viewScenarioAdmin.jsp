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

        <script src="js/vendor/modernizr.js"></script>
        <!-- ADMIN TOP BAR-->
        <%@include file="/topbar/topbarAdmin.jsp" %>

        <!--POP UP BOX-->
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

        <title>NP Health Sciences | Case Management</title>
    </head>

    <body style="font-size:14px; line-height:20px;">
         <br/>
    <center> <h1>Case Management</h1>
  
    <div class="large-12 columns" style="padding-top: 20px;">
        <%            //Retrieve all the successful messages 
            String successMessageCreateScenario = (String) session.getAttribute("successMessageCreateScenario");
            String successMessageEditScenario = (String) session.getAttribute("successMessageEditScenario");
            String successMessageDeleteScenario = (String) session.getAttribute("successMessageDeleteScenario");
        %>
            <%if (successMessageCreateScenario != null) {%>
            <div data-alert class="alert-box success radius">
                <%=successMessageCreateScenario%>
                <a href="#" class="close">&times;</a>
            </div>
            <%}
                session.getAttribute("successMessageCreateScenario"); %>

            <%if (successMessageEditScenario != null) {%>
            <div data-alert class="alert-box success radius">
                <%=successMessageEditScenario%>
                <a href="#" class="close">&times;</a>
            </div>
            <%}
                session.removeAttribute("successMessageEditScenario"); %>

            <%if (successMessageDeleteScenario != null) {%>
            <div data-alert class="alert-box success radius">
                <%=successMessageDeleteScenario%>
                <a href="#" class="close">&times;</a>
            </div>
            <%}
                session.removeAttribute("successMessageDeleteScenario"); %>

            <%List<Scenario> scenarioList = ScenarioDAO.retrieveAll();%>
         
            <table border="1" style="border-collapse: collapse;">
                <thead>
                    <tr>
                        <th>ID</th>
                        <th>Name</th>
                        <th>Status</th>
                        <th>Description</th>
                        <th>Admission Information</th>
                        <th>Edit</th>
                        <th>Delete</th>
                        <th>Activate/Deactivate</th>

                    </tr>
                </thead>
                <tbody>
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
                        <td>
                            <form action ="editScenario.jsp" method ="POST">
                                <input type="hidden" name="scenarioID" value="<%=scenarioID%>">
                                <input type = "submit" class="button tiny" value="edit">
                            </form>
                        </td>

                        <td>                          
                            <form action ="ProcessDeleteScenario" method ="POST">
                                <input type="hidden" name="scenarioID" value="<%=scenarioID%>">
                                <input type = "submit" class="button tiny" onclick="if (!deleteConfirmation())
                                            return false" value="delete" >
                            </form>
                        </td>  

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
                        </td>
                    </tr>
                </tbody>
                <%}%>  
            </table> 
        </div>
               </center>
    <script src="js/vendor/jquery.js"></script>
    <script src="js/foundation.min.js"></script>

    <script>
                                    $(document).foundation();
    </script>
</body>
</html>
