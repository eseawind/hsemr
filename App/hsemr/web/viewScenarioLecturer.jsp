<%-- 
    Document   : viewScenarioLecturer
    Created on : Oct 9, 2014, 8:41:17 AM
    Author     : gladyskhong.2012
--%>
<%@page import="entity.Scenario"%>
<%@page import="dao.ScenarioDAO"%>
<%@page import="java.util.List"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@include file="protect.jsp" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>View Scenario</title>
        <link rel="stylesheet" href="css/foundation.css" />
        <script src="js/vendor/modernizr.js"></script>
        <script>
            $(document).ready(function () {
                $(document).foundation();
            });
        </script>
        <style>
            #color {
                background-color: grey;
                float: left;
            }#opacity    {
                opacity : 0.4;
                filter: alpha(opacity=40); 
            }
        </style>

    </head>
    <body>

        <div class ="large-11">

            <%            
            String successMessageDeactivateCase = (String) request.getAttribute("successMessageDeactivateCase");
            String successMessageActivateCase = (String) request.getAttribute("successMessageActivateCase");
            
                if (successMessageDeactivateCase!= null) {%>
            <div data-alert class="alert-box success radius">
                You have successfully deactivated the case!
                <a href="#" class="close">&times;</a>
            </div>
            <%}
                session.removeAttribute("successMessageDeactivateCase"); %>
        </div>

        <div class ="large-11">
            <%if (successMessageActivateCase != null) {%>
            <div data-alert class="alert-box success radius">
                You have successfully activated the case!
                <a href="#" class="close">&times;</a>
            </div>
            <%}
                session.removeAttribute("successMessageActivateCase"); %>
        </div>


       
        <div align ="center">


            <%

                String imgName = "";
                String scenarioID = "";

                List<Scenario> scenarioList = ScenarioDAO.retrieveAll();

                for (int i = 0; i < scenarioList.size(); i++) {
                    Scenario scenario = scenarioList.get(i);
            %>

            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
            <!-- <span class="label"><%= scenario.getStatus()%></span> -->
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
            <%
                }
            %>
        </div>

        <div class="large-centered large-6 columns">
            <table>


                <%
                    int sizeOfList = scenarioList.size();
                    int numPerRow = 5;
                    int numOfRows = sizeOfList / numPerRow;
                    int counter = 0;

                    for (int i = 0; i <= numOfRows; i++) {
                        // out.println(numOfRows);

                %>
                <tr>


                    <%                            Scenario scenario = null;
                        //out.println(counter + "counter");
                        for (int j = 0; j < numPerRow; j++) {

                    %>
                    <td>                    
                        <%        if (sizeOfList > counter) {
                                scenario = scenarioList.get(counter); //supposed to get Counter, but somehow arrayindexoutofbounds when i put counter.

                                scenarioID = scenario.getScenarioID();
                                counter++;
                                imgName = "img/0" + counter + ".jpg";

                        %>
                        <a href="#" data-reveal-id="<%=scenarioID%>">

                            <% if (scenario.getStatus().equals("activated")) {%>
                            <img class="opaque" src="<%=imgName%>" style="float:left; padding-right:5px;"/></a>           

                        <% } else {%>

                        <div id="color">
                            <div id="opacity">
                                <img class="opaque" src="<%=imgName%>" style="float:left; padding-right:5px;"/><a>
                            </div>
                        </div>

                        <%
                                }
                            }
                        %>
                    </td>
                    <%
                        }
                    %>


                    <%
                        }
                    %>

                </tr>
            </table>
        </div>

        <%            for (int i = 0; i < scenarioList.size(); i++) {
                Scenario scenario = scenarioList.get(i);
                String status = scenario.getStatus();
        %>

        <div id="<%=scenario.getScenarioID()%>" class="reveal-modal" data-reveal>

            <form action = "ProcessActivateScenario" method = "POST">   
                <h2>Case Information</h2> 
                <%
                    if (status.equals("activated")) {
                %>
                Case is currently activated. 
                <input type ="hidden" id= "status" name = "status" value = "deactivated">
                <input type ="submit" class="button tiny" value = "Deactivate Case">

                <% } else { %>

                Case is deactivated. 
                <input type ="hidden" id= "status" name = "status" value = "activated">               
                <input type ="submit" class="button tiny" value = "Activate Case">
                <%  }%>

                <p class="lead"><b>Case Number:</b> <%=scenario.getScenarioID()%> </p>
                <p class="lead"><b>Case Name:</b> <%=scenario.getScenarioName()%> </p>
                <p class="lead"><b>Case Description:</b> <%=scenario.getScenarioDescription()%> </p>
                <p class="lead"><b>Admission Info:</b> <%=scenario.getAdmissionInfo()%> </p>

                <input type ="hidden" id= "scenarioID" name = "scenarioID" value = "<%=scenario.getScenarioID()%>">


            </form>
            <a class="close-reveal-modal">&#215;</a>
        </div>

        <% }%>

        <script src="js/vendor/jquery.js"></script>
        <script src="js/foundation.min.js"></script>
        <script>
            $(document).foundation();
        </script> 
    </body>
</html>
