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
        
        <title>View Ward Information</title>
        
    </head>
    <body>
        <center>
        <h1>Please select a ward</h1>


        <table style ="border-spacing:80px 10px"><tr>
                <%

                    //String[] wards = {"Ward A", "Ward B", "Ward C"};
                    String[] wardList = new String[]{"Simulation Lab 1", "Simulation Lab 2", "Simulation Lab 3", "Simulation Lab 4"};
                    //String[] wardList = 
                    for (String ward : wardList) {
                        if (ward.equals("Simulation Lab 1")) {%>
                        <td height = "200" width ="150" bgcolor = WhiteSmoke> <b><center><a href="viewWard1.jsp"><h4>Ward 1</h4></a></center></b><br></td>
                    <%} else if (ward.equals("Simulation Lab 2")) {%>
                        <td height = "200" width ="150" bgcolor = WhiteSmoke> <b><center><a href="viewWard2.jsp"><h4>Ward 2 </h4></a></center></b><br></td>
                    <%} else if (ward.equals("Simulation Lab 3")){%>
                        <td height = "200" width ="150" bgcolor = WhiteSmoke> <b><center><a href="viewWard3.jsp"><h4>Ward 3</h4></a></center></b><br></td>
                    <%} else {%>
                        <td height = "200" width ="150" bgcolor = WhiteSmoke> <b><center><a href="viewWard4.jsp"><h4>Ward 4 </h4></a></center></b><br></td>
                    <%}%>

                <%}


                %>
            </tr></table>
    </center>
    </body>
</html>
