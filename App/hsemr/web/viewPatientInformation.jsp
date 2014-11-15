<%-- 
    Document   : viewPatientInformation
    Created on : Oct 09, 2014, 2:37:16 PM
    Author     : weiyi.ngow.2012
--%>

<%@page import="java.util.TimeZone"%>
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
        <link rel="stylesheet" href="css/original.css" />
        <script src="js/vendor/modernizr.js"></script>
        <script type="text/javascript" src="js/humane.js"></script>
        <script type="text/javascript" src="js/app.js"></script>

        <script src="js/vendor/jquery.js"></script>
        <script>

            $(document).ready(function () {
                $(document).foundation();
            });
        </script>
        <title>NP Health Sciences | Patient Information</title>
        <%@include file="/topbar/topbar.jsp" %> 
    </head>
    <body>
        <script src="js/foundation.min.js"></script>
        <div align ="center">
            <div class="large-centered large-10 columns">
                <%            String active = active = (String) session.getAttribute("active");

                    String success = "";
                    String error = "";
                    //retrieve all successfulmessages
                    //retrieve patient's information
                    String patientNRIC = "";
                    Patient retrievePatient = PatientDAO.retrieve(patientNRIC);

                    State retrieveScenarioState = null;

                    //retrieve current scenario
                    Scenario scenarioActivated = ScenarioDAO.retrieveActivatedScenario();

                    if (scenarioActivated == null) {
                %> 

                <p><h1>No Case Activated</h1></p>
                Please contact administrator/lecturer for case activation.

                <%
                } else {

                    //get the most recently activated scenario's state
                    retrieveScenarioState = StateDAO.retrieveActivateState(scenarioActivated.getScenarioID());

                    patientNRIC = retrieveScenarioState.getPatientNRIC();
                    retrievePatient = PatientDAO.retrieve(patientNRIC);

                    //retrieve case's information
                    String admissionNotes = scenarioActivated.getAdmissionNote();

                    //retrieve note's information
                    List<Note> notesListRetrieved = NoteDAO.retrieveAll();
                    //retrieve patient's information
                    String firstName = retrievePatient.getFirstName();
                    String lastName = retrievePatient.getLastName();
                    String fullName = firstName + " " + lastName;
                    String dob = retrievePatient.getDob();
                    String gender = retrievePatient.getGender();
                    String allergy = PatientDAO.retrieveAllergy(patientNRIC);

                    if (allergy == null) {
                        allergy = "none";
                    }

//            Vital vital = VitalDAO.retrieveByDatetime(patientNRIC,"2014-10-11 15:00:00");
                    //retrieve state's information
//             double temperature = vital.getTemperature();
//             int rr = vital.getRr();
//             int bpSystolic = vital.getBpSystolic();
//             int bpDiasolic = vital.getBpDiastolic();
//             int hr = vital.getHr();
//             int spo = vital.getSpo();
//             String output = vital.getOutput();
//            String oralType = vital.getOralType();
//            String oralAmount = vital.getOralAmount();
//            String intravenousType = vital.getIntravenousType();
//            String intravenousAmoun = vital.getIntravenousAmount();
                    String stateID = retrieveScenarioState.getStateID();
                    String scenarioID = scenarioActivated.getScenarioID();

                %>
                <br>               
                <div class="panel" style="background-color: #FFFFFF">
                    <h3><b>Patient's Information</b></h3><br/>
                    <font size='3'><b>Name: <font color="#666666"><%=fullName%></font></b>&nbsp;&nbsp;
                    <b>NRIC: <font color="#666666"><%=patientNRIC%></font></b>&nbsp;&nbsp;
                    <b>DOB: <font color="#666666"><%=dob%></font></b>&nbsp;&nbsp;
                    <b>Gender: <font color="#666666"><%=gender%></font></b>&nbsp;&nbsp;
                    <b>Allergy: <font color="red"><%=allergy%></font></b>&nbsp;</font>
                </div>


                <%
                    if (session.getAttribute("success") != null) {

                        success = (String) session.getAttribute("success");
                        session.setAttribute("success", "");
                    }
                %>

                <%if (session.getAttribute("error") != null) {

                        error = (String) session.getAttribute("error");
                        session.setAttribute("error", "");
                    }
                %>

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
                            } %>"><a href="#reports"><b>Investigations</b></a></dd>
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

                        <h4>Doctor's Order</h4>

                        <%
                            List<Report> stateReports = ReportDAO.retrieveReportsByState(scenarioID, stateID);
                            if (stateReports != null && stateReports.size() != 0) {
                        %>

                        <table>
                            <tr>
                                <td><b>Reports Ordered</b></td>
                                <td><b>Last Updated</b></td>
                                <td><b>Action</b></td>
                                <td><b>Report Results</b></td>
                            </tr>

                            <%
                                // Create an instance of SimpleDateFormat used for formatting 
                                // the string representation of date (month/day/year)
                                DateFormat df = new SimpleDateFormat("yyyy-M-dd HH:mm:ss");

                                for (Report report : stateReports) {
                                    String reportName = report.getReportName();
                                    String reportFile = report.getReportFile();

                                    String reportDatetime = df.format(report.getReportDatetime());
                                    int dispatchStatus = report.getDispatchStatus();

                                    String reportResults = "";

                                    if (dispatchStatus == 1) {

                                        reportResults = "reports/" + reportFile;
                                    }


                            %> 
                            <tr>
                                <td><%=reportName%></td>
                                <td><%=reportDatetime%></td>
                                <td><%
                                    if (dispatchStatus == 1) {
                                        out.println("Already despatched");
                                    } else {
                                    %>
                                    <form action="ProcessDespatch" method="POST">
                                        <input type="hidden" name="reportName" value="<%=reportName%>">
                                        <input type="hidden" name="scenarioID" value="<%=scenarioID%>">
                                        <input type="hidden" name="stateID" value="<%=stateID%>">

                                        <input type="submit" class="report-despatch button tinytable" value="Depatch">

                                    </form>


                                    <% } %>
                                </td>
                                <td>
                                    <%
                                        if (dispatchStatus == 1) {
                                    %>
                                    <a href="<%=reportResults%>" target="_blank">View Report</a>
                                    <% } else {
                                            out.println("N/A");

                                        }
                                    %>
                                </td>


                            </tr>


                            <%
                                }
                            %>
                        </table>
                        <%
                            } else {
                                out.println("No doctor's order at the moment.");

                            }
                            session.setAttribute("active", null);

                        %>  


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

                        <%

                            Date currentDateTime = new Date();
                            DateFormat dateFormatter = new SimpleDateFormat("dd-M-yyyy H:m:s");
                            dateFormatter.setTimeZone(TimeZone.getTimeZone("Singapore"));
                            String currentDateFormatted = dateFormatter.format(currentDateTime);

                        %>
                        <form data-abide action="ProcessAddVital" method="POST">
                            <table width='65%'>
                                <br/>
                                <col width="35%">  
                                <col width="65%">  
                                <!--  <th>Vital Signs/Input/Output</th> -->
                                <th></th>
                                <th>Current as of <%=currentDateFormatted%></th>
                                <tr><td><b>Temperature</b><img src="img/Historial.jpg"></td>
                                    <td><div class="row">
                                            <div class="small-4 columns" style="width:200px">
                                                <!--validates for 1 decimal place-->
                                                <input type="text" name ="temperature" maxlength="4" pattern ="[0-9]+(\.[0-9][0-9]?)?" />
                                                <small class="error">Must be numeric, cannot contain alphabets. E.g: 37.3 or 37</small>
                                            </div>
                                            <label for="right-label" class="left inline">ºC</label>
                                        </div></td>
                                </tr> 

                                <tr><td><b>Respiratory Rate<img src="img/Historial.jpg"></b></td>
                                    <td><div class="row">
                                            <div class="small-4 columns" style="width:200px">
                                                <input type="text" name ="RR" maxlength="2" pattern ="integer"/>
                                                <small class="error">RR must be 2 digits.</small>
                                            </div>

                                            <label for="right-label" class="left inline">breaths/min</label>

                                        </div>
                                </tr>

                                <tr><td><b>Heart Rate<img src="img/Historial.jpg"></b></td>
                                    <td><div class="row">
                                            <div class="small-4 columns" style="width:200px">
                                                <!--validates between 0 - 200-->
                                                <input type="text" name ="HR" maxlength ="3" pattern ="^([0-9]|[1-9][0-9]|[1][0-9][0-9]|20[0-0])$"/>
                                                <small class="error">HR must be between 0 - 200.</small>
                                            </div>
                                            <label for="right-label" class="left inline">beats/min</label>
                                        </div></td>
                                </tr>

                                <tr><td><b>Blood Pressure<img src="img/Historial.jpg"></b></td>
                                    <td><div class="row">
                                            <div class="small-4 columns" style="width:200px">
                                                <!--<input type="text" name ="BPsystolic" style="width:200px" value= "0" maxlength = "3" pattern = "^(\d{2,3}|\d{2})$"/>-->
                                                <input type="text" name ="BPsystolic" maxlength = "3" pattern = "integer"/>
                                                <small class="error">BPsystolic must be numeric and between 2 to 3 digits.</small>
                                            </div>

                                            <label for="right-label" class="left inline">mm (Systolic)</label>

                                        </div>
                                        <div class="row">
                                            <div class="small-4 columns" style="width:200px">
                                                <!--<input type="text" name ="BPdiastolic" style="width:200px" value= "0" maxlength = "3" pattern = "^(\d{2,3}|\d{2})$"/>-->
                                                <input type="text" name ="BPdiastolic" maxlength = "3" pattern = "integer"/>
                                                <div class ="input wrapper">
                                                    <small class="error">BPsystolic must be numeric and between 2 to 3 digits.</small>
                                                </div>
                                            </div>

                                            <label for="right-label" class="left inline">Hg (Diastolic)</label>

                                        </div>
                                    </td></tr>
                                <tr><td><b>SPO<img src="img/Historial.jpg"></b></td>

                                    <td><div class="row">
                                            <div class="small-4 columns" style="width:200px">
                                                <input type="text" name ="SPO" maxlength = "3" pattern ="^[0-9][0-9]?$|^100$"/>
                                                <small class="error">SPO must be numeric and between 0 - 100%.</small>
                                            </div>

                                            <label for="right-label" class="left inline">% with O<sub>2</sub></label>

                                        </div></td></tr>
                                <tr><td><b>Intake - Oral/Intragastric</b></td>

                                    <td><div class="row">
                                            <div class="small-4 columns" style="width:200px">
                                                <input type="text" name ="oralType" value= " "/>
                                            </div>

                                            <label for="left-label" class="left inline">Type</label>

                                        </div>
                                        <div class="row">
                                            <div class="small-4 columns" style="width:200px">
                                                <input type="text" name ="oralAmount"  value= " "/>
                                            </div>

                                            <label for="left-label" class="left inline">Amount</label>

                                        </div>
                                    </td></tr>

                                <tr><td><b>Intake - Intravenous</b></td>

                                    <td><div class="row">
                                            <div class="small-4 columns" style="width:200px">
                                                <input type="text" name ="intravenousType" value= " "/>
                                            </div>

                                            <label for="left-label" class="left inline">Type</label>

                                        </div>
                                        <div class="row">
                                            <div class="small-4 columns" style="width:200px">
                                                <input type="text" name ="intravenousAmount"  value= " "/>
                                            </div>

                                            <label for="left-label" class="left inline">Amount</label>

                                        </div>
                                    </td></tr>

                                <tr><td><b>Output</b></td>

                                    <td><div class="row">
                                            <div class="small-4 columns" style="width:200px">
                                                <input type="text" name ="output" style="width:170px" value= " "/>
                                            </div>
                                            <label for="left-label" class="left inline"></label>
                                        </div>
                                    </td></tr>

                            </table>
                            <input type ="hidden" value ="<%=patientNRIC%>" name = "patientNRIC">
                            <input type="submit" value="Update Vital Signs" class="button tiny"> 
                        </form>


                    </div>

                    <div class="<% if (active != null && active.equals(
                                "multidisciplinary")) {
                            out.println("content active");
                        } else {
                            out.println("content");
                        }%>" id="multidisciplinary">

                        <form action="ProcessAddNote" method="POST">
                            <%
                                String grpNames = (String) session.getAttribute("grpNames");
                                String notes = (String) session.getAttribute("notes");

                            %> 



                            <h4>Enter New Multidisciplinary Notes</h4><br>
                            <div id="newNotes" class="content">
                                <div class="small-8">
                                    <div class="row">
                                        <div class="small-3 columns">

                                            <label for="right-label" class="right inline">Nurses in-charge</label>
                                            <label for="right-label" class="right inline">Multidisciplinary Note</label>
                                        </div>
                                        <div class="small-9 columns">
                                            <input type ="hidden" name="scenarioID" value="<%=scenarioID%>"/>

                                            <input type ="text" id= "grpNames" name="grpNames" value="<% if (grpNames == null || grpNames == "") {
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
                                <div>
                                    <br>
                                    <input type="submit" name="buttonChoosen" value="Save" class="button tiny"> 
                                    <input type="submit" name="buttonChoosen" value="Submit" class="button tiny"> 
                                 
                                    <dl class="accordion" data-accordion>
                                        <dd class="accordion-navigation">
                                            <a href="#pastNotes">View Past Groups notes here</a>
                                            <div id="pastNotes" class="content">
                                                <div class="row">
                                                    <div class="large-12">
                                                        <div class="row">
                                                            <div class="large-12 columns">
                                                                <%
                                                                    if (notesListRetrieved == null || notesListRetrieved.size() == 0) {%>
                                                                <label for="right-label" class="right inline">No groups have enter their notes yet.</label>
                                                                <% } else {
                                                                        DateFormat df = new SimpleDateFormat("yyyy-M-dd HH:mm:ss");
                                                                        //String reportDatetime = df.format(notesRetrieve.getNoteDatetime());
                                                                        for (int i = notesListRetrieved.size() - 1; i >= 0; i--) {
                                                                            Note notesRetrieve = notesListRetrieved.get(i);
                                                                            // out.print("<b>Practical Group: </b>" + notes.getPracticalGroupID() + "<br>");
                                                                            out.print("<b>Nurses in-charge: </b>" + notesRetrieve.getGrpMemberNames() + "<br>");
                                                                            out.print("<b>Multidisciplinary Note: </b>" + notesRetrieve.getMultidisciplinaryNote() + "<br>");
                                                                            out.print("<b>Time submitted: </b>" + df.format(notesRetrieve.getNoteDatetime()) + "<br>");
                                                                            out.println("<br>");
                                                                        }

                                                                    }//end of else
                                                                %>


                                                            </div>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                        </dd>
                                    </form>
                                </div>
                            </div>

                    </div>
                    <% }%>
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
                    </body>
                    <script type="text/javascript" src="js/humane.js"></script>

                    </html>
