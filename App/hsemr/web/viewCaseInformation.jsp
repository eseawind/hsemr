<%-- 
    Document   : viewCaseInformation
    Created on : Oct 31, 2014, 10:51:50 PM
    Author     : weiyi.ngow.2012
--%>

<%@page import="entity.Scenario"%>
<%@page import="dao.ScenarioDAO"%>
<%@page import="java.util.ArrayList"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<%@include file="protectPage/protectNurse.jsp" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link rel="stylesheet" href="css/foundation.css" />
        <title>NP Health Sciences | Case Information</title>
        <%@include file="/topbar/topbar.jsp" %> 
    </head>
    <body>
    <center>
        <br/><br/><br/>
        <h1>Case Information</h1><br/><br/>
        
        <%
             //create an arraylist to be passed to check validity of medicine
                    ArrayList<String> medicineVerifiedList = new ArrayList<String>();
                    medicineVerifiedList.add("TESTING");
                    session.setAttribute("medicineVerifiedList",medicineVerifiedList);
        
        
        %>
        <div class="large-centered large-6 columns">
            <% Scenario scenarioActivated = ScenarioDAO.retrieveActivatedScenario();
        if (scenarioActivated != null) {%>
            <form action ="viewPatientInformation.jsp" method="post">
                <table>
                    <col width="30%">
                    <col width="70%">

                    <tr>
                        <td>
                            <h5><font style="font-weight:400">Scenario Name</font></h5>
                        </td>

                        <td> 
                            <%=ScenarioDAO.retrieveActivatedScenario().getScenarioName()%>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <h5><font style="font-weight:400">Scenario Description</font></h5>
                        </td>

                        <td>
                            <%=ScenarioDAO.retrieveActivatedScenario().getScenarioDescription()%>
                        </td>
                    </tr>

                </table><br/><br/><br/><br/>
                <input type="submit" class="button" value="Proceed">
            </form>
            <%
                    } else { %>
            <p><font size="6">NO CASE ACTIVATED</font><br>
                Please contact administrator/lecturer for case activation.</p>
                <%
                    }
                %>
        </div>
    </center>


</body>
</html>
