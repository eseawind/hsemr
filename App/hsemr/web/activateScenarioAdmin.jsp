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


        <%            String success = "";
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

        <%

        %>
    </head>
    <body>
        <%            String scenarioID = "";
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
        <div class="row" style="width: 600px; padding-top: 50px">
            <center><h1>Activate Case</h1></center>
            <br>
            <form data-abide action ="ProcessActivateScenarioAdmin" method ="POST">
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
                            List<String> lecWhoDidNotActivateList = LecturerScenarioDAO.retrieveDistinctLecturers(); //they can activate because they have not activated any cases

                            if (lecWhoDidNotActivateList == null || lecWhoDidNotActivateList.size() == 0) {
                                out.println("This case is not activated by any lecturers at the moment.<br>");
                            } else {
                                for (String lecDidNotActivate : lecWhoDidNotActivateList) {%>
                        <input type="checkbox" name = "lecturerToActivateCase" value = "<%=lecDidNotActivate%>"><label><%=lecDidNotActivate%></label>
                            <%}
                                }
                            %>  
                    </p>
                </div>
                <%
                    String location = "viewScenarioAdmin.jsp";
                %>
                <center>
                    <br/>
                    <input type="button" value="Cancel" class="button" onClick="window.location = '<%=location%>'"/>
                    <input type="submit" value="Activate" class="button"></center>

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
