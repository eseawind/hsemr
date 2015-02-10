<%-- 
    Document   : viewWardInformation
    Created on : Jan 4, 2015, 1:08:02 AM
    Author     : gladyskhong.2012
--%>

<%@include file="protectPage/protectNurse.jsp" %>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
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
        <title>View Ward Information</title>

    </head>
    <body>  
    <center>
        <div class="row" style="padding-top: 60px;">
            <div class="large-12 columns" style="padding-top: 20px;">

                <table style ="border-spacing:20px; border:none">
                    <tr>
                        <%
                            Scenario scenario = ScenarioDAO.retrieveActivatedScenario();

                            if (scenario == null) {
                                out.println("<h1>No Case Activated</h1>");
                                out.println("Please contact lecturer/ administrator.");
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

                <%}%>


            </div>
        </div>
    </center>
</body>
</html>
