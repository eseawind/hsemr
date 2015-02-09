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
        <!--Breadcrumbs-->
        <ul class="breadcrumbs">
            <li class="unavailable">Step 1: Case Creation</li>
            <li class="current">Step 2: State Creation</li>
            <li class="unavailable"><a href="#">Step 3: Medication Creation</a></li>
            <li class="unavailable"><a href="#">Step 4: Report and Document Creation</a></li>
        </ul>

        <div class="large-centered large-6 columns">

            <%            String success = "";
                String error = "";

                String scenarioID = (String) session.getAttribute("scenarioID");
                String patientNRIC = (String) session.getAttribute("patientNRIC");

            %>

            <%List<State> stateList = StateDAO.retrieveAll(scenarioID);%>
            <h2>Create State <%=stateList.size()%></h2>

            States are created in <b>ascending</b> order. <br><br>


            <form action = "ProcessAddState" method = "POST">
                <div class="panelCase">
                    <div class="row">
                        <label>State Description</label>
                        <input type="text" name="stateDescription" value = "" required>
                        <label>Healthcare Provider's Order</label>
                        <textarea style = "resize:vertical"  name="doctorOrderForState" rows="5" cols="10" placeholder ="" required></textarea>
                    </div>

                    <input type ="hidden" name ="scenarioID" value ="<%=scenarioID%>">
                    <input type ="hidden" name ="patientNRIC" value ="<%=patientNRIC%>">
                </div>
                <center><input type="submit" value="Create State" class="button small"></center>
            </form>


            <div class="panelCase">
                <!--Display states that are in the database-->
                <% if (stateList == null || stateList.size() - 1 == 0 || stateList.size() - 1 == -1) {
                        out.println("<center>" + "There are no states created yet." + "</center>");

                    } else {
                        out.print("<center><h3>State(s) Created</h3></center>");
                %>

                <%for (State state : stateList) {
                        String stateNumber = state.getStateID();
                        String stateName = state.getStateDescription();
                        if (!stateNumber.equals("ST0")) {

                            stateNumber.replace("ST", "State ");
                            String stateDesc = stateNumber.replace("ST", "State ") + " - " + stateName;%>

                <a href="#" class="button casecreationbutton tiny"><%=stateDesc%></a>
                <%}

                        }
                    }%>
            </div>
            <!--End of display states in the database-->
            <center><a href="createMedicationBC.jsp" class="button small">Proceed to Step 3  >></a></center>
        </div>
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
