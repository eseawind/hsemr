<%-- 
    Document   : editState
    Created on : Jan 30, 2015, 9:26:39 PM
    Author     : gladyskhong.2012
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
            <li><a href="editScenario.jsp">Edit Case Information</a></li>
            <li>Edit State Information</li>
            <li><a href="editMedication.jsp">Edit Medication </a></li>
            <li><a href="editReportDocument.jsp">Edit Report and Document </a></li>
        </ul><br/>

        <%            
            String success = "";
            String error = "";

            String scenarioID = (String) session.getAttribute("scenarioID");
            String patientNRIC = (String) session.getAttribute("patientNRIC");
            String editingInProcess = "editingInProcess";
        %>



        <%List<State> stateList = StateDAO.retrieveAll(scenarioID);%>
    <center><h2>Create State <%=stateList.size()%></h2>




        <form action = "ProcessAddState" method = "POST">
            <input type ="hidden" name ="scenarioID" value ="<%=scenarioID%>">
            <input type ="hidden" name ="patientNRIC" value ="<%=patientNRIC%>">
            <input type ="hidden" name ="editState" value ="<%=editingInProcess%>">
            
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
            

            <br/><br/>
            <input type="submit" value="Create State" class="button tiny">
        </form>



        <!--Display states that are in the database-->
        <% if (stateList == null || stateList.size() - 1 == 0 || stateList.size() - 1 == -1) {
                out.println("<h3>" + "There are no states created yet." + "</h3>");

            } else {
                out.print("<h3>Edit States</h3>");
        %>
            <form action ="ProcessEditState" method="POST">
        <%
                List<String> stList = new ArrayList<String>();
                String stateDescription ="";
                int counter =0;
                for (State state : stateList) {
                String stateNumber = state.getStateID();
                stateDescription = state.getStateDescription();
                if (!stateNumber.equals("ST0")) {
                    int number = Integer.parseInt(stateNumber.replace("ST",""));
                    stateNumber.replace("ST", "State ");
                    String stateDescriptionNumber = "statedescription" + counter;
                    session.setAttribute("dNum",stateDescriptionNumber);
                    String stateDesc = stateNumber.replace("ST", "State ");%>
        <div class="row">
            <div class="small-8">
                <div class="row">
                    <div align="left">  <b><%=stateDesc%></b></div><br/>
                    <input type="hidden" name ="stateNumber" value="<%=stateNumber%>">
                    <input type="hidden" name ="stateListSize" value="<%=stateList.size()%>">
                    <input type ="text" name ="<%=stateDescriptionNumber%>" value ="<%=stateDescription%>">
            <input type ="hidden" name ="scenarioID" value ="<%=scenarioID%>">
                </div>
            </div>

        </div>
        <% }
                //stateName = state.getStateDescription();
                counter++;
                
                }
                
                //session.setAttribute("stateListSize", counter);
               // session.setAttribute("stList", stList);
                //stList = request.getAttribute("stList");
            }%>
        <!--End of display states in the database-->
        <input type = "submit" Value ="Save and Proceed" class="button tiny">
            </form>
    </center>
    <script src="js/vendor/jquery.js"></script>
    <script src="js/foundation.min.js"></script>

    <script>

        $(document).ready(function () {
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
