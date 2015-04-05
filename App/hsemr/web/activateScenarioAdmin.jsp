<%-- 
    Document   : activateScenarioAdmin
    Created on : Feb 28, 2015, 10:41:45 PM
    Author     : Administrator
--%>
<%@page import="entity.LecturerScenario"%>
<%@page import="dao.LecturerScenarioDAO"%>
<%@page import="entity.Lecturer"%>
<%@page import="dao.LecturerDAO"%>
<%@page import="entity.Vital"%>
<%@page import="java.util.List"%>
<%@page import="dao.VitalDAO"%>
<%@page import="dao.AllergyPatientDAO"%>
<%@page import="dao.StateDAO"%>
<%@page import="entity.Patient"%>
<%@page import="dao.PatientDAO"%>
<%@page import="entity.Scenario"%>
<%@page import="dao.ScenarioDAO"%>
<%@page import="entity.State"%>
<%@page import="java.util.ArrayList"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@include file="protectPage/protectAdmin.jsp" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">

        <!--Web Title-->
        <title>EMR | Case Management | Activate Case</title>

        <link rel="stylesheet" href="css/foundation.css" />
        <link rel="stylesheet" href="css/style.css" />
        <link rel="stylesheet" href="responsive-tables.css">
        <script src="responsive-tables.js"></script>
        <%@include file="/topbar/topbarAdmin.jsp" %>

        <link rel="stylesheet" href="//code.jquery.com/ui/1.11.1/themes/smoothness/jquery-ui.css">
        <script src="//code.jquery.com/jquery-1.10.2.js"></script>
        <script src="//code.jquery.com/ui/1.11.1/jquery-ui.js"></script>
        <link rel="stylesheet" href="/resources/demos/style.css">
        <script type="text/javascript" src="js/humane.js"></script>
        <link rel="stylesheet" href="css/original.css" />
        <script>
            $(function() {
                $("#datepicker").datepicker();
            });

        </script>


        <%            
            String success = "";
            String error = "";

            if (session.getAttribute("success") != null && !session.getAttribute("success").equals("")) {
                success = (String) session.getAttribute("success");
                session.setAttribute("success", "");
            }

            if (session.getAttribute("error") != null && !session.getAttribute("error").equals("")) {
                error = (String) session.getAttribute("error");
                session.setAttribute("error", "");
            }
        %>

    </head>
    <body>
        <%            
            String scenarioID = "";
            String sessionScenario = (String) session.getAttribute("scenarioID");
            if (request.getParameter("scenarioID") != null) {
                scenarioID = request.getParameter("scenarioID");
                session.setAttribute("scenarioID", scenarioID);
            } else if (sessionScenario != null) {
                scenarioID = sessionScenario;
            }

            Scenario scen = ScenarioDAO.retrieve(scenarioID);

            if (scen == null) {
                out.println("No case selected");
            }
        %>
        <div class="row" style="width: 700px; padding-top: 50px">
            <center><h1>Activate Case</h1></center>
            <br>
                <input type="hidden" name="scenarioID" value="<%=scenarioID%>">
                <div class="panelCase">
                    <p>
                        <strong>Case Selected</strong>
                        <input type="text" name="scenarioName" value = "<%=scen.getScenarioName()%>" required pattern ="^[a-zA-Z0-9 ]+$" readonly>


                        <strong>Currently Activated By</strong><br>
                        <%
                            List<String> lecScenarioList = LecturerScenarioDAO.retrieveDistinctLecturers(scenarioID);

                            if (lecScenarioList == null || lecScenarioList.size() == 0) {
                                out.println("This case is not activated by any lecturers at the moment.<br>");
                            } else {
                                for (String lecActivatedScenario : lecScenarioList) {%>
                        <%=lecActivatedScenario%> &nbsp;
                        <%}
                            }
                        %>
                        <br><br>
                        <strong>Activate Case For Lecturer</strong><br>
                        Note: One lecturer can only activate one case at a time. Please deactivate the other case for that lecturer before activating this. <br><br> 
                        <%
                            // These lecturers can activate cases because they have not activated any cases
                            List<String> lecWhoDidNotActivateList = LecturerScenarioDAO.retrieveDistinctLecturersWhoDidNotActivateAnyCase(); 
                        %>
                         <form data-abide action ="ProcessActivateScenarioAdmin" method ="POST">
                            <input type="hidden" name="scenarioID" value="<%=scenarioID%>">
                            <p><strong>Activate Case For Lecturer(s)</strong></p>
                            <p>Note: One lecturer can only activate one case at a time. If you select lecturers who have activated other cases, it will <font color = "b20000"><b>automatically deactivate the case that they have activated.</b></font> </p>
                            <table>
                                <tr>
                                    <th>Activate Case For Lecturer</th> 
                                    <td> 
                                        <%
                                            List<String> lecWhoDidNotActivateAnyCaseList = LecturerScenarioDAO.retrieveDistinctLecturersWhoDidNotActivateAnyCase(); //they can activate because they have not activated any cases

                                            if (lecWhoDidNotActivateAnyCaseList == null || lecWhoDidNotActivateAnyCaseList.size() == 0) {
                                                out.println("This case is not activated by any lecturers at the moment.<br>");
                                            } else {
                                                for (String lecDidNotActivate : lecWhoDidNotActivateList) {
                                        %>
                                                    <input type="checkbox" name="lecturerToActivateCase" class="css-checkbox" id="<%=lecDidNotActivate%>" value = "<%=lecDidNotActivate%>"/>
                                                        <label for="<%=lecDidNotActivate%>"  class="css-label lite-green-check"><%=lecDidNotActivate%></label>
                                        <%}
                                                }
                                        %>  
                                </td> 
                                </tr>

                                <tr>
                                    <th>Lecturers who activated other cases (hover for case information)</th>
                                        <%
                                            List<String> lecWhoHasOtherCasesActivatedList = LecturerScenarioDAO.retrieveDistinctActivatedLecturers();

                                            if (lecWhoHasOtherCasesActivatedList == null || lecWhoHasOtherCasesActivatedList.size() == 0) {
                                                out.println("<td>NA</td>");
                                            } else {
                                                for (String lecWithOtherCases : lecWhoHasOtherCasesActivatedList) {
                                        %>
                                                <td>    
                                                    <input type="checkbox" name="lecturerToActivateCaseWhoHasOtherCase" class="css-checkbox" id="<%=lecWithOtherCases%>" value = "<%=lecWithOtherCases%>" />
                                                    <label for="<%=lecWithOtherCases%>" class="css-label lite-red-check">
                                                    <span data-tooltip aria-haspopup="true" class="has-tip" title="<%=ScenarioDAO.retrieve(LecturerScenarioDAO.retrieveScenario(lecWithOtherCases)).getScenarioName()%>"><%=lecWithOtherCases%></span></label>
                                                </td>
                                        <% 
                                                }
                                            }
                                        %>
                                </tr>
                            </table>
                        <br/><br/> 
                    </div> <!--End of panel case div-->

                    <%
                        String location = "viewScenarioAdmin.jsp";
                    %>
                    <table style="border-color: white; width:700px">
                        <col width="50%">
                        <col width="50%">
                        <tr>
                            <td><center><input type="button" value="Cancel" class="button small" onClick="window.location = '<%=location%>'"/></center> </td>
                            <td><center><input type="submit" class="button important" value="Activate"></center></td>
                        </tr>
                    </table>
                </form>
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
