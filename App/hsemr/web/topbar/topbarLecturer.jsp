<%-- 
    Document   : topbarLecturer
    Created on : Oct 11, 2014, 10:45:54 PM
    Author     : weiyi.ngow.2012
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <link rel="shortcut icon" href="img/DefaultLogo-favicon.ico">
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">

        <!--FONT-->
        <link href='http://fonts.googleapis.com/css?family=Roboto:400,100,300,500,700,900' rel='stylesheet' type='text/css'>

        <!--ICON-->
        <link rel="stylesheet" type="text/css" href="css/foundation-icons/foundation-icons.css">
        <link rel="stylesheet" type="text/css" href="css/foundation-icons/foundation-icons.svg">

    </head>
    <body>
        <nav class="top-bar" data-topbar>
            <ul class="title-area">
                <li class="name">
                    <h1><a href="viewScenarioLecturer.jsp"><img src="./img/DefaultLogo.png" width="30" height="30"/> EMR</a></h1>

                </li>
                <!-- Remove the class "menu-icon" to get rid of menu icon. Take out "Menu" to just have icon alone -->
                <li class="toggle-topbar menu-icon"><a href="#"><span>Menu</span></a></li>
            </ul>

            <%
                String lecturerId = (String) session.getAttribute("lecturer");
            %>
            <secion class="top-bar-section">
                <!-- Right Nav Section -->

                <ul class="left">
                    <li class="has-dropdown">
                        <a href="#">Case Management</a>
                        <ul class="dropdown">
                            <li><a href="./viewScenarioLecturer.jsp">Activate Case</a></li>
                            <li><a href="./editStateLecturer.jsp">Activate State</a></li>
                        </ul>   
                    </li>
                    <li><a href="#">View Submissions</a></li>
                </ul>

                <ul class="right"> 
                    <li><a href="#">Welcome, <%= lecturerId%>!</a></li>
                    <li><a href="ProcessLogoutLecturer">Log Out</a></li>
                </ul>
            </secion>
        </nav>

    </body>
</html>
