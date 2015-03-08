<%-- 
    Document   : viewScenarioLecturer
    Created on : Oct 9, 2014, 8:41:17 AM
    Author     : gladyskhong.2012
--%>
<%@page import="entity.*"%>
<%@page import="dao.*"%>
<%@page import="java.util.List"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@include file="protectPage/protectLecturer.jsp" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <!--Web Title-->
        <title>EMR | Case Management | Manage Case | Activate Case</title>

        <!-- LECTURER TOP BAR-->
        <%@include file="/topbar/topbarLecturer.jsp" %>
        <link rel="stylesheet" href="css/foundation.css" />
        <link rel="stylesheet" href="css/original.css" />
        <script type="text/javascript" src="js/humane.js"></script>
        <script src="js/vendor/modernizr.js"></script>
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
        <script>

            $(document).ready(function() {
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
        <div class="row" style="padding-top: 30px;">
            <div class="large-centered large-12 columns">
                <center>
                    <h1>Select case to view details</h1>
                    <%  //Retrieve all the successful messages 
                        String success = "";
                        if (session.getAttribute("success") != null) {
                            success = (String) session.getAttribute("success");
                            session.setAttribute("success", "");
                        }
                        String error = "";
                        if (session.getAttribute("error") != null) {
                            error = (String) session.getAttribute("error");
                            session.setAttribute("error", "");
                        }

                        int caseNo = 0;
                        String scenarioID = "";

                        List<Scenario> scenarioList = ScenarioDAO.retrieveAndSortByBedNum();
                        List<String> activatedScenarioList = LecturerScenarioDAO.retrieveScenarioActivated();

                        for (int i = 0; i < scenarioList.size(); i++) {
                            Scenario scenario = scenarioList.get(i);
                    %>

                    <!-- <span class="label"> scenario.getScenarioStatus()%></span> -->
                    <%
                        }
                    %>
                    <!--Legend-->
                    <table style="border-color: white; width: 420px">
                        <col width ="10%">
                        <col width ="40%">
                        <col width ="60%">
                        <tr>
                            <td>Legend:</td>
                            <td><legend></legend>  Activated Case</td>
                            <td><legend style="background-color: #DBDBDB"></legend>  Deactivated Case</td>
                        <tr/>
                    </table>
                    <br/>
                    
                    <table style="margin-bottom: 5rem">
                        <%
                            int sizeOfList = scenarioList.size();
                            int numPerRow = 5;
                            int numOfRows = sizeOfList / numPerRow;
                            int counter = 0;

                            for (int i = 0; i <= numOfRows; i++) {

                        %>

                        <col width ="20%">
                        <col width ="20%">
                        <col width ="20%">
                        <col width ="20%">
                        <col width ="20%">
                        <tr valign="top">
                            <%                        Scenario scenario = null;

                                for (int j = 0; j < numPerRow; j++) {

                            %>
                            <%        if (sizeOfList > counter) {
                                    scenario = scenarioList.get(counter);

                                    scenarioID = scenario.getScenarioID();

                                    LecturerScenario lecScenario = LecturerScenarioDAO.retrieve(lecturerId, scenarioID);
                                    counter++;
                                    caseNo = counter;
                            %>
                            <td><center><a href="#" data-reveal-id="<%=scenarioID%>">

                                <% if (lecScenario != null) { //activated, hence able to find in lectuereScenario table%> 

                                <input type="submit" class="case" value="<%=counter%>"><br/>

                                <% } else {%>
                                <input type="submit" class="case off" value="<%=counter%>"><br/>

                                <%
                                    }
                                %><font color="black"><%=scenario.getScenarioName()%></font></a></center></td>
                                <%
                                    }
                                %>
                                <%
                                    }
                                %>

                        </tr>
                        <%
                            }
                        %> </table> 
                </center>
            </div>    
        </div>

        <%            for (int i = 0; i < scenarioList.size(); i++) {
                Scenario scenario = scenarioList.get(i);

        %>

        <div id="<%=scenario.getScenarioID()%>" class="reveal-modal" data-reveal>

            <form action = "ProcessActivateScenario" method = "POST">   
                <h2>Case Information</h2> 
                <%
                    LecturerScenario lecScenario = LecturerScenarioDAO.retrieve(lecturerId, scenario.getScenarioID());

                    if (lecScenario != null) { //it is activated
                %>
                Case is currently activated. 
                <input type ="hidden" id= "status" name = "status" value = "deactivated">
                <input type ="submit" class="button tiny" value = "Deactivate Case">

                <% } else { %>

                Case is deactivated. 
                <input type ="hidden" id= "status" name = "status" value = "activated">               
                <%

                    //Scenario activatedScenario = ScenarioDAO.retrieveActivatedScenario();
                    Scenario activatedScenario = ScenarioDAO.retrieveScenarioActivatedByLecturer(lecturerId);
                    if (activatedScenario != null) { %>
                <input type ="submit" class="button tiny" onclick="if (!activateConfirmation())
                            return false" value="Activate Case" >
                <%} else { %>
                <input type ="submit" class="button tiny" onclick="if (!activateConfirmation())
                            return false" value="Activate Case" >
                <% }
            }%>

                <p class="lead"><b>Case Number:</b> <%=scenario.getScenarioID()%> </p>
                <p class="lead"><b>Case Name:</b> <%=scenario.getScenarioName()%> </p>
                <p class="lead"><b>Case Description:</b> <%=scenario.getScenarioDescription()%> </p>
                <p class="lead"><b>Admission Info:</b> <%=scenario.getAdmissionNote()%> </p>

                <input type ="hidden" id= "scenarioID" name = "scenarioID" value = "<%=scenario.getScenarioID()%>">


            </form>
            <a class="close-reveal-modal">&#215;</a>
        </div>

        <% }%>

        <script src="js/vendor/jquery.js"></script>
        <script src="js/foundation.min.js"></script>
        <script>
        $(document).ready(function() {
              $(document).foundation();
              var humaneSuccess = humane.create({baseCls: 'humane-original', addnCls: 'humane-original-success', timeout: 8000, clickToClose: true})
              var humaneError = humane.create({baseCls: 'humane-original', addnCls: 'humane-original-error', timeout: 8000, clickToClose: true})

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
