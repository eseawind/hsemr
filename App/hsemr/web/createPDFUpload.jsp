<%-- 
    Document   : createPDFUpload
    Created on : Feb 11, 2015, 8:58:08 PM
    Author     : weiyi.ngow.2012
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <link rel="stylesheet" href="css/foundation.css" />
        <link rel="stylesheet" href="css/original.css" />
        <script type="text/javascript" src="js/humane.js"></script>
        <script src="js/vendor/modernizr.js"></script>
        <%@include file="/topbar/topbarAdmin.jsp" %>
        
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <body>
    <center>
        <h1>PDF Text Recognition Case Setup</h1>
        <br><br>
        <div class="large-centered large-2 columns">
        <center><form action = "createScenario.jsp" method = "POST" enctype = "multipart/form-data"> 
                
                
                    <input type ="file" name = "file" required /><br>
<!--                            <input type ="hidden" name ="scenarioID" value =""/>
<input type ="hidden" name ="editReport" value =""/>--><br>
                    <input type ="submit" class ="button tiny" value ="Upload Case">
                
            </form><br>   </center>
        </div>
    </center>
    </body>
</html>
