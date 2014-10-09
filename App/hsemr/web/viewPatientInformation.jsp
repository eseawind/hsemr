<%-- 
    Document   : viewPatientInformation
    Created on : Oct 09, 2014, 2:37:16 PM
    Author     : weiyi.ngow.2012
--%>

<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.Date"%>
<%@page import="java.text.DateFormat"%>
<%@page import="javax.imageio.ImageIO"%>
<%@page import="javax.swing.JLabel"%>
<%@page import="javax.swing.ImageIcon"%>
<%@page import="java.awt.Image"%>
<%@page import="java.util.List"%>
<%@page import="entity.*"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="dao.*"%>
<%@include file="protect.jsp" %>
<!DOCTYPE html>

<html>
    <head>
        <meta charset="utf-8" />
        <meta name="viewport" content="width=device-width, initial-scale=1.0" />
        <link rel="stylesheet" href="css/foundation.css" />
        <script src="js/vendor/modernizr.js"></script>
        <title>Patient Information</title>
        <%@include file="/topbar/topbar.jsp" %> 
    </head>
    <body>
        <%            String active = active = (String) session.getAttribute("active");

            //retrieve all successfulmessages
            

            //retrieve patient's information
            String patientNRIC = "";
            Patient retrievePatient = PatientDAO.retrieve(patientNRIC);
            Scenario retrieveLastScenario = null;
            State retrieveScenarioState = null;

            //retrieve current scenario
            List<Scenario> scenarioActivatedList = ScenarioDAO.retrieveActivatedStatus();

            if (scenarioActivatedList.size() != 0) {
                //get the most recently activated scenario
                retrieveLastScenario = scenarioActivatedList.get(scenarioActivatedList.size() - 1);

                //get the most recently activated scenario's state
                retrieveScenarioState = StateDAO.retrieveActivateScenarioPatient(retrieveLastScenario.getScenarioID());
                patientNRIC = retrieveScenarioState.getPatientNRIC();
                retrievePatient = PatientDAO.retrieve(patientNRIC);
            }

            State stateRetrieved = StateDAO.retrieve(retrieveScenarioState.getStateID(), retrieveLastScenario.getScenarioID());

            //retrieve case's information
            String admissionNotes = retrieveLastScenario.getAdmissionInfo();

            //retrieve note's information
            //List<Note> notesListRetrieved = NoteDAO.retrieveAll();
            //retrieve patient's information
            String firstName = retrievePatient.getFirstName();
            String lastName = retrievePatient.getLastName();
            String fullName = firstName + " " + lastName;
            String dob = retrievePatient.getDob();
            String gender = retrievePatient.getGender();
            String allergy = PatientDAO.retrieveAllergy(patientNRIC);

            //retrieve state's information
            String RR = stateRetrieved.getRR();
            String BP = stateRetrieved.getBP();
            String HR = stateRetrieved.getHR();
            String SPO = stateRetrieved.getSPO();
            String intake = stateRetrieved.getIntake();
            String output = stateRetrieved.getOutput();
            double temperature = stateRetrieved.getTemperature();
            String stateID = stateRetrieved.getStateID();
            String scenarioID = retrieveLastScenario.getScenarioID();

        %>
        <br>
        <div align ="center">
            <div class="large-centered large-10 columns">

                                       
                <div class="panel">
                    <h5>Patient's Information</h5>
                    <span class="label">Name</span> <%=fullName%>&nbsp;
                    <span class="label">NRIC</span> <%=patientNRIC%>&nbsp;
                    <span class="label">DOB</span> <%=dob%>&nbsp;
                    <span class="label">Gender</span> <%=gender%>&nbsp;
                    <span class="label">Allergy</span> <%=allergy%>&nbsp;
                    </p>
                </div></div>

            <div class="large-centered large-10 columns">
                <div class="tabs-content">
                    <dl class="tabs" data-tab>
                        <dd class="<% if (active == null || active.equals("") || active.equals("admission")) {
                                out.println("active");
                            } else {
                                out.println("");
                            } %>" ><a href="#admission"><b>Admission Notes</b></a></dd>
                        <dd class="<% if (active != null && active.equals("reports")) {
                                out.println("active");
                            } else {
                                out.println("");
                            } %>"><a href="#reports"><b>Investigation</b></a></dd>
                        <dd class="<% if (active != null && active.equals("medication")) {
                                out.println("active");
                            } else {
                                out.println("");
                            } %>"><a href="#vital"><b>Clinical Charts</b></a></dd>
                        <dd class="<% if (active != null && active.equals("vital")) {
                                out.println("active");
                            } else {
                                out.println("");
                            } %>"><a href="#medication"><b>Medication</b></a></dd>
                        <dd class="<% if (active != null && active.equals("multidisciplinary")) {
                                out.println("active");
                            } else {
                                out.println("");
                            } %>"><a href="#multidisciplinary"><b>Multidisciplinary Notes</b></a></dd>
                    </dl>
                    <div class="<% if (active == null || active.equals("") || active.equals("admission")) {
                            out.println("content active");
                        } else {
                            out.println("content");
                        }%>" id="admission">

                        <p style="margin-left:1em; margin-right:1em; text-align:justify;"><%=admissionNotes%></p>
                    </div>


                    <div class="<% if (active != null && active.equals("reports")) {
                            out.println("content active");
                        } else {
                            out.println("content");
                        } %>" id="reports">


                    </div>


                    <div class="<% if (active != null && active.equals(
                                "medication")) {
                            out.println("content active");
                        } else {
                            out.println("content");
                        } %>" id="medication">

                    </div>

                    <div class="<% if (active != null && active.equals("vital")) {
                            out.println("content active");
                        } else {
                            out.println("content");
                        } %>" id="vital">


                    </div>

                    <div class="<% if (active != null && active.equals(
                                "multidisciplinary")) {
                            out.println("content active");
                        } else {
                            out.println("content");
                        }%>" id="multidisciplinary">
                    </div>
                </div>

            </div>

        </div>



        <script src="js/vendor/jquery.js"></script>
        <script src="js/foundation.min.js"></script>
        <script>
            $(document).foundation();
        </script>
    </body>
</html>
