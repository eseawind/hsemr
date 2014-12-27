<%-- 
    Document   : editState
    Created on : Dec 16, 2014, 1:13:02 AM
    Author     : jocelyn.ng.2012
--%>

<%@page import="entity.*"%>
<%@page import="dao.*"%>
<%@page import="java.util.List"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@include file="protectPage/protectLecturer.jsp" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>NP Health Sciences | View Scenario</title>
         <!-- LECTURER TOP BAR-->
        <%@include file="/topbar/topbarLecturer.jsp" %>
        <link rel="stylesheet" href="css/foundation.css" />
        <link rel="stylesheet" href="css/original.css" />
        <script type="text/javascript" src="js/humane.js"></script>
        <script src="js/vendor/modernizr.js"></script>
        <script type="text/javascript">
            function activateConfirmation() {
                var activateButton = confirm("Only one case can be activate each round. Activating this case will deactivate the rest.")
                if (activateButton) {
                    return true;
                }
                else {
                    return false;
                }
            }
        </script>
        <script>
            
            $(document).ready(function () {
                $(document).foundation();
            });
        </script>
        <style>
            #color {
                background-color: grey;
                float: left;
            }#opacity    {
                opacity : 0.4;
                filter: alpha(opacity=40); 
            }
        </style>

    </head>
    <body>
        <div class="row" style="padding-top: 30px;">
            <div class="large-centered large-12 columns">
                <center>
                    
                    <%
                    Scenario activatedScenario = ScenarioDAO.retrieveActivatedScenario();
                    %>
                    <h1>Select state to change the state</h1>
                    
                   <% if(activatedScenario == null){%>
                        <h2>No case is activated at the moment. Please activate a case <a href="./viewScenarioLecturer.jsp">here</a> first.</h2>
                        
                   <% }else{%>
                        <h2>Currently activated case: <%=activatedScenario.getScenarioName()%></h2>
                    
                    
          <br/>
            <%  //Retrieve all the successful messages 
            
            String success = "" ; 
            if (session.getAttribute("success") != null) {
                success = (String) session.getAttribute("success");
                session.setAttribute("success", "");
            }
            
                int caseNo = 0;
                String scenarioID = "";
                String stateID = "";
                
                List<State> stateList = StateDAO.retrieveAll(activatedScenario.getScenarioID());
                List<Scenario> scenarioList = ScenarioDAO.retrieveAll();

                for (int i = 0; i < stateList.size(); i++) {
                    State state = stateList.get(i);
            %>
            
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
            <%
                }
            %>
            <table border="0">
            <div class ="large-centered large-10 columns">
                     
                <%
                    int sizeOfList = stateList.size();
                    int numPerRow = 5;
                    int numOfRows = sizeOfList / numPerRow;
                    int counter = 0;

                    for (int i = 0; i <= numOfRows; i++) {
                        // out.println(numOfRows);
                    %>
                    
                    <col width ="20%">
                    <col width ="20%">
                    <col width ="20%">
                    <col width ="20%">
                    <col width ="20%">
                <tr valign="top">
                    <%                            
                        State state = null;
                        //out.println(counter + "counter");
                        for (int j = 0; j < numPerRow; j++) {

                    %>
                        <%        if (sizeOfList > counter) {
                                state = stateList.get(counter); //supposed to get Counter, but somehow arrayindexoutofbounds when i put counter.

                                stateID = state.getStateID();
                               
                                caseNo = counter; 
                                
                        %>
                 <td><center><a href="#" data-reveal-id="<%=stateID%>">
                 
                        <% if (state.getStateStatus() == 1) {%>
                        
                            <input type="submit" class="case" value="<%=counter%>"><br/>
                            
                        <% } else {%>
                       <input type="submit" class="case off" value="<%=counter%>"><br/>

                        <%
                                }
                        %><font color="black"><%=state.getStateDescription()%></font></a></center></td>
                        <%
                            }
                        counter++;
                        %>
                    <%
                        }
                    %>
            </div>
            </tr>
                    <%
                        }
                    %> </table>
</center>
           </div>    
        </div>

        <%            for (int i = 0; i < stateList.size(); i++) {
                State state = stateList.get(i);
                int status = state.getStateStatus();
        %>

        <div id="<%=state.getStateID()%>" class="reveal-modal" data-reveal>

            <form action = "ProcessActivateState" method = "POST">   
                <h2>State Information</h2> 
                <%
                    if (status == 1) {
                %>
                State is currently activated. 
                <input type ="hidden" id= "status" name = "status" value = "deactivated">
                <input type ="submit" class="button tiny" value = "Deactivate State">

                <% } else { %>

                State is deactivated. 
                <input type ="hidden" id= "status" name = "status" value = "activated">               
               <% 
                    if (activatedScenario != null) { %>
                   <input type ="submit" class="button tiny" onclick="if (!activateConfirmation())
                                       return false" value="Activate State" >
                   <%} else { %>
                       <input type ="submit" class="button tiny" value="Activate State">
                   <% }
                  }%>

                <p class="lead"><b>Case Number:</b> <%=activatedScenario.getScenarioID()%> </p>
                <p class="lead"><b>Case Name:</b> <%=activatedScenario.getScenarioName()%> </p>
                <p class="lead"><b>State Number</b> <%=state.getStateID()%> </p>
                <p class="lead"><b>State Description</b> <%=state.getStateDescription()%> </p>

                <input type ="hidden" id= "stateID" name = "stateID" value = "<%=state.getStateID()%>">
                <input type ="hidden" id= "scenarioID" name = "scenarioID" value = "<%=activatedScenario.getScenarioID()%>">


            </form>
            <a class="close-reveal-modal">&#215;</a>
        </div>

        <% }%>

        <script src="js/vendor/jquery.js"></script>
        <script src="js/foundation.min.js"></script>
        <script>
            $(document).ready(function () {
                $(document).foundation();
                var humaneSuccess = humane.create({baseCls: 'humane-original', addnCls: 'humane-original-success', timeout: 2000, clickToClose: true});
               
                var success1 = "<%=success%>";
                if (success1 !== "") {
                    humaneSuccess.log(success1);
                }

            });
        </script>
        <script type="text/javascript" src="js/humane.js"></script>
        
        <%}%>
    </body>
</html>
