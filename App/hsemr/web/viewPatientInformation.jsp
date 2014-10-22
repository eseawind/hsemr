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
<%@include file="protectPage/protectNurse.jsp" %>
<!DOCTYPE html>

<html>
    <head>
<meta charset="utf-8" />
        <meta name="viewport" content="width=device-width, initial-scale=1.0" />
        <link rel="stylesheet" href="css/foundation.css" />
        <script src="js/vendor/modernizr.js"></script>
        <title>NP Health Sciences | Patient Information</title>
        <%@include file="/topbar/topbar.jsp" %> 
    </head>
    <body>
        
      
        
        <%            
        String active = active = (String) session.getAttribute("active");

            //retrieve all successfulmessages
           

            //retrieve patient's information
            String patientNRIC = "";
            Patient retrievePatient = PatientDAO.retrieve(patientNRIC);
            
            State retrieveScenarioState = null;

            //retrieve current scenario
            Scenario scenarioActivated = ScenarioDAO.retrieveActivatedScenario();
           
            if (scenarioActivated == null) {
                %> 
                <div align ="center">
            <div class="large-centered large-10 columns">
                <p><h1>No Case Activated</h1></p>
                    Please contact administrator/lecturer for case activation.
            </div>
            
                    <%
            } else {
                
                
                //get the most recently activated scenario's state
                retrieveScenarioState = StateDAO.retrieveActivateState(scenarioActivated.getScenarioID());
                
                patientNRIC = retrieveScenarioState.getPatientNRIC();
                retrievePatient = PatientDAO.retrieve(patientNRIC);
           
            //retrieve case's information
            String admissionNotes = scenarioActivated.getAdmissionNote();

            //retrieve note's information
            //List<Note> notesListRetrieved = NoteDAO.retrieveAll();
            //retrieve patient's information
            String firstName = retrievePatient.getFirstName();
            String lastName = retrievePatient.getLastName();
            String fullName = firstName + " " + lastName;
            String dob = retrievePatient.getDob();
            String gender = retrievePatient.getGender();
            String allergy = PatientDAO.retrieveAllergy(patientNRIC);
            
            if(allergy == null){
                allergy = "none";
            }
            
            Vital vital = VitalDAO.retrieveByDatetime(patientNRIC,"2014-10-11 15:00:00");

            //retrieve state's information
             double temperature = vital.getTemperature();
             int rr = vital.getRr();
             int bpSystolic = vital.getBpSystolic();
             int bpDiasolic = vital.getBpDiastolic();
             int hr = vital.getHr();
             int spo = vital.getSpo();
             String output = vital.getOutput();
            String oralType = vital.getOralType();
            String oralAmount = vital.getOralAmount();
            String intravenousType = vital.getIntravenousType();
            String intravenousAmoun = vital.getIntravenousAmount();

             
           
            String stateID = retrieveScenarioState.getStateID();
            String scenarioID = scenarioActivated.getScenarioID();

        %>
        <br>
        <div align ="center">
            <div class="large-centered large-10 columns">                  
                <div class="panel" style="background-color: white">
                    <h4>Patient's Information</h4><br/>
                    <span class="label">Name</span> <%=fullName%>&nbsp;
                    <span class="label">NRIC</span> <%=patientNRIC%>&nbsp;
                    <span class="label">DOB</span> <%=dob%>&nbsp;
                    <span class="label">Gender</span> <%=gender%>&nbsp;
                    <span class="label">Allergy</span> <%=allergy%>&nbsp;
                </div></div>
                
                
            <div class ="large-centered large-10 columns">
                        <%if (session.getAttribute("success") != null) {%>
                        <div data-alert class="alert-box success radius">
                           <%=session.getAttribute("success")%>
                            <a href="#" class="close">&times;</a>
                        </div>
                        <%
                            session.setAttribute("success",null);                        
                            }
                        %>
                        
                        <%if (session.getAttribute("error") != null) {%>
                        <div data-alert class="alert-box alert radius">
                           <%=session.getAttribute("error")%>
                            <a href="#" class="close">&times;</a>
                        </div>
                        <%
                            session.setAttribute("error",null);                        
                            }
                        %>
                            
            </div>

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
                        
                         <form action="ProcessAddNote" method="POST">
                            <%
                                String grpNames = (String) request.getAttribute("grpNames");
                                String notes = (String) request.getAttribute("notes");
                                   
                            %> 
                             <div class="small-8">
                                    <div class="row">
                                        <div class="small-3 columns">

                                            <label for="right-label" class="right inline">Group Member Names</label>
                                            <label for="right-label" class="right inline">Multidisciplinary Note</label>
                                        </div>
                                        <div class="small-9 columns">
                                            <input type ="hidden" name="scenarioID" value="<%=scenarioID%>"/>

                                            <input type ="text" id= "grpNames" name="grpNames" value="<% if (grpNames == null || grpNames =="") {
                                                    out.print("");
                                                } else {
                                                    out.print(grpNames);
                                                }%>" >
                                            <textarea name="notes" id="notes" rows="7" cols="10" ><% if (notes == null || notes == "") {
                                                    out.print("");
                                                } else {
                                                    out.print(notes);
                                                }%></textarea>

                                        </div>
                                    </div>
                                </div>
                             <br>
                                            <input type="submit" name="buttonChoosen" value="Save" class="button tiny"> 
                                            <input type="submit" name="buttonChoosen" value="Submit" class="button tiny"> 
                                            <input type="button" value="Cancel" class="button tiny" onClick="window.location = 'viewPatientInformation.jsp'"/>
                         </form>
                    </div>
                </div>

            </div>

        </div>

<% } %>

        <script src="js/vendor/jquery.js"></script>
        <script src="js/foundation.min.js"></script>
        <script>
            $(document).foundation();
        </script>
    </body>
</html>
