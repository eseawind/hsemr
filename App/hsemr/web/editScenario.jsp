<%-- 
    Document   : editScenario
    Created on : Oct 8, 2014, 10:41:45 PM
    Author     : Administrator
--%>

<%@page import="entity.Scenario"%>
<%@page import="dao.ScenarioDAO"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@include file="protectPage/protectAdmin.jsp" %>
<!DOCTYPE html>
<html>
    <head>
        <link rel="stylesheet" href="css/foundation.css" />
        <link rel="stylesheet" href="responsive-tables.css">
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <%@include file="/topbar/topbarAdmin.jsp" %>


        <!--          <script type="text/javascript">
                    function activateConfirmation() {
                        
                        var activateButton = confirm("Only one case can be activate each round. Activating this case will deactivate the rest.")
                        if (activateButton) {
                            return true;
                        }
                        else {
                            return false;
                        }
                    }
        
                </script>-->
        <title>NP Health Sciences | Case Management | Edit Scenario</title>
    </head>

    <body>
        <%            String scenarioID = request.getParameter("scenarioID");
            Scenario retrievedScenario = ScenarioDAO.retrieve(scenarioID);
            Scenario activatedScenario = ScenarioDAO.retrieveActivatedScenario();
        %>
        <div class="row" style="padding-top: 30px;">
            <div class="large-centered large-12 columns">
                <center>
                    <h1>Edit Case Details</h1><br/>

                    <form action="ProcessEditScenario" method = "POST">

                        <div class="small-2 columns">
                            <label for="right-label" class="right inline">Case ID</label>
                            <label for="right-label" class="right inline">Name</label>
                            <label for="right-label" class="right inline">Status</label>
                        </div>

                        <div class="small-8 small-centered columns">
                            <input type="text" id="right-label" name="scenarioID" value="<%=retrievedScenario.getScenarioID()%>" readonly >
                            <input type="text" id="right-label" name="scenarioName" value="<%=retrievedScenario.getScenarioName()%>" required >
                            <br>
                            <%
                                if (retrievedScenario.getScenarioStatus() == 1) { %>

                            <input id="right-label" name="status" type="radio" value="activated" checked /> Activate

                            <input id="right-label" name="status" type="radio" value="deactivated" /> Deactivate

                            <% } else { %>
                            <table style="border-color: white">
                                <col width="15%">
                                <col width="75%">
                                <tr>
                                    <td><input id="right-label" name="status" type="radio" value="activated" /> Activate</td>
                                    <td><input id="right-label" name="status" type="radio" value="deactivated" checked/> Deactivate

                                    <% if (activatedScenario != null) { %>   
                                    <font color="red">Note: Activating this case will deactivate the rest.</font></td>
                                        <%
                                    }
                                }%>  
                                </tr>
                            </table>
                        </div>                          
                        <div class="row">
                            <div class="large-12 columns">
                                <div class="small-2 columns">

                                    <label for="right-label" class="right inline">Description</label> 
                                </div>
                                <div class="large-10 columns">
                                    <textarea style="overflow:auto;resize:none" name = "scenarioDescription" rows = "10" required><%=retrievedScenario.getScenarioDescription()%>  </textarea>
                                </div>

                                <div class="small-2 columns">
                                    <label for="right-label" class="right inline">Admission Information</label>
                                </div>
                                <div class="large-10 columns">
                                    <textarea style="overflow:auto;resize:none" name = "admissionInfo" rows = "16" required><%=retrievedScenario.getAdmissionNote()%> </textarea>
                                </div>
                            </div>
                        </div>
                        <%

                            if (retrievedScenario.getScenarioStatus() == 1) {
                        %>
                        <input type ="submit" class="button tiny" value="Save">
                        <%
                        } else {

                            if (activatedScenario != null) { %>
                        <!--                                    <input type = "submit" class="button tiny" onclick="if (!activateConfirmation())
                                                                    return false" value="Save" >-->
                        <input type ="submit" class="button tiny" value="Save">
                        <%} else { %>
                        <input type ="submit" class="button tiny" value="Save">
                        <% }
                            }
                        %>
                        <input type="button" value="Cancel" class="button tiny" onClick="window.location = 'viewScenarioAdmin.jsp'"/>
                    </form>
                </center>
            </div>
        </div>

    </body>
</html>
