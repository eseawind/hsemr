<%-- 
    Document   : viewWardInformation
    Created on : Jan 4, 2015, 1:08:02 AM
    Author     : gladyskhong.2012
--%>

<%@page import="java.util.LinkedHashMap"%>
<%@page import="java.util.Map"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.util.HashMap"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.text.DateFormat"%>
<%@page import="entity.*"%>
<%@page import="java.util.List"%>
<%@page import="dao.*"%>
<%@include file="protectPage/protectNurse.jsp" %>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"> 
        
        <!--For pull to refresh-->
        <script src="http://code.jquery.com/jquery-latest.js" type="text/javascript"></script>
        <script src="js/hook.js" type="text/javascript"></script>
        <link rel="stylesheet" href="css/hook.css" type="text/css" />
        <!--end of for pull to refresh-->
        
        <!--Web Title-->
        <title>EMR | Ward Management | Ward View</title>
        
        <link rel="shortcut icon" href="img/DefaultLogo-favicon.ico">
        <meta name="viewport" content="width=device-width, initial-scale=1.0" />
        <link rel="stylesheet" href="css/foundation.css" />
        <link rel="stylesheet" href="css/original.css" />
        <script src="js/vendor/modernizr.js"></script>
        <%@include file="/topbar/topbar.jsp" %> 
        <style type="text/css">
            tbody tr:nth-child(even)
            {
                background: white;
            }
        </style>
    </head>
    <body>  
    <center>
        <!--RESPONSIVE. START OF iTOUCH VERSION HERE-->
        <div class ="show-for-small-only">
             <!--hook.js pull to refresh-->                                      
            <div id="hook">
                <div id="loader">
                    <div class="spinner"></div>
                </div>
                    <span id="hook-text">Reloading, please wait...</span>
            </div>
            <!--hook.js pull to refresh-->
            <%
                
               
                if (pg == null || pg.getLecturerID() == null) {
                     out.println("<h5>Please login <a href='viewMainLogin.jsp'><u>here</u></a></h5>");
                } else {
                    Scenario scenarioActivated1 = ScenarioDAO.retrieveScenarioActivatedByLecturer(pg.getLecturerID());
                
                    StateHistory retrieveScenarioState= null;
                    if (scenarioActivated1 == null) {
                        out.println("<h1>No Case Activated</h1>");
                        out.println("Please contact lecturer/administrator.");
                    } else {
                        //get the most recently activated scenario's state

                      retrieveScenarioState= StateHistoryDAO.retrieveLatestStateActivatedByLecturer(pg.getLecturerID());

                        if (retrieveScenarioState == null) {
                             out.println("<center><h1>No Case/States Activated</h1><br>Please contact administrator/lecturer for case activation.</center>");
                        } else { 
                            List<Scenario> scenarioList = ScenarioDAO.retrieveAndSortByBedNum();

                            int sizeOfList = scenarioList.size();
                            int numPerRow = 5;
                            int numOfRows = (sizeOfList / numPerRow);
                            int counter = 1;
                            int counterScenario = 0;
                            int bedCounter = 1;

                %>

                        <form action ='viewPatientInformation.jsp' method ='POST'>
                       
                            <input type="submit" value="View Patient Management" class="button large"> 
                        </form>
                
                
                <% 
                    Scenario scenarioActivated = ScenarioDAO.retrieveScenarioActivatedByLecturer(pg.getLecturerID());
                       
                  //Scenario scenarioActivated = ScenarioDAO.retrieveActivatedScenario();
        if (scenarioActivated != null) {%>
        
        <dl class="accordion" data-accordion>
            <dd class="accordion-navigation">
                <a href="#panelCaseName">Case Information</a>
                <div id="panelCaseName" class="content active">
                    <%=scenarioActivated.getScenarioName()%>
                </div>
            </dd>
            
            <dd class="accordion-navigation">
                <a href="#panelCaseName">Case Information</a>
                <div id="panelCaseName" class="content active">
                    <%=scenarioActivated.getScenarioDescription()%>
                </div>
            </dd>
            
        </dl>
                
        <%
                }
            }
        }
                
        %>
      
        <!--RESPONSIVE. END OF iTOUCH VERSION HERE-->
        </div>
        
        <div class ="hide-for-small-only">
            <div class="row" style="padding-top: 60px;">
                <div class="large-12 columns" style="padding-top: 20px;">

                    <table style ="border-spacing:20px; border:none">
                        <tr>
                           
                             <%
                               Scenario scenario =  ScenarioDAO.retrieveScenarioActivatedByLecturer(pg.getLecturerID());
                               // Scenario scenario = ScenarioDAO.retrieveActivatedScenario();

                               // if (scenario == null || StateDAO.retrieveActivateState(scenario.getScenarioID()) == null) {
                               if (scenario == null || retrieveScenarioState == null) {
                                    out.println("<center><h1>No Case/States Activated</h1><br>Please contact administrator/lecturer for case activation.</center>");
                                } else {%>
                        <h1>Please select a ward:</h1>
                        <%
                            //String[] wards = {"Ward A", "Ward B", "Ward C"};
                            String[] wardList = new String[]{"Simulation Lab 1", "Simulation Lab 2", "Simulation Lab 3", "Simulation Lab 4"};
                            //String[] wardList = 
                            for (String ward : wardList) {
                                if (ward.equals("Simulation Lab 1")) {%>
                        <td> <form method="POST" action="viewWard1.jsp"><input type="submit"  class="ward" value="Ward 1"/></form></td>
                                <%} else if (ward.equals("Simulation Lab 2")) {%>
                        <td> <form method="POST" action="viewWard2.jsp"><input type="submit"  class="ward" value="Ward 2"/></form></td>
                                <%} else if (ward.equals("Simulation Lab 3")) {%>
                        <td> <form method="POST" action="viewWard3.jsp"><input type="submit"  class="ward" value="Ward 3"/></form></td>
                                <%} else {%>
                        <td> <form method="POST" action="viewWard4.jsp"><input type="submit"  class="ward" value="Ward 4"/></form></td>
                                <%}%>

                        <%}

                        %>
                        </tr>
                    </table>

                    <%}
                }%>


                </div>
            </div>
        </div>
        <!--RESPONSIVE. END OF WEB VERSION HERE-->        

   

    </center>
</body>
</html>
