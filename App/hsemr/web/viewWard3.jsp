<%-- 
    Document   : viewWard3
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
        <title>Ward 3</title>

        <link rel="shortcut icon" href="img/DefaultLogo-favicon.ico">
        <meta name="viewport" content="width=device-width, initial-scale=1.0" />
        <link rel="stylesheet" href="css/foundation.css" />
        <link rel="stylesheet" href="css/original.css" />
        <script src="js/vendor/modernizr.js"></script>
        <%@include file="/topbar/topbar.jsp" %> 

    </head>
    <body>
    <center>
        <h2>Beds in Ward 3</h2>
        <table style ="border-spacing:80px 10px">
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
                <td height = "200" width ="150" bgcolor = "92d400"> <font size="3"><b> <a href="viewCaseInformation.jsp"><center><%="Bed " + bedCounter%></center></a></b> </td>
                                <%
                                } else {
                                %>
                <td height = "200" width ="150" bgcolor = "92d400"> <font size="3"><b> <center><%="Bed " + bedCounter%></center></b> </td>
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
            <br/><br/><br/>
            <input type="button" value="Back to Ward Overview" class="button tiny" onClick="window.location = 'viewWardInformation.jsp'"/>
        </form>
    </center>
</body>
</html>
