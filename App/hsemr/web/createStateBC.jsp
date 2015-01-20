<%-- 
    Document   : createStateBC
    Created on : Jan 20, 2015, 12:18:43 AM
    Author     : hpkhoo.2012
--%>
<%@page import="java.util.List"%>
<%@page import="java.util.ArrayList"%>
<%@page import="dao.*"%>
<%@page import="entity.*"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@include file="protectPage/protectAdmin.jsp" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link rel="stylesheet" href="css/foundation.css" />
        <link rel="stylesheet" href="responsive-tables.css">
        <link rel="stylesheet" href="css/original.css" />
        <script src="responsive-tables.js"></script>
        <%@include file="/topbar/topbarAdmin.jsp" %>

        <link rel="stylesheet" href="//code.jquery.com/ui/1.11.1/themes/smoothness/jquery-ui.css">
        <script src="//code.jquery.com/jquery-1.10.2.js"></script>
        <script src="//code.jquery.com/ui/1.11.1/jquery-ui.js"></script>
        <script type="text/javascript" src="js/humane.js"></script>
        <script type="text/javascript" src="js/app.js"></script>
        <link rel="stylesheet" href="/resources/demos/style.css">
        <title>Case Setup - State Creation</title>
    </head>
    <body>
        <br>
        <ul class="breadcrumbs">
            <li class="unavailable">Step 1: Case Creation</li>
            <li class="current">Step 2: State Creation</li>
            <li class="unavailable"><a href="#">Step 3: Medication Creation</a></li>
            <li class="unavailable"><a href="#">Step 4: Report and Document Creation</a></li>
        </ul>

        <%            String success = "";
            String error = "";



            String scenarioID = (String) session.getAttribute("scenarioID");
            String patientNRIC = (String) session.getAttribute("patientNRIC");

        %>

        

        <%List<State> stateList = StateDAO.retrieveAll(scenarioID);%>
        <center><h2>Step 2: Create State <%=stateList.size()%></h2>

        States are created in <b>ascending</b> order. <br><br>


        <form action = "ProcessAddState" method = "POST">
            <div class="row">
                <div class="small-8">
                    <div class="row">
                        <div class="small-3 columns">
                            <label for="right-label" class="right inline" >State Description</label>
                        </div>
                        <div class="small-9 columns">
                            <input type="text" name="stateDescription" value = "" required>
                        </div>
                    </div>
                </div>
            </div>
            <input type ="hidden" name ="scenarioID" value ="<%=scenarioID%>">
            <input type ="hidden" name ="patientNRIC" value ="<%=patientNRIC%>">
            
            <input type="submit" value="Create State" class="button tiny">
            <a href="createMedicationBC.jsp" class="button tiny">Proceed to Step 3</a> 
        </form>
   
            
       
        <!--Display states that are in the database-->
        <% if (stateList == null || stateList.size() - 1 == 0 || stateList.size() - 1 == -1) {
                out.println("<h3>" + "There are no states created yet." + "</h3>");

            } else {
                out.print("<h3>State(s) Created</h3>");
        %>

        <%for (State state : stateList) {
                String stateNumber = state.getStateID();
                String stateName = state.getStateDescription();
                if (!stateNumber.equals("ST0")) {

                    stateNumber.replace("ST", "State ");
                String stateDesc = stateNumber.replace("ST", "State ") + " - " + stateName;%>

        <a href="#" class="button casecreationbutton tiny"><%=stateDesc%></a>
        <%}
            
        }}%>
        <!--End of display states in the database-->

    </center>
    <script src="js/vendor/jquery.js"></script>
    <script src="js/foundation.min.js"></script>

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
    <script type="text/javascript" src="js/humane.js"></script>


</body>
</html>
