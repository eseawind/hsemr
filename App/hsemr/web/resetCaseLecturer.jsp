<%-- 
    Document   : resetCaseLecturer
    Created on : Jan 16, 2015, 9:49:55 PM
    Author     : jocelyn.ng.2012
--%>
<%@page import="dao.StateDAO"%>
<%@page import="entity.Scenario"%>
<%@page import="dao.ScenarioDAO"%>
<%@page import="entity.Vital"%>
<%@page import="dao.VitalDAO"%>
<%@page import="dao.ReportDAO"%>
<%@page import="java.util.List"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@include file="protectPage/protectLecturer.jsp" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <!--Web Title-->
        <title>EMR | Case Management | Manage Case | Reset Case</title>

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
                    <h1>Select case to reset</h1>
                    <br/>
                    <%  //Retrieve all the successful messages 
                        String success = "";
                        if (session.getAttribute("success") != null) {
                            success = (String) session.getAttribute("success");
                            session.setAttribute("success", "");
                        }

                        int caseNo = 0;
                        String scenarioID = "";

                        List<Scenario> scenarioList = ScenarioDAO.retrieveAndSortByBedNum();

                        for (int i = 0; i < scenarioList.size(); i++) {
                            Scenario scenario = scenarioList.get(i);
                    %>

                    &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                    <!-- <span class="label"> scenario.getScenarioStatus()%></span> -->
                    &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                    <%
                        }
                    %>
                    <table border="0">
                        <div class ="large-centered large-10 columns">

                            <%
                                int sizeOfList = scenarioList.size();
                                int numPerRow = 5;
                                int numOfRows = sizeOfList / numPerRow;
                                int counter = 0;

                                for (int i = 0; i <= numOfRows; i++) {
                                    // out.println(numOfRows);
                            %>

                            <col width ="20%">
                            <col width ="20%">
                            <col width ="20%">
                            <col width ="20%">
                            <col width ="20%">
                            <tr valign="top">
                                <%                            Scenario scenario = null;
                                    //out.println(counter + "counter");
                                    for (int j = 0; j < numPerRow; j++) {

                                %>
                                <%        if (sizeOfList > counter) {
                                        scenario = scenarioList.get(counter); //supposed to get Counter, but somehow arrayindexoutofbounds when i put counter.

                                        scenarioID = scenario.getScenarioID();
                                        counter++;
                                        caseNo = counter;
                                %>
                                <td><center><a href="#" data-reveal-id="<%=scenarioID%>">

                                    <% if (scenario.getScenarioStatus() == 1) {%>

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
                        </div>
                        </tr>
                        <%
                            }
                        %> </table>
                </center>
            </div>    
        </div>

        <%
            for (int i = 0; i < scenarioList.size(); i++) {
                Scenario scenario = scenarioList.get(i);
        %>

        <div id="<%=scenario.getScenarioID()%>" class="reveal-modal" data-reveal>

            <form action = "ProcessResetScenario" method = "POST">   
                <h2>Case Information</h2> 

                <input type ="hidden" id= "status" name = "status" value = "reset">
                <input type ="hidden" id= "scenarioID" name = "scenarioID" value = "<%=scenario.getScenarioID()%>">
                <input type ="submit" class="button tiny" value = "Reset Case">

                <p class="lead"><b>Case Number:</b> <%=scenario.getScenarioID()%> </p>
                <p class="lead"><b>Case Name:</b> <%=scenario.getScenarioName()%> </p>
                <p class="lead"><b>Case Description:</b> <%=scenario.getScenarioDescription()%> </p>
                <p class="lead"><b>Admission Info:</b> <%=scenario.getAdmissionNote()%> </p>




            </form>
            <a class="close-reveal-modal">&#215;</a>
        </div>

        <% }%>

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
        <script type="text/javascript" src="js/humane.js"></script>
    </body>
</html>
