<%-- 
    Document   : viewWard2
    Created on : Jan 4, 2015, 1:10:26 AM
    Author     : gladyskhong.2012
--%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.util.List"%>
<%@page import="entity.*"%>
<%@page import="dao.*"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Ward 2</title>

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
        <div class="row" style="padding-top: 60px;">

            <h1>Please select a bed in <font style="font-weight:300">Ward 2</font>:</h1>

            <div class="large-12 columns" style="padding-top: 20px;"> 
                <table style ="border-spacing:5px; border:none">    
                    <%
                        List<Scenario> scenarioList = ScenarioDAO.retrieveAndSortByBedNum();

                        int sizeOfList = scenarioList.size();
                        int numPerRow = 5;
                        int numOfRows = (sizeOfList / numPerRow);
                        int counter = 1;
                        int counterScenario = 0;
                        int bedCounter = 1;
                        Scenario scen = ScenarioDAO.retrieveActivatedScenario();
                        String scID = "";
                        if (scen == null) {
                            out.println("No scenario activated, please contact lecturer/ administrator");
                        } else {
                            scID = scen.getScenarioID();
                        }

                    %>
                    <tr>
                        <%                    for (int row = 0; row <= numOfRows; row++) {
                        %>

                        <%
                            for (int col = 1; col <= numPerRow; col++) {
                                if (sizeOfList >= counter) {
                                    Scenario retrievedScenario = scenarioList.get(counterScenario);
                                    int bedNumber = retrievedScenario.getBedNumber();

                                    String scNum = "SC" + bedNumber;
                                    if (scNum.equals(scID)) {
                        %>
                        <td> <form method="POST" action="viewCaseInformation.jsp"><input type="submit"  class="bedactive" value="<%="Bed " + bedCounter%>"/></form></td>
                                <%
                                } else {
                                %>
                        <td> <form method="POST" action="#"><input type="submit"  class="bed" value="<%="Bed " + bedCounter%>" disabled></form></td>
                                <%
                                            }
                                            counterScenario++;
                                            counter++;
                                            bedCounter++;
                                        }
                                    }
                                %> 
                    </tr>
                    <%
                        }
                    %>

                </table>
                <form>
                    <br/>
                    <input type="button" value="Back to Ward Overview" class="button" onClick="window.location = 'viewWardInformation.jsp'"/>
                </form>
            </div>
        </div>
    </center>
</body>
</html>
