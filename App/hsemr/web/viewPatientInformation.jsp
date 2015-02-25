<%-- 
    Document   : viewPatientInformation
    Created on : Oct 09, 2014, 2:37:16 PM
    Author     : weiyi.ngow.2012
--%>

<%@page import="java.util.LinkedHashMap"%>
<%@page import="java.util.Map"%>
<%@page import="java.util.Iterator"%>
<%@page import="java.util.HashMap"%>
<%@page import="java.util.ArrayList"%>
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
<%@page import="dao.*"%>
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

        <!--Web Title-->
        <title>EMR | Patient Information</title>

        <script>

            $(document).ready(function() {
                $(document).foundation();
            });

        </script>
        <%@include file="/topbar/topbar.jsp" %> 
    </head>
    <body>
        <script src="js/foundation.min.js"></script>

        <!--RESPONSIVE. WEB VERSION HERE-->
        <div class="hide-for-small-only">
            <div align ="center">
                <div class="large-centered large-11 columns">


                    <%
                        String active = active = (String) session.getAttribute("active");
                        String success = "";
                        String error = "";
                        //retrieve all successfulmessages
                        //retrieve patient's information
                        String patientNRIC = "";
                        Patient retrievePatient = PatientDAO.retrieve(patientNRIC);
                        
    

                        State retrieveScenarioState = null;

                        //retrieve current scenario
                        Scenario scenarioActivated = ScenarioDAO.retrieveActivatedScenario();
       
                        
                        //get the most recently activated scenario's state
                        if (scenarioActivated == null) {
                            out.println("<center><h1>No Case/States Activated</h1><br>Please contact administrator/lecturer for case activation.</center>");
                        } else {
                            retrieveScenarioState = StateDAO.retrieveActivateState(scenarioActivated.getScenarioID());
                        
                    

                        if (scenarioActivated == null || retrieveScenarioState == null) {
                    %> 

                    <h1>No Case/States Activated</h1>
                    Please contact administrator/lecturer for case activation.

                    <%
                    } else {

                        patientNRIC = retrieveScenarioState.getPatientNRIC();
                        retrievePatient = PatientDAO.retrieve(patientNRIC);

                        String stateID = retrieveScenarioState.getStateID();
                        String scenarioID = scenarioActivated.getScenarioID();

                        session.setAttribute("scenarioID", scenarioID);

                        //retrieve case's information
                        String admissionNotes = scenarioActivated.getAdmissionNote();

                        //retrieve nurse praticalGroup ID
                        String practicalGrp = (String) session.getAttribute("nurse");

                        //retrieve note's information
                        List<Note> notesListRetrieved = NoteDAO.retrieveNotesByPraticalGrp(practicalGrp, scenarioID);

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

                    %>
                    <br>   
                    <!--Patient's Information-->
                    <!--To insert icon if needed-->
                    <table style="border-color: #368a55 ">
                        <col width="5%">
                        <col width="95%">
                        <tr>
                            <td>
                                <%if (gender.equals("Female")) { %>
                                <img src="img/Female.png" width="100" height="100" alt="Female"/>
                                <% } else { %>
                                <img src="img/Male.png" width="100" height="100" alt="Male"/>
                                <%  }%>
                            </td>
                            <td><h2>Patient's Information</h2>
                                <font size='4'><b>Name: <font color="#666666"><%=fullName%></font></b>&nbsp;&nbsp;
                                <b>NRIC: <font color="#666666"><%=patientNRIC%></font></b>&nbsp;&nbsp;
                                <b>DOB: <font color="#666666"><%=dob%></font></b>&nbsp;&nbsp;
                                <b>Gender: <font color="#666666"><%=gender%></font></b>&nbsp;&nbsp;
                                <b>Allergy: <font color="red"><%=allergy%></font></b>&nbsp;</font>
                            </td><br/>
                        </tr>
                    </table> <br/><br/>

                    <%
                        if (session.getAttribute("success") != null) {

                            success = (String) session.getAttribute("success");
                            session.setAttribute("success", "");
                        }
                        if (session.getAttribute("error") != null) {

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
                            <dd class="<% if (active != null && active.equals("vital")) {
                                    out.println("active");
                                } else {
                                    out.println("");
                                } %>"><a href="#vital"><b>Clinical Charts</b></a></dd>
                            <dd class="<% if (active != null && active.equals("medication")) {
                                    out.println("active");
                                } else {
                                    out.println("");
                                } %>"><a href="#medication"><b>Medication</b></a></dd>
                            <dd class="<% if (active != null && active.equals("multidisciplinary")) {
                                    out.println("active");
                                } else {
                                    out.println("");
                                } %>"><a href="#multidisciplinary"><b>Notes</b></a></dd>
                            <dd class="<% if (active != null && active.equals("documents")) {
                                    out.println("active");
                                } else {
                                    out.println("");
                                } %>"><a href="#documents"><b>Documents</b></a></dd>
                        </dl>

                        <!--ADMISSION NOTES-->
                        <div class="<% if (active == null || active.equals("") || active.equals("admission")) {
                                out.println("content active");
                            } else {
                                out.println("content");
                            }%>" id="admission">

                            <p style="margin-left:1em; margin-right:1em; text-align:justify;"><%=admissionNotes%></p>
                        </div>

                        <!--INVESTIGATIONS-->
                        <div class="<% if (active != null && active.equals("reports")) {
                                out.println("content active");
                            } else {
                                out.println("content");
                            } %>" id="reports">

                            <h4>Doctor's Order</h4><br/>

                            <%
                                if (StateHistoryDAO.retrieveAll().isEmpty()) {
                                    StateHistoryDAO.addStateHistory(scenarioID, stateID);
                                }
                                HashMap<String, String> activatedStates = StateHistoryDAO.retrieveAll();
                                // to store reports of all activated states
                                HashMap<List<Report>, String> stateReportsHM = new HashMap<List<Report>, String>();
                                // remove duplicates
                                List<String> tempList = new ArrayList<String>();
                                // remove duplicates and add reports of that state into array reports
                                for (Map.Entry<String, String> entry : activatedStates.entrySet()) {
                                    String state = entry.getKey();
                                    if (tempList.size() == 0) {
                                        tempList = new ArrayList<String>();
                                    }
                                    if (tempList.contains(state)) {
                                        activatedStates.remove(state);
                                    } else {
                                        tempList.add(state);
                                        List<Report> reports = ReportDAO.retrieveReportsByState(scenarioID, state);
                                        String doctorOrderTime = entry.getValue();
                                        if (reports != null && reports.size() != 0) {
                                            stateReportsHM.put(reports, doctorOrderTime);
                                        }
                                    }
                                }
                                if (stateReportsHM != null && stateReportsHM.size() != 0) {
                            %>

                            <table>
                                <tr>
                                    <td><b>Reports Ordered</b></td>
                                    <td><b>Order Time</b></td>
                                    <td><b>Despatched Time</b></td>
                                    <td><b>Action</b></td>
                                    <td><b>Report Results</b></td>
                                </tr>

                                <%
                                    DateFormat df = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");

                                    if (StateHistoryDAO.retrieveAll().isEmpty()) {
                                        StateHistoryDAO.addStateHistory(scenarioID, stateID);
                                    }

                                    // loop through each report
                                    int counter = 0;
                                    for (Map.Entry<List<Report>, String> entry : stateReportsHM.entrySet()) {
                                        List<Report> stateReports = entry.getKey();

                                        // if needed to display:
                                        String doctorOrderTime = entry.getValue();

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
                                    <td><%=doctorOrderTime%></td>
                                    <%
                                        // check if require retrieve process 
                                        // despatch Date time column 

                                        String counterStr = String.valueOf(counter);
                                        String firstDespatch = (String) session.getAttribute("clickedID");

                                        if (dispatchStatus == 1) {
                                            if (firstDespatch != null && !firstDespatch.equals("") && firstDespatch.equals(counterStr)) {%>
                                    <td><div id="reportDateWaiting">Waiting..</div>
                                        <div id="reportDateDisplay" style="display:none;"><%=reportDatetime%></div></td>
                                        <%
                                        } else {%>  
                                    <td><%=reportDatetime%></td>
                                    <% }
                                        } else {
                                            out.println("<td>-</td>");
                                        }%> 

                                    <td><% // action (despatch status) column 
                                        if (dispatchStatus == 1) {
                                            if (firstDespatch != null && !firstDespatch.equals("") && firstDespatch.equals(counterStr)) {%>
                                        <div id="reportStatusWaiting">Waiting..</div>
                                        <div id="reportStatusDisplay" style="display:none;">Despatched</div></td>
                                        <%
                                        } else {%> 
                                    Despatched</td>
                                    <%  }
                                    } else {
                                    %>
                                <form action="ProcessDespatch" method="POST">
                                    <input type="hidden" name="reportName" value="<%=reportName%>">
                                    <input type="hidden" name="scenarioID" value="<%=scenarioID%>">
                                    <input type="hidden" name="stateID" value="<%=report.getStateID()%>">
                                    <input type ="hidden" name="clickedID" value ="<%=counter%>">
                                    <input type="submit" id="downloadReport" class="report-despatch button tinytable" value="Despatch">
                                </form>
                                <% } %>
                                </td>

                                <td>
                                    <% // results column (link) 
                                        if (dispatchStatus == 1) {
                                            if (firstDespatch != null && !firstDespatch.equals("") && firstDespatch.equals(counterStr)) {
                                    %>

                                    <div id="reportLinkMsg">Loading..</div>
                                    <a href="<%=reportResults%>" id="reportLink" target="_blank" style="display:none;">View Report</a>
                                    <%
                                    } else {
                                    %>
                                    <a href="<%=reportResults%>" target="_blank">View Report</a>
                                    <%  }
                                        } else {
                                            out.println("N/A");

                                        }
                                    %>
                                </td>


                                </tr>

                                <%
                                            counter++;
                                        }
                                    }
                                    session.setAttribute("clickedID", "");
                                %>
                            </table>
                            <%
                                } else {
                                    // if no reports in the array
                                    out.println("No doctor's order at the moment.");

                                }
                                session.setAttribute("active", null);

                            %>  
                        </div>

                        <!--CLINICAL CHARTS-->
                        <div class="<% if (active != null && active.equals("vital")) {
                                out.println("content active");
                            } else {
                                out.println("content");
                            } %>" id="vital">

                            <%
                                Date currentDateTime = new Date();
                                DateFormat dateFormatter = new SimpleDateFormat("dd-MM-yyyy H:m:s");
                                dateFormatter.setTimeZone(TimeZone.getTimeZone("Singapore"));
                                String currentDateFormatted = dateFormatter.format(currentDateTime);

                                String temp1 = (String) session.getAttribute("temperature");
                                String HR1 = (String) session.getAttribute("HR");
                                String RR1 = (String) session.getAttribute("RR");
                                String SPO1 = (String) session.getAttribute("SPO");
                                String BPsystolic1 = (String) session.getAttribute("BPsystolic");
                                String BPdiastolic1 = (String) session.getAttribute("BPdiastolic");
                                String oralAmount1 = (String) session.getAttribute("oralAmount");
                                String oralType1 = (String) session.getAttribute("oralType");
                                String intravenousType1 = (String) session.getAttribute("intravenousType");
                                String intravenousAmount1 = (String) session.getAttribute("intravenousAmount");
                                String output1 = (String) session.getAttribute("output");

                                if (temp1 == null) {
                                    temp1 = "";
                                };
                                if (HR1 == null) {
                                    HR1 = "";
                                };
                                if (RR1 == null) {
                                    RR1 = "";
                                };
                                if (SPO1 == null) {
                                    SPO1 = "";
                                };
                                if (BPsystolic1 == null) {
                                    BPsystolic1 = "";
                                };
                                if (BPdiastolic1 == null) {
                                    BPdiastolic1 = "";
                                };
                                if (oralAmount1 == null) {
                                    oralAmount1 = " ";
                                };
                                if (oralType1 == null) {
                                    oralType1 = " ";
                                };
                                if (intravenousType1 == null) {
                                    intravenousType1 = " ";
                                };
                                if (intravenousAmount1 == null) {
                                    intravenousAmount1 = " ";
                                };
                                if (output1 == null) {
                                    output1 = " ";
                                };

                            %>
                            <input data-reveal-id="AllChart" type="submit" value="View All Charts" class="button tiny">  
                            <input data-reveal-id="IntakeOutputChart" type="submit" value="View Intake and Output Chart" class="button tiny">  

                            <form data-abide action="ProcessAddVital" method="POST">


                                <table width='65%'>
                                    <br/>
                                    <col width="35%">  
                                    <col width="65%">  

                                    <tr><td><b>Temperature</b><a href="#" data-reveal-id="tempchart" style="color:green"><br><i><u>View Temperature history</u></i></a></td>
                                        <td><div class="row">
                                                <div class="small-4 columns" style="width:200px">
                                                    <!--validates for 1 decimal place-->
                                                    <input type="text" name ="temperature" maxlength="4" pattern ="\b(3[4-9](\.[0-9]{1,2})?|4[0-2])(\.[0-9]{1,2})?$\b"  value="<%=temp1%>"/>
                                                    <small class="error">Temperature must be between 34 - 42.</small>
                                                </div>
                                                <label for="right-label" class="left inline">ºC</label>
                                            </div></td>
                                    </tr> 

                                    <tr><td><b>Respiratory Rate</b><a href="#" data-reveal-id="RRchart" style="color:green"><br><i><u>View RR history</u></i></a></a></td>
                                        <td><div class="row">
                                                <div class="small-4 columns" style="width:200px">
                                                    <input type="text" name ="RR" maxlength="2" pattern ="^([0-9]|[1-5][0-9]|60)$" value="<%=RR1%>"/>
                                                    <small class="error">Respiratory Rate must be between 0 - 60.</small>
                                                </div>

                                                <label for="right-label" class="left inline">breaths/min</label>

                                            </div>
                                    </tr>

                                    <tr><td><b>Heart Rate</b><a href="#" data-reveal-id="HRchart" style="color:green"><br><i><u>View Heart Rate history</u></i></a></td>
                                        <td><div class="row">
                                                <div class="small-4 columns" style="width:200px">
                                                    <!--validates between 0 - 200-->
                                                    <input type="text" name ="HR" maxlength ="3" pattern ="^([0-9]{1,2}|1[0-9]{2}|200)$" value="<%=HR1%>"/>
                                                    <small class="error">Heart Rate must be between 0 - 200.</small>
                                                </div>
                                                <label for="right-label" class="left inline">beats/min</label>
                                            </div></td>
                                    </tr>

                                    <tr><td><b>Blood Pressure</b><a href="#" data-reveal-id="BPchart" style="color:green"><br><i><u>View BP history</u></i></a></td>
                                        <td><div class="row">
                                                <div class="small-4 columns" style="width:200px">
                                                    <!--<input type="text" name ="BPsystolic" style="width:200px" value= "0" maxlength = "3" pattern = "^(\d{2,3}|\d{2})$"/>-->
                                                    <input type="text" name ="BPsystolic" maxlength = "3" pattern = "^([0-9]{1,2}|[12][0-9]{2}|300)$" value="<%=BPsystolic1%>"/>
                                                    <small class="error">BP systolic must be numeric and between 0 - 300.</small>
                                                </div>

                                                <label for="right-label" class="left inline">mmHg (Systolic)</label>

                                            </div>
                                            <div class="row">
                                                <div class="small-4 columns" style="width:200px">
                                                    <!--<input type="text" name ="BPdiastolic" style="width:200px" value= "0" maxlength = "3" pattern = "^(\d{2,3}|\d{2})$"/>-->
                                                    <input type="text" name ="BPdiastolic" maxlength = "3" pattern = "^([0-9]{1,2}|1[0-9]{2}|200)$" value="<%=BPdiastolic1%>"/>
                                                    <div class ="input wrapper">
                                                        <small class="error">BP diastolic must be numeric and between 0 - 200.</small>
                                                    </div>
                                                </div>

                                                <label for="right-label" class="left inline">mmHg (Diastolic)</label>

                                            </div>
                                        </td></tr>
                                    <tr><td><b>SpO<sub>2</sub></b><a href="#" data-reveal-id="SPOchart" style="color:green"><br><i><u>View SpO<sub>2</sub> history</u></i></a></td>


                                        <td><div class="row">
                                                <div class="small-4 columns" style="width:200px">
                                                    <input type="text" name ="SPO" maxlength = "3" pattern ="^[0-9][0-9]?$|^100$" value="<%=SPO1%>"/>
                                                    <small class="error">SPO must be numeric and between 0 - 100%.</small>
                                                </div>

                                                <label for="right-label" class="left inline">%</label>

                                            </div></td></tr>
                                    <tr><td><b>Intake - Oral/Intragastric</b><a href="#" data-reveal-id="IntakeOutputChart" style="color:green"><br><i><u>View past records</u></i></a></td>

                                        <td><div class="row">
                                                <div class="small-4 columns" style="width:200px">
                                                    <input type="text" name ="oralType" value= "<%=oralType1%>"/>
                                                </div>

                                                <label for="left-label" class="left inline">Type</label>

                                            </div>
                                            <div class="row">
                                                <div class="small-4 columns" style="width:200px">
                                                    <input type="text" name ="oralAmount"  value="<%=oralAmount1%>"/>
                                                </div>

                                                <label for="left-label" class="left inline">Amount Taken</label>

                                            </div>
                                        </td></tr>

                                    <tr><td><b>Intake - Intravenous</b><a href="#" data-reveal-id="IntakeOutputChart" style="color:green"><br><i><u>View past records</u></i></a></td>

                                        <td><div class="row">
                                                <div class="small-4 columns" style="width:200px">
                                                    <input type="text" name ="intravenousType" value="<%=intravenousType1%>"/>
                                                </div>

                                                <label for="left-label" class="left inline">Type</label>

                                            </div>
                                            <div class="row">
                                                <div class="small-4 columns" style="width:200px">
                                                    <input type="text" name ="intravenousAmount"  value="<%=intravenousAmount1%>" />
                                                </div>

                                                <label for="left-label" class="left inline">Amount Infused</label>

                                            </div>
                                        </td></tr>

                                    <tr><td><b>Output</b><a href="#" data-reveal-id="IntakeOutputChart" style="color:green"><br><i><u>View past records</u></i></a></td>

                                        <td><div class="row">
                                                <div class="small-4 columns" style="width:200px">
                                                    <input type="text" name ="output" style="width:170px" value= "<%=output1%>"/>
                                                </div>
                                                <label for="left-label" class="left inline"></label>
                                            </div>
                                        </td></tr>

                                </table><br/><br/><br/>
                                <input type ="hidden" value ="<%=scenarioID%>" name = "scenarioID">
                                <input type="submit" value="Update Vital Signs" class="button"> 
                            </form>
                        </div>


                        <!--MEDICATIONS-->
                        <div class="<% if (active != null && active.equals(
                                    "medication")) {
                                out.println("content active");
                            } else {
                                out.println("content");
                            }%>" id="medication">

                            <h4>Step 1: Scan Patient's Barcode > Step 2: Scan Medicine's Barcode > Step 3: Administer Medicine </h4>
                            <input data-reveal-id="medicationHistory" type="submit" value="View Medication History" class="button tiny">  

                            <!--Start of Reveal Modal for Medication History-->
                            <div id="medicationHistory" class="reveal-modal" data-reveal>
                                <h2>Medication History</h2>

                                <%
                                    List<MedicationHistory> medicationHistoryList = MedicationHistoryDAO.retrieveAll(scenarioID);
                                    if (medicationHistoryList == null || medicationHistoryList.size() == 0) {
                                        out.println("<h5>There are no record at the moment</h5>");
                                    } else { %>
                                <table>
                                    <tr>
                                        <td><b>Date Administered</b></td>
                                        <td><b>Medicine Barcode</b></td>
                                        <td><b>Administered By</b></td>
                                    </tr>
                                    <%
                                        DateFormat dateFormatterFprMedicationHistory = new SimpleDateFormat("dd-MM-yyyy hh:mm a");

                                        for (MedicationHistory medicationHistory : medicationHistoryList) {%>
                                    <tr>
                                        <td><%=dateFormatterFprMedicationHistory.format(medicationHistory.getMedicineDatetime())%></td>
                                        <td><%=medicationHistory.getMedicineBarcode()%></td>
                                        <td><%=session.getAttribute("nurse")%></td>
                                    </tr> 
                                    <% }

                                    %>
                                </table>
                                <% }
                                %>
                                <a class="close-reveal-modal">&#215;</a>
                            </div>
                            <!--End of Reveal Modal for Medication History-->


                            <%
                                // to store prescriptions of all activated states
                                LinkedHashMap<List<Prescription>, String> prescriptionHM = new LinkedHashMap<List<Prescription>, String>();
                                // remove duplicates
                                List<String> tempPrescriptionList = new ArrayList<String>();
                                // remove duplicates and add reports of that state into array reports
                                for (Map.Entry<String, String> entry : activatedStates.entrySet()) {
                                    String state = entry.getKey();
                                    if (tempPrescriptionList.size() == 0) {
                                        tempPrescriptionList = new ArrayList<String>();
                                    }
                                    if (tempPrescriptionList.contains(state)) {
                                        activatedStates.remove(state);
                                    } else {
                                        tempPrescriptionList.add(state);
                                        List<Prescription> prescriptions = PrescriptionDAO.retrieve(scenarioID, state);
                                        String doctorOrderTime = entry.getValue();
                                        if (prescriptions != null && prescriptions.size() != 0) {
                                            prescriptionHM.put(prescriptions, doctorOrderTime);
                                        }
                                    }
                                }

                                if (prescriptionHM == null || prescriptionHM.size() == 0) {
                                    out.println("There are no prescription(s) at the moment. ");
                                } else {%>
                            <h4>Step 1: Scan Patient's Barcode</h4>     
                            <%
                                String patientBarcodeInput = (String) session.getAttribute("patientBarcodeInput");
                                String isPatientVerified = (String) session.getAttribute("isPatientVerified");
                                String medicineBarcodeDisabled = "";
                                String patientBarcodeDisabled = "";

                                //patient is verified, enable the medicine textbox
                                if (isPatientVerified != null) {
                                    medicineBarcodeDisabled = "";
                                    patientBarcodeDisabled = "disabled";
                                    patientBarcodeInput = patientBarcodeInput;
                                }

                            %>

                            <form action = "ProcessPatientBarcode" method = "POST" name = "medicationTab">
                                <%                                        if (patientBarcodeInput == null) {
                                        patientBarcodeInput = "";
                                    } else if (patientBarcodeInput == "") {
                                        patientBarcodeInput = "";
                                    } else {
                                        patientBarcodeDisabled = "disabled";
                                    }
                                %>

                                <div class="small-8">
                                    <div class="small-3 columns">
                                        <label for="right-label" class="right inline">Patient's Barcode</label>
                                    </div>
                                    <div class="small-9 columns">
                                        <input type="hidden" name = "patientBarcode" id="patientBarcode" value = "<%=patientNRIC%>">
                                        <input type="text" value = "<%=patientBarcodeInput%>" name = "patientBarcodeInput" <%=patientBarcodeDisabled%>/>
                                    </div>
                                </div>       
                            </form>
                            <br><br><p><br>

                            <div class="large-centered large-12 columns">
                                <hr>
                            </div><br><br/>

                            <h4>Step 2: Scan Medicine Barcode</h4>
                            <table style="border:none; border-top:#368a55 solid 1px; border-bottom:#368a55 solid 1px">
                                <tr>
                                    <td><b>Medicine Barcode</b></td>
                                    <td><b>Medicine Name<b></td>
                                                <td><b>Route</b></td>
                                                <td><b>Dosage</b></td>
                                                <td><b>Frequency</b></td>
                                                <td><b>Doctor Name/MCR No.</b></td>
                                                <td><b>Remarks</b></td>
                                                <td><b>Verified</b></td>
                                                <td><b>Discontinued</b></td>
                                                </tr>

                                                <tr>
                                                    <%
                                                        //taken from processMedicineBarcode
                                                        ArrayList<String> medicineVerifiedList = (ArrayList<String>) session.getAttribute("medicineVerifiedList");
                                                        
                                                        if(medicineVerifiedList != null){
                                                             if (medicineVerifiedList.size() != 1) { //then take the values from ProcessMedicineBarcode
                                                            medicineVerifiedList = (ArrayList<String>) session.getAttribute("medicineVerifiedListReturned");
                                                            }  
                                                        }
                                                        
                                                       
                                                        ArrayList<StateHistory> stateHistoryList = StateHistoryDAO.retrieveStateHistory();

                                                        //Check if medicine has been discontinued
                                                        ArrayList<String> activatedStateList = new ArrayList<String>();
                                                        for (StateHistory stateHistory : stateHistoryList) {
                                                            //out.println(stateHistory.getStateID());
                                                            activatedStateList.add(stateHistory.getStateID());
                                                        }

                                                        //loop through every medication
                                                        for (Map.Entry<List<Prescription>, String> entry : prescriptionHM.entrySet()) {
                                                            List<Prescription> statePrescription = entry.getKey();

                                                            //Display Prescriptions
                                                            for (Prescription prescription : statePrescription) {
                                                               
                                                                if (!prescription.getMedicineBarcode().equals("NA")) {
                                                                    String doctorOrder = prescription.getDoctorOrder();
                                                                    String medicineBarcodeInput = (String) session.getAttribute("medicineBarcodeInput");
                                                                    if (medicineBarcodeInput == null) {
                                                                        medicineBarcodeInput = "";
                                                                    }
                                                                    String discontinueState = prescription.getDiscontinueState();


                                                    %>


                                                    <%      
                                                            if (discontinueState != null) {
                                                            //has been activated, disable the textbox
                                                            if (activatedStateList.contains(discontinueState)) {
                                                                medicineBarcodeDisabled = "disabled";

                                                            }
                                                        }

                                                    %>
                                                    <td>   
                                                        <form action = "ProcessMedicineBarcode" method = "POST">
                                                            <div class="password-confirmation-field">
                                                                <input type="hidden" name = "medicineBarcode" id="medicineBarcode" value = "<%=prescription.getMedicineBarcode()%>">

                                                                <input type="text" name = "medicineBarcodeInput" value = "<%=medicineBarcodeInput%>"  <%=medicineBarcodeDisabled%>>
                                                            </div>
                                                        </form>
                                                    </td>
                                                    <%//reset it back to enabled
                                                        medicineBarcodeDisabled = "";
                                                    %>
                                                    <td>
                                                        <%=MedicineDAO.retrieve(prescription.getMedicineBarcode()).getMedicineName()%>
                                                    </td>

                                                    <td>
                                                        <%
                                                            String medicineBarcode = prescription.getMedicineBarcode();
                                                            if (medicineBarcode != null) {
                                                               // Prescription presc= PrescriptionDAO.retrieve(scenarioID, stateID, medicineBarcode, doctorOrder);
                                                               // out.println(presc.getRouteAbbr());
                                                                
                                                                out.println(prescription.getRouteAbbr());
                                                                //Medicine medicine = MedicineDAO.retrieve(medicineBarcode);
                                                                //out.println(medicine.getRouteAbbr());
                                                            }

                                                        %> 

                                                    </td>
                                                    <td><%
                                                            //MedicinePrescriptionDAO.retrieve(prescription.getMedicineBarcode()).getDosage();
                                                            
                                                           // Prescription presc= PrescriptionDAO.retrieve(scenarioID, stateID, medicineBarcode, doctorOrder);
                                                           // out.println(presc.getDosage());
                                                            
                                                            out.println(prescription.getDosage());
                                                        %>
                                                    </td>


                                                    <td><%=prescription.getFreqAbbr()%></td>                                          
                                                    <td>Dr.Tan/01234Z</td>
                                                    <td><%=prescription.getDoctorOrder()%></td>
                                                    <td>
                                                        <%
                                                            if(medicineVerifiedList != null){
                                                              if (medicineVerifiedList.contains(medicineBarcode)) {
                                                                %>
                                                                <b><font color="#368a55"> YES</font></b>
                                                                <img src="img/verified.gif" width = "15" height = "15"/>

                                                        <%} }
                                                        %>  
                                                         
                                                           
                                                    </td>
                                                    <td>
                                                        <%
                                                            if (activatedStateList.contains(discontinueState)) {
                                                                out.println("YES");
                                                            }
                                                        %>
                                                    </td>

                                                </tr>    
                                                <%
                                                            }
                                                        }

                                                        session.removeAttribute("patientBarcodeInput");
                                                    }
                                                    session.removeAttribute("isMedicationVerified");
                                                %>
                                                </table>
                                                <%
                                                    } //end of else statement

                                                   // ArrayList<MedicinePrescription> medicinePrescriptionList = MedicinePrescriptionDAO.retrieve(scenarioID, stateID);
                                                %>


                                                <br>
                                                <%if (prescriptionHM.size() != 0) {%>

                                                <div class="large-centered large-12 columns">
                                                    <hr>
                                                </div><br><br/>

                                                <h4>Step 3: Administer Medicine</h4>
                                                <font color ="red">Click "Administer Medicine" once you are done scanning with the medicine(s). Medicine will be added to history once "Administer" is clicked.</font><br><br>   

                                                <form action ="ProcessAdministerMedicine" method="post">
                                                    <input type = "submit" class="deletebutton tiny" onclick="if (!administerConfirmation())
                    return false" value="Administer Medicine" ><br>   
                                                </form>
                                                <%}

                                                %>

                                                </div> 
                                                <!--End of medication tab-->

                                                <!--MULTIDISCIPLINARY NOTES-->
                                                <div class="<% if (active != null && active.equals(
                                                            "multidisciplinary")) {
                                                        out.println("content active");
                                                    } else {
                                                        out.println("content");
                                                    }%>" id="multidisciplinary">

                                                    <input data-reveal-id="pastDoctorOrder" type="submit" value="View Doctor's Order" class="button tiny">  

                                                    <form action="ProcessAddNote" method="POST">
                                                        <%
                                                            String grpNames = (String) session.getAttribute("grpNames");
                                                            String notes = (String) session.getAttribute("notes");

                                                        %> 

                                                        <h4>Enter New Multidisciplinary Notes</h4><br>
                                                        <div id="newNotes" class="content">
                                                            <div class="large-centered large-6 columns">

                                                                <label style="text-align:left">Nurses in-charge</label>
                                                                <input type ="hidden" name="scenarioID" value="<%=scenarioID%>"/>
                                                                <input type ="text" id= "grpNames" name="grpNames" value="<% if (grpNames == null || grpNames == "") {
                                                                        out.print("");
                                                                    } else {
                                                                        out.print(grpNames);
                                                                    }%>" >

                                                                <label style="text-align:left">Multidisciplinary Notes</label>
                                                                <textarea name="notes" id="notes" rows="7" cols="10" ><% if (notes == null || notes == "") {
                                                                        out.print("");
                                                                    } else {
                                                                        out.print(notes);
                                                                    }%></textarea>
                                                            </div>
                                                            <br>
                                                            <input type="submit" name="buttonChoosen" value="Save" class="button tiny"> 
                                                            <input type="submit" name="buttonChoosen" value="Submit" class="button tiny"> 

                                                        </div>  
                                                    </form>

                                                    <div class="large-centered large-12 columns">
                                                        <hr>
                                                    </div><br><br/>
                                                    <h4>Multidisciplinary Notes History</h4><br> 
                                                    <%
                                                        if (notesListRetrieved == null || notesListRetrieved.size() == 0) {%>
                                                    <label for="right-label" class="right inline"><h5><center>No past notes yet.</center></h5></label>
                                                    <% } else { %> <br/>
                                                    <!--TABLE-->
                                                    <table class="responsive" id="cssTable">
                                                        <col width="20%">
                                                        <col width="30%">
                                                        <col width="15%">
                                                        <thead>
                                                            <tr>
                                                                <th>Nurses In-Charge</th>
                                                                <th>Multidisciplinary Notes</th>
                                                                <th>Time Submitted</th>
                                                            </tr>
                                                        </thead>
                                                        <%
                                                                DateFormat df = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
                                                                //String reportDatetime = df.format(notesRetrieve.getNoteDatetime());
                                                                for (int i = notesListRetrieved.size() - 1; i >= 0; i--) {
                                                                    Note notesRetrieve = notesListRetrieved.get(i);
                                                                    // out.print("<b>Practical Group: </b>" + notes.getPracticalGroupID() + "<br>");
                                                                    out.println("<tr>");
                                                                    out.print("<td>" + notesRetrieve.getGrpMemberNames() + "</td>");
                                                                    out.print("<td>" + notesRetrieve.getMultidisciplinaryNote() + "</td>");
                                                                    out.print("<td>" + df.format(notesRetrieve.getNoteDatetime()) + "</td>");
                                                                    out.println("</tr>");
                                                                }

                                                            }//end of else %>

                                                    </table>
                                                </div>
                                                <!--DOCUMENTS-->
                                                <div class="<% 
                                                    if (active != null && active.equals("documents")) {
                                                        out.println("content active");
                                                    } else {
                                                        out.println("content");
                                                    } %>" id="documents">

                                                    <h4>Documents</h4><br/>

                                                    <%

                                                        List<Document> documents = DocumentDAO.retrieveDocumentsByScenario(scenarioID);

                                                        //List<Document> documentList = DocumentDAO.retrieveDocumentsByState(scenarioID, stateID);
                                                        if (documents != null && documents.size() != 0) {
                                                    %>

                                                    <table>
                                                        <tr>
                                                            <td><b>Document name</b></td>
                                                            <td><b>Action</b></td>
                                                        </tr>

                                                        <%
                                                            // Create an instance of SimpleDateFormat used for formatting 
                                                            // the string representation of date (month/day/year)
                                                            DateFormat df = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
                                                            //String firstObtain = (String) session.getAttribute("obtained");
                                                            for (Document document : documents) {
                                                                String consentName = document.getConsentName();
                                                                String consentFile = document.getConsentFile();
                                                                String consentResults = "";
                                                                consentResults = "documents/" + consentFile;
                                                        %> 
                                                        <tr>
                                                            <td><%=consentName%></td>
                                                            <td>
                                                                <!-- // results column (link) -->
                                                                <a href="<%=consentResults%>" target="_blank">View Form</a>
                                                            </td>
                                                        </tr>
                                                        <%
                                                                }
                                                            } else {
                                                                out.println("No documents at the moment.");
                                                            }
                                                        %>  </table>
                                                </div>  
                                                <!-- Reveal model for past doctor orders -->
                                                <div id="pastDoctorOrder" class="reveal-modal large-10" data-reveal>
                                                    <h4>Past Doctor Orders</h4>

                                                    <%
                                                        LinkedHashMap<List<Prescription>, String> stateDoctorOrderHM = new LinkedHashMap<List<Prescription>, String>();
                                                        for (Map.Entry<String, String> entry : activatedStates.entrySet()) {

                                                            String state = entry.getKey();
                                                            List<Prescription> prescriptions = PrescriptionDAO.retrieveOnlyNA(scenarioID, state);
                                                            String doctorOrderTime = entry.getValue();
                                                            if (prescriptions != null && prescriptions.size() != 0) {
                                                                stateDoctorOrderHM.put(prescriptions, doctorOrderTime);
                                                            }
                                                        }
                                                        if (stateDoctorOrderHM != null && stateDoctorOrderHM.size() != 0) {
                                                    %>
                                                    <table>
                                                        <tr>
                                                            <td><b>Doctor Name</b></td>
                                                            <td><b>Doctor Order</b></td>
                                                            <td><b>Ordered Time</b></td>
                                                        </tr>

                                                        <%
                                                            for (Map.Entry<List<Prescription>, String> entry : stateDoctorOrderHM.entrySet()) {
                                                                List<Prescription> prescriptions = entry.getKey();

                                                                // if needed to display:
                                                                String doctorOrderTime = entry.getValue();

                                                                for (Prescription prescription : prescriptions) {
                                                                    String doctorName = prescription.getDoctorName();
                                                                    String doctorOrder = prescription.getDoctorOrder();
                                                        %>
                                                        <tr>
                                                            <td><%=doctorName%></td>
                                                            <td><%=doctorOrder%></td>
                                                            <td><%=doctorOrderTime%></td>
                                                        </tr>
                                                        <%
                                                                }
                                                            }
                                                        %>

                                                    </table>

                                                    <%
                                                        }
                                                    %>    


                                                    <a class="close-reveal-modal">&#215;</a>

                                                </div>

                                                <!-- Reveal model for temperature chart -->
                                                <div id="tempchart" class="reveal-modal large-10" data-reveal>

                                                    <iframe src = "viewHistoricalTemp.jsp" frameborder ="0" width = "1000" height = "400"></iframe> 
                                                    <a class="close-reveal-modal">&#215;</a>

                                                </div>


                                                <!-- Reveal model for Respiratory chart -->
                                                <div id="RRchart" class="reveal-modal large-10" data-reveal>

                                                    <iframe src = "viewHistoricalRR.jsp" frameborder ="0" width = "1000" height = "400"></iframe> 
                                                    <a class="close-reveal-modal">&#215;</a>

                                                </div>


                                                <!-- Reveal model for Heart Rate chart -->
                                                <div id="HRchart" class="reveal-modal large-10" data-reveal>

                                                    <iframe src = "viewHistoricalHR.jsp" frameborder ="0" width = "1000" height = "400"></iframe> 
                                                    <a class="close-reveal-modal">&#215;</a>

                                                </div>
                                                <div id="BPchart" class="reveal-modal large-10" data-reveal>
                                                    <!-- Reveal model for Blood Pressure chart -->
                                                    <iframe src = "viewHistoricalBP.jsp" frameborder ="0" width = "1000" height = "400"></iframe> 
                                                    <a class="close-reveal-modal">&#215;</a>

                                                </div>

                                                <!-- Reveal model for SPO chart -->
                                                <div id="SPOchart" class="reveal-modal large-10" data-reveal>

                                                    <iframe src = "viewHistoricalSPO.jsp" frameborder ="0" width = "1000" height = "400"></iframe> 
                                                    <a class="close-reveal-modal">&#215;</a>

                                                </div>
                                                <div id="AllChart" class="reveal-modal large-10" data-reveal>

                                                    <iframe src = "viewAllChart.jsp" frameborder ="0" width = "1000" height = "900"></iframe> 
                                                    <a class="close-reveal-modal">&#215;</a>

                                                </div>

                                                <!-- Reveal model for Intake and Output chart -->
                                                <div id="IntakeOutputChart" class="reveal-modal large-10" data-reveal>

                                                    <h3>Intake and Output Chart</h3>

                                                    <%
                                                        List<Vital> oralIntakeList = VitalDAO.retrieveIntakeOutputHistoryByScenarioID(scenarioID);

                                                        DateFormat df = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
                                                        if (oralIntakeList.size() == 0) {
                                                            out.println("<h5>There is no historial data at the moment.</h5>");
                                                        } else {
                                                    %>

                                                    <table>
                                                        <tr>
                                                            <td></td>
                                                            <td colspan="4"><center><b>INTAKE</b></center></td>
                                                        <td colspan="4"><center><b>OUTPUT</b></center></td>
                                                        </tr>
                                                        <tr>
                                                            <td><b>Time taken</b></td>
                                                            <td><b>Oral Intake</b></td>
                                                            <td><b>Oral Intake Amount</b></td>
                                                            <td><b>Intravenous Intake</b></td>
                                                            <td><b>Intravenous Intake Amount</b></td>
                                                            <td><b>Output</b></td>
                                                        </tr>
                                                        <%
                                                            for (Vital vital : oralIntakeList) {
                                                                String oralType = vital.getOralType();
                                                                String oralAmount = vital.getOralAmount();
                                                                String intravenousType = vital.getIntravenousType();
                                                                String intravenousAmount = vital.getIntravenousAmount();
                                                                String output = vital.getOutput();
                                                                Date oralDate = vital.getVitalDatetime();
                                                                String vitalDatetime = df.format(oralDate);
                                                        %>
                                                        <tr>
                                                            <td><%=vitalDatetime%></td>
                                                            <td><%=oralType%></td>
                                                            <td><%=oralAmount%></td>
                                                            <td><%=intravenousType%></td>
                                                            <td><%=intravenousAmount%></td>
                                                            <td><%=output%></td>
                                                        </tr>
                                                        <%}
                                                            }
                                                        %>

                                                    </table>

                                                    <a class="close-reveal-modal">&#215;</a>

                                                </div>

                                                <% }
                                                
                                                %>
                                                </div>
                                                </div>
                                                <% }
                                                
                                                %>

                                                </div>


                                                </div>

                                                <!--RESPONSIVE. END OF WEB VERSION HERE-->

                                                <!--RESPONSIVE. START OF iTOUCH VERSION HERE-->

                                                <div class ="show-for-small-only">

                                                    <%
                                                        //get the most recently activated scenario's state
                                                if (scenarioActivated == null) {
                                                    out.println("<center>No Case/States Activated<br>Please contact administrator/lecturer for case activation.</center>");
                                                } else {
                                                    retrieveScenarioState = StateDAO.retrieveActivateState(scenarioActivated.getScenarioID());
                                                        if (scenarioActivated == null || retrieveScenarioState == null) {
                                                        
                                                         %>
                                                         <center><h1>No Case/States Activated</h1>
                                                             Please contact administrator/lecturer for case activation.</center>

                                                    <%} else {  
                                                        String stateID = retrieveScenarioState.getStateID();
                                                        //get the most recently activated scenario's state
                                                        retrieveScenarioState = StateDAO.retrieveActivateState(scenarioActivated.getScenarioID());

                                                        patientNRIC = retrieveScenarioState.getPatientNRIC();
                                                        retrievePatient = PatientDAO.retrieve(patientNRIC);

                                                        
                                                        String scenarioID = scenarioActivated.getScenarioID();

                                                        //retrieve case's information
                                                        String admissionNotes = scenarioActivated.getAdmissionNote();

                                                        //retrieve nurse praticalGroup ID
                                                        String practicalGrp = (String) session.getAttribute("nurse");

                                                        //retrieve note's information
                                                        List<Note> notesListRetrieved = NoteDAO.retrieveNotesByPraticalGrp(practicalGrp, scenarioID);

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


                                                    %>


                                                    <dl class="accordion" data-accordion>
                                                        <dd class="accordion-navigation">
                                                            <a href="#panel1">Patient's Information</a>
                                                            <div id="panel1" class="content active">
                                                                <ul class="pricing-table">
                                                                    <li class="price"><%=fullName%></li>
                                                                    <li class="bullet-item"><%=patientNRIC%></li>
                                                                    <li class="bullet-item"><%=dob%></li>
                                                                    <li class="bullet-item"><%=gender%></li>
                                                                    <li class="bullet-item"><font color="red"><%=allergy%></font></li>
                                                                </ul>
                                                            </div>
                                                        </dd>
                                                        <dd class="accordion-navigation">
                                                            <a href="#panel2">Admission Notes</a>
                                                            <div id="panel2" class="content">
                                                                <%=scenarioActivated.getAdmissionNote()%>
                                                            </div>
                                                        </dd>

                                                        <dd class="accordion-navigation">
                                                            <a href="#panel7">Investigations</a>
                                                            <div id="panel7" class="content">
                                                                <ul class="pricing-table">
                                                                    <li class="price">Despatched Reports</li>
                                                                        <%
                                                                            List<Report> reportList = ReportDAO.retrieveDespatchedReportsByScenario(scenarioID);
                                                                            DateFormat dateFormatterForReport = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");

                                                                            if (reportList == null || reportList.size() == 0) {
                                                                                out.println("<center>There are no records at the moment</center>");
                                                                            } else {

                                                                                for (Report report : reportList) {
                                                                                    String reportName = report.getReportName() + " | ";
                                                                                    String reportFile = "reports/" + report.getReportFile();
                                                                        %>

                                                                    <li class="bullet-item"> <%=reportName%>
                                                                        <a href="<%=reportFile%>" target="_blank">View Report</a>
                                                                    </li>
                                                                    <%}
                                                                        }

                                                                    %>
                                                                </ul>

                                                            </div>
                                                        </dd>



                                                        <dd class="accordion-navigation">
                                                            <a href="#panel3">Clinical Charts</a>
                                                            <div id="panel3" class="content">

                                                                <ul class="pricing-table">
                                                                    <li class="price">Last Updated Vitals</li>        
                                                                    Historical vital signs are only available in web version.   
                                                                    <%                                                                        List<Vital> vitalList = VitalDAO.retrieveAllVitalByScenarioID(scenarioID);
                                                                        if (vitalList != null) {

                                                                    %>
                                                                    <li class="bullet-item">Temperature - <%=vitalList.get(vitalList.size() - 1).getTemperature()%></li>  
                                                                    <li class="bullet-item">Respiratory Rate - <%=vitalList.get(vitalList.size() - 1).getRr()%></li>  
                                                                    <li class="bullet-item">Heart Rate - <%=vitalList.get(vitalList.size() - 1).getHr()%></li>  
                                                                    <li class="bullet-item">BP(Systolic) - <%=vitalList.get(vitalList.size() - 1).getBpSystolic()%></li>  
                                                                    <li class="bullet-item">BP(Diastolic) - <%=vitalList.get(vitalList.size() - 1).getBpDiastolic()%></li>  
                                                                    <li class="bullet-item">SpO<sub>2</sub> - <%=vitalList.get(vitalList.size() - 1).getSpo()%></li>  
                                                                        <%}%>


                                                                </ul>  

                                                                <ul class="pricing-table">
                                                                    <li class="price">Intake - Oral</li>        
                                                                        <%
                                                                            List<Vital> intakeOralList = VitalDAO.retrieveIntakeOralByScenarioID(scenarioID);
                                                                            if (intakeOralList == null || intakeOralList.size() == 0) {
                                                                                out.println("<center>There are no records at the moment</center>");
                                                                            } else {
                                                                                DateFormat dateFormatterForIntake = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");

                                                                                for (Vital intakeOutput : intakeOralList) {
                                                                                    String medicationHistoryInformation = intakeOutput.getOralType() + " | " + intakeOutput.getOralAmount();

                                                                        %>

                                                                    <li class="bullet-item"><b><%=dateFormatterForIntake.format(intakeOutput.getVitalDatetime())%></b><br><%=medicationHistoryInformation%></li>
                                                                            <% }
                                                                                } %>

                                                                </ul>  


                                                                <ul class="pricing-table">
                                                                    <li class="price">Intake - Intravenous</li>        
                                                                        <%
                                                                            List<Vital> intakeIntravenousList = VitalDAO.retrieveIntakeIntraByScenarioID(scenarioID);
                                                                            if (intakeIntravenousList == null || intakeIntravenousList.size() == 0) {
                                                                                out.println("<center>There are no records at the moment</center>");
                                                                            } else {
                                                                                DateFormat dateFormatterForIntakeIntra = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");

                                                                                for (Vital intakeIntravenous : intakeIntravenousList) {
                                                                                    String medicationHistoryInformation = intakeIntravenous.getIntravenousType() + " | " + intakeIntravenous.getIntravenousAmount();

                                                                        %>

                                                                    <li class="bullet-item"><b><%=dateFormatterForIntakeIntra.format(intakeIntravenous.getVitalDatetime())%></b><br><%=medicationHistoryInformation%></li>
                                                                            <% }
                                                                                } %>

                                                                </ul> 

                                                                <ul class="pricing-table">
                                                                    <li class="price">Output</li>        
                                                                        <%
                                                                            List<Vital> outputList = VitalDAO.retrieveOutputByScenarioID(scenarioID);
                                                                            if (outputList == null || outputList.size() == 0) {
                                                                                out.println("<center>There are no records at the moment</center>");
                                                                            } else {
                                                                                DateFormat dateFormatterForOutput = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");

                                                                                for (Vital output : outputList) {
                                                                                    String medicationHistoryInformation = output.getOutput();

                                                                        %>

                                                                    <li class="bullet-item"><b><%=dateFormatterForOutput.format(output.getVitalDatetime())%></b><br><%=medicationHistoryInformation%></li>
                                                                            <% }
                                                                                } %>

                                                                </ul>  
                                                            </div>
                                                        </dd>

                                                        <dd class="accordion-navigation">
                                                            <a href="#panel4">Medication History</a>
                                                            <div id="panel4" class="content">
                                                                Sorry, you have no access to medication. Medication is only available in the web. 
                                                                <ul class="pricing-table">

                                                                    <li class="price">Medication History</li>           
                                                                        <%
                                                                            List<MedicationHistory> medicationHistoryList = MedicationHistoryDAO.retrieveAll(scenarioID);
                                                                            if (medicationHistoryList == null || medicationHistoryList.size() == 0) {
                                                                                out.println("<center>There are no records at the moment</center>");
                                                                            } else {
                                                                                DateFormat dateFormatterForMedicationHistory = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");

                                                                                for (MedicationHistory medicationHistory : medicationHistoryList) {
                                                                                    String medicationHistoryInformation = medicationHistory.getMedicineBarcode() + " | " + session.getAttribute("nurse");

                                                                        %>

                                                                    <li class="bullet-item"><b><%=dateFormatterForMedicationHistory.format(medicationHistory.getMedicineDatetime())%></b><br><%=medicationHistoryInformation%></li>
                                                                            <% }
                                                                                } %>

                                                                </ul>      

                                                                <ul class="pricing-table">
                                                                    <li class="price">Doctor's Order</li>

                                                                    <%if (StateHistoryDAO.retrieveAll().isEmpty()) {
                                                                            StateHistoryDAO.addStateHistory(scenarioID, stateID);
                                                                        }
                                                                        HashMap<String, String> activatedStates = StateHistoryDAO.retrieveAll();
                                                                        // to store reports of all activated states
                                                                        HashMap<List<Report>, String> stateReportsHM = new HashMap<List<Report>, String>();
                                                                        // remove duplicates
                                                                        List<String> tempList = new ArrayList<String>();
                                                                        // remove duplicates and add reports of that state into array reports
                                                                        for (Map.Entry<String, String> entry : activatedStates.entrySet()) {
                                                                            String state = entry.getKey();
                                                                            if (tempList.size() == 0) {
                                                                                tempList = new ArrayList<String>();
                                                                            }
                                                                            if (tempList.contains(state)) {
                                                                                activatedStates.remove(state);
                                                                            } else {
                                                                                tempList.add(state);
                                                                                List<Report> reports = ReportDAO.retrieveReportsByState(scenarioID, state);
                                                                                String doctorOrderTime = entry.getValue();
                                                                                if (reports != null && reports.size() != 0) {
                                                                                    stateReportsHM.put(reports, doctorOrderTime);
                                                                                }
                                                                            }
                                                                        }

                                                                        LinkedHashMap<List<Prescription>, String> stateDoctorOrderHM = new LinkedHashMap<List<Prescription>, String>();
                                                                        for (Map.Entry<String, String> entry : activatedStates.entrySet()) {

                                                                            String state = entry.getKey();
                                                                            List<Prescription> prescriptions = PrescriptionDAO.retrieveOnlyNA(scenarioID, state);
                                                                            String doctorOrderTime = entry.getValue();
                                                                            if (prescriptions != null && prescriptions.size() != 0) {
                                                                                stateDoctorOrderHM.put(prescriptions, doctorOrderTime);
                                                                            }
                                                                        }
                                                                        if (stateDoctorOrderHM != null && stateDoctorOrderHM.size() != 0) {

                                                                            for (Map.Entry<List<Prescription>, String> entry : stateDoctorOrderHM.entrySet()) {
                                                                                List<Prescription> prescriptions = entry.getKey();

                                                                                // if needed to display:
                                                                                String doctorOrderTime = entry.getValue();

                                                                                for (Prescription prescription : prescriptions) {
                                                                                    String doctorName = prescription.getDoctorName();
                                                                                    String doctorOrder = prescription.getDoctorOrder();
                                                                    %>


                                                                    <li class="bullet-item"><b><%=doctorOrderTime%></b><br> <%=doctorOrder%></li>
                                                                            <%
                                                                                    }
                                                                                }
                                                                            %>



                                                                    <%
                                                                    } else {%>
                                                                    <li class="bullet-item">There are no records at the moment</li>
                                                                        <%
                                                                            }
                                                                        %>    





                                                                </ul>
                                                            </div>
                                                        </dd>


                                                        <dd class="accordion-navigation">
                                                            <a href="#panel5">Multidisciplinary Notes</a>
                                                            <div id="panel5" class="content">
                                                                <ul class="pricing-table">
                                                                    <li class="price">Multidisciplinary Notes History</li>   

                                                                    <%
                                                                        List<Note> notesRetrieved = NoteDAO.retrieveNotesByPraticalGrpDesc(practicalGrp, scenarioID);
                                                                        if (notesRetrieved == null || notesRetrieved.size() == 0) {
                                                                            out.println("<center>There are no records at the moment</center>");
                                                                        } else {
                                                                            DateFormat df = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");

                                                                            for (Note note : notesRetrieved) {
                                                                                String multidisciplinaryNotes = note.getMultidisciplinaryNote();

                                                                    %>
                                                                    <li class="bullet-item"><b><%=df.format(note.getNoteDatetime())%></b><br> | <%=multidisciplinaryNotes%></li>  

                                                                    <%}

                                                                        }
                                                                    %>

                                                                </ul>


                                                        </dd>

                                                        <dd class="accordion-navigation">
                                                            <a href="#panel6">Documents</a>
                                                            <div id="panel6" class="content">
                                                                <ul class="pricing-table">

                                                                    <%
                                                                        List<Document> documentsList = DocumentDAO.retrieveDocumentsByScenario(scenarioID);

                                                                        if (documentsList == null || documentsList.size() == 0) {
                                                                            out.println("<center>There are no documents at the moment</center>");
                                                                        
                                                                        } else {

                                                                            for (Document document : documentsList) {
                                                                                String consentName = document.getConsentName() + " | ";
                                                                                String consentFile = "documents/" + document.getConsentFile();
                                                                    %>

                                                                    <li class="bullet-item"> <%=consentName%>
                                                                        <a href="<%=consentFile%>" target="_blank">View Document</a>
                                                                    </li>
                                                                    <%}
                                                                        }

                                                                    %>
                                                                </ul>
                                                            </div>
                                                        </dd>
                                                        <%
                                                        }
                                                    }
                                                        %>   
                                                </div>

                                                <!--RESPONSIVE. END OF iTOUCH VERSION HERE-->


                                                <script>

                                                    function administerConfirmation() {
                                                        var activateButton = confirm("Once administered, it will be added to medication history. Please check before you administer.")
                                                        if (activateButton) {
                                                            return true;
                                                        }
                                                        else {
                                                            return false;
                                                        }
                                                    }


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

                                                    $(document).ready(function() {
                                                        var counter = 10;
                                                        var id = setInterval(function() {
                                                            counter--;

                                                            if (counter > 0) {

                                                                var msg = 'Waiting for response..';
                                                                $('#reportLinkMsg').text(msg);
                                                            } else {
                                                                $('#reportLinkMsg').hide();
                                                                $('#reportDateWaiting').hide();
                                                                $('#reportStatusWaiting').hide();
                                                                $('#downloadReport').show();
                                                                $('#reportDateDisplay').show();
                                                                $('#reportStatusDisplay').show();
                                                                $('#reportLink').show();
                                                                clearInterval(id);
                                                            }
                                                        }, 3000);
                                                    });
                                                </script>


                                                </body>
                                                <script type="text/javascript" src="js/humane.js"></script>

                                                </html>
