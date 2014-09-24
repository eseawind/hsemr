<%-- 
    Document   : topbar
    Created on : Sep 24, 2014, 04:50:54 PM
    Author     : Jocelyn
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    </head>
    <body>
        <nav class="top-bar" data-topbar>
            <ul class="title-area">
                <li class="name">
                    <h1><a href="#">HSEMR <img src="img/healthlablogo.jpg" height = "40"></a></h1>

                </li>
                <!-- Remove the class "menu-icon" to get rid of menu icon. Take out "Menu" to just have icon alone -->
                <li class="toggle-topbar menu-icon"><a href="#"><span>Menu</span></a></li>
            </ul>
                
            <% 
                String nurseId = (String)session.getAttribute("user");
            %>
            <secion class="top-bar-section">
                <!-- Right Nav Section -->

                 <ul class="left">
                    <li><a href="#">Patient Management</a></li>
                    <li><a href="#">Ward Management</a></li>
                    <li><a href="#">Medical Management</a></li>
                  </ul>
                
                <ul class="right"> 
                        <li><a href="#">Welcome, <%= nurseId%>!</a></li>
                    <li><a href="ProcessLogout">Log Out</a></li>
                </ul>
            </secion>
        </nav>

    </body>
</html>
