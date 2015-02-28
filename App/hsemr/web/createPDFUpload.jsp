<%-- 
    Document   : createPDFUpload
    Created on : Feb 11, 2015, 8:58:08 PM
    Author     : weiyi.ngow.2012
--%>

<%@page import="entity.Scenario"%>
<%@page import="dao.ScenarioDAO"%>
<%@page import="java.util.List"%>
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
        <center><form action = "ProcessPDFCreation" method = "POST" enctype = "multipart/form-data"> 
                <%
                    
                    String success = "";
                    String error = "";

                    if (session.getAttribute("success") != null) {

                        success = (String) session.getAttribute("success");
                        session.setAttribute("success", "");
                    }

                    if (session.getAttribute("error") != null) {

                        error = (String) session.getAttribute("error");
                        session.setAttribute("error", "");
                    }
                    
                    if (session.getAttribute("s") != null) {

                        String s = (String) session.getAttribute("s");
                        session.setAttribute("s", "");
                    }
                    
                    List<Scenario> scenarioList = ScenarioDAO.retrieveAll();
                    int max = scenarioList.size() - 1; 
                    Scenario lastScenario = scenarioList.get(max);
                    int nextScenarioID = lastScenario.getBedNumber() + 1; 
                    String nextScenarioIDStr = "SC" + nextScenarioID;  
                    
                %>
                
                    <input type ="file" name = "file" required /><br>
                    <input type ="hidden" name ="scenarioID" value ="<%=nextScenarioIDStr%>"/>
                    <input type ="submit" class ="button tiny" value ="Upload Case">
                
            </form><br>   </center>
        </div>
    </center>
        <script>

        $(document).ready(function() {
            $(document).foundation();
            var humaneSuccess = humane.create({baseCls: 'humane-original', addnCls: 'humane-original-success', timeout: 8000, clickToClose: true})
            var humaneError = humane.create({baseCls: 'humane-original', addnCls: 'humane-original-error', timeout: 8000, clickToClose: true})

            var success1 = "<%=success%>";
            var error1 = "<%=error%>";
            if (success1 !== "") {
                humaneSuccess.log(success1);
            } else if (error1 !== "") {
                humaneError.log(error1);
            }

        });
    </script>
    </body>
</html>
