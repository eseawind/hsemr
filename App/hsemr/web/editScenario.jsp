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
        
        
          <script type="text/javascript">
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
        <title>HS EMR - Edit Scenario</title>
    </head>

    <body>
        <%            
            String scenarioID = request.getParameter("scenarioID");
            Scenario retrievedScenario = ScenarioDAO.retrieve(scenarioID);
        %>
        <div class="row" style="padding-top: 30px;">
            <div class="large-centered large-12 columns">
                <center>
                    <h1>Edit Case's details</h1>
                    <form action = "ProcessEditScenario" method = "POST">
                        <div class="row">

                            <div class="large-12 columns">

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
                                    <input id="right-label" name="status" type="radio" value="activated" checked />activate
                                    <input id="right-label" name="status" type="radio" value="deactivated" /> deactivate
                                    <% } else { %>

                                    <input id="right-label" name="status" type="radio" value="activated" />activate
                                    <input id="right-label" name="status" type="radio" value="deactivated" checked/> deactivate
                                    <% }%>
                                    <br><br>
                                </div>
                            </div>
                            <div class="row">
                                <div class="large-12 columns">
                                    <div class="small-2 columns">

                                        <label for="right-label" class="right inline">Description</label> 
                                    </div>
                                    <div class="large-10 columns">
                                        <textarea style="overflow:auto;resize:none" name = "scenarioDescription" rows = "10" required><%=retrievedScenario.getScenarioDescription()%>  </textarea>
                                    </div>
                                </div>
                            </div>

                            <div class="row">
                                <div class="large-12 columns">
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
                                Scenario activatedScenario = ScenarioDAO.retrieveActivatedStatus();
                            
                                if (activatedScenario != null) { %>
                                    <input type = "submit" class="button tiny" onclick="if (!activateConfirmation())
                                            return false" value="Save" >
                            <%} else { %>
                                    <input type ="submit" class="button tiny" value="Save">
                            <% }
                            }
                            %>
                            </form>
                            </center>
                        </div>
                        </div>

                        </body>
                        </html>
