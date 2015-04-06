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
        <%@include file="/topbar/topbar.jsp" %> 

        <!--Web Title-->
        <title>EMR | Case Information</title>
    </head>
    <body>
    <center> 
        <div class="large-12 large-centered columns">  
            <div class="row" style="padding-top: 60px">
                <h1>Case Information</h1><br/><br/>

                <%
                    //create an arraylist to be passed to check validity of medicine
                    ArrayList<String> medicineVerifiedList = new ArrayList<String>();
                    medicineVerifiedList.add("TESTING");
                    session.setAttribute("medicineVerifiedList", medicineVerifiedList);
              
                    Scenario scenarioActivated = ScenarioDAO.retrieveScenarioActivatedByLecturer(pg.getLecturerID());

                    if (scenarioActivated != null) {%>
                        <!--Display Case Info-->
                        <form action ="viewPatientInformation.jsp" method="post">
                            <table style="border-color: #999">
                                <col width="25%">
                                <col width="75%">

                            <tr>
                                <td><b>Scenario Name</b></td>
                                <td><%=scenarioActivated.getScenarioName()%></td>
                            </tr>
                            <tr>
                                <td><b>Scenario Description</b></td>
                                <td><%=scenarioActivated.getScenarioDescription()%></td>
                            </tr>

                            </table>
                            <br/><br/><br/><br/>
                            <input type="submit" class="button important" value="Proceed">
                        </form>
                <%
                    } else { 
                %>
                <p><font size="6">NO CASE ACTIVATED</font><br>
                    Please contact administrator/lecturer for case activation.</p>
                    <%
                        }
                    %>
            </div>
        </div>
    </center>
</body>
</html>
