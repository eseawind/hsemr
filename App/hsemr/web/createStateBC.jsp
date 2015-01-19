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
        <title>Case Setup of State</title>
    </head>
    <body>
         <script src="js/vendor/jquery.js"></script>
        <script src="js/foundation.min.js"></script>
        <center><h1>State Creation</h1></center>
        
         <br>
        <b>Step 1: Case creation > <a href="createStateBC.jsp">Step 2: State creation</a> </b> > Step 3: Medication creation > Step 4: Report and Document creation
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

            String scenarioID = (String) session.getAttribute("scenarioID");
            String patientNRIC = (String) session.getAttribute("patientNRIC");

        %>
        
         <!--Display states that are in the database-->
         <br>
        <%                out.println("");
            List<State> stateList = StateDAO.retrieveAll(scenarioID);

            if (stateList == null || stateList.size()-1 == 0 || stateList.size()-1 == -1) {
                out.println("<h3>"+ "There are no states created yet." + "</h3>");
                
            } else {
                int sizeOfStates = stateList.size()-1;
                out.print("<h4><b>No. of State added <i>(Excluding State 0) </i></b>: " + sizeOfStates + "</h4>");
                %>
                <table>
                    <tr>
                        <td><b>State</b></td>
                        <td><b>Name</b></td>
                    </tr>
                    <% for (State state: stateList) {
                       String stateNumber = state.getStateID(); 
                       String stateName = state.getStateDescription();
                       if(!stateNumber.equals("ST0")) {
                    %>
                    <tr>
                        <td><%=stateNumber.replace("ST", "STATE ")%></td>
                        <td><%=stateName%></td>
                    </tr>
                    <%   }
                    
                    
                    }
                %>
                </table>
                <%
            }

        %>
        
         <h2>Step 2: Create State <%=stateList.size()%></h2>
            States are created in <b>ascending</b> order. <br><br>

            <form action = "ProcessAddState" method = "POST"> 
                <%
                    int counter=0; 
                    String counterStr= (String) request.getAttribute("counter");
                    
                    if(counterStr==null){
                        counter=0;
                    }else{                 
                         counter = Integer.parseInt(counterStr);
                    }
                %>
                State Description 
                <div><textarea name="stateDescription" id="notes" rows="7" cols="10" required></textarea>

                <input type ="hidden" name ="scenarioID" value ="<%=scenarioID%>">
                <input type ="hidden" name ="patientNRIC" value ="<%=patientNRIC%>">
                <input type ="hidden" name ="counter" value ="<%=counter%>">
                
               <% if(counter == 0) {%>
                    <input type ="submit" class ="button" value ="Create State">
              <%  }else{ %>
                    <input type ="submit" class ="button" value ="Create State">
              </form>
                    <form action="createMedicationBC.jsp" method="POST">
                    <input type ="submit" class ="button" value ="Proceed to Step 3">
                    </form>
              <%  } %>
             
              
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
