<%-- 
    Document   : topbar
    Created on : Sep 24, 2014, 04:50:54 PM
    Author     : Jocelyn
--%>

<%@page import="entity.PracticalGroup"%>
<%@page import="dao.PracticalGroupDAO"%>
<%@page import="entity.Scenario"%>
<%@page import="dao.ScenarioDAO"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <link rel="shortcut icon" href="img/DefaultLogo-favicon.ico">
        <link rel="stylesheet" href="css/foundation.css" />
        <script src="js/vendor/modernizr.js"></script>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">

        <!--FONT-->
        <link href='http://fonts.googleapis.com/css?family=Roboto:400,100,100italic,300,300italic,400italic,500,500italic,700,700italic,900,900italic' rel='stylesheet' type='text/css'>
        <link href='http://fonts.googleapis.com/css?family=Karma:400,300,500,600,700' rel='stylesheet' type='text/css'>

        <!--ICON-->
        <link rel="stylesheet" type="text/css" href="css/foundation-icons/foundation-icons.css">
        <link rel="stylesheet" type="text/css" href="css/foundation-icons/foundation-icons.svg">

    </head>
    <body>
        <div class="sticky">
            <nav class="top-bar" data-topbar data-options="sticky_on: large">
                <ul class="title-area">
                    <li class="name">
                        <h1><a href="viewPatientInformation.jsp"><img src="./img/DefaultLogo.png" width="30" height="30"/> EMR</a></h1>

                    </li>
                    <!-- Remove the class "menu-icon" to get rid of menu icon. Take out "Menu" to just have icon alone -->
                    <li class="toggle-topbar menu-icon"><a href="#"><span>Menu</span></a></li>
                </ul>

                <%
                    String nurseId = (String) session.getAttribute("nurse");
                %>
                <secion class="top-bar-section">
                    <!-- Right Nav Section -->

                    <ul class="left">
                        <li><a href="viewWardInformation.jsp">Ward Management</a></li>
                            <%
                                PracticalGroup pg = PracticalGroupDAO.retrieveLecturer(nurseId);
                                // Scenario scenarioActivated1 = ScenarioDAO.retrieveActivatedScenario();
                                if (pg.getLecturerID() == null) {
                                    response.sendRedirect("viewMainLogin.jsp");
                                } else {
                                    Scenario scenarioActivated1 = ScenarioDAO.retrieveScenarioActivatedByLecturer(pg.getLecturerID());
                                    if (scenarioActivated1 != null) {
                                        String scenarioName = scenarioActivated1.getScenarioName();
                                        String scenarioDescription = scenarioActivated1.getScenarioDescription();
                                %>
                            <li><a href="#"><span data-tooltip aria-haspopup="true" class="has-tip" title="<b>Scenario Name:</b> <%=scenarioName%><br><br>
                                                  <b>Scenario Description: </b> <%=scenarioDescription%>
                                                  ">Case Information</span></a></li>
                                    <% } else { %> 
                            <li><a href="#"><span data-tooltip aria-haspopup="true" class="has-tip" title="No activated case yet">Case Information</span></a></li>  
                                <%}
                                }%> 

                    </ul>

                    <ul class="right"> 
                        <li><a href="#">Welcome, <%= nurseId%>!</a></li>
                        <li><a href="ProcessLogoutNurse">Log Out</a></li>
                    </ul>
                </secion>
            </nav>
        </div>
        <script src="js/vendor/jquery.js"></script>
        <script src="js/foundation/foundation.js"></script>
        <script src="js/foundation/foundation.tooltip.js"></script> 

        <script>
            $(document).foundation();
        </script>
    </body>
</html>
