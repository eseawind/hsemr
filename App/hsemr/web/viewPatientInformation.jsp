<%-- 
    Document   : viewPatientInformation
    Created on : Oct 09, 2014, 2:37:16 PM
    Author     : weiyi.ngow.2012
--%>

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

        <script>

            $(document).ready(function() {
                $(document).foundation();
            });

        </script>
        <title>NP Health Sciences | Patient Information</title>
        <%@include file="/topbar/topbar.jsp" %> 
    </head>
    <body>
        <script src="js/foundation.min.js"></script>

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

                %>
                <br>   
                <!--Patient's Information-->
                <div class="panel" style="background-color: #FFFFFF">
                    <h2>Patient's Information</h2><br/>
                    <font size='4'><b>Name: <font color="#666666"><%=fullName%></font></b>&nbsp;&nbsp;
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
                            } %>"><a href="#multidisciplinary"><b>Multidisciplinary Notes</b></a></dd>
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
                                StateHistoryDAO.addStateHistory(scenarioID, "ST0");
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
                                // loop through each report
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
                                    String firstDespatch = (String) session.getAttribute("obtainedReport");
                                    if (dispatchStatus == 1) {
                                        if (firstDespatch != null && !firstDespatch.equals("0")) {%>
                                <td><div id="reportDateWaiting">Waiting..</div>
                                    <div id="reportDateDisplay" style="display:none;"><%=reportDatetime%></div></td>
                                    <% session.setAttribute("obtainedReport", "0");
                                    } else {%>  
                                <td><%=reportDatetime%></td>
                                <% }
                                    } else {
                                        out.println("<td>-</td>");
                                    }%> 

                                <td><% // action (despatch status) column 
                                    if (dispatchStatus == 1) {
                                        if (firstDespatch != null && !firstDespatch.equals("0")) { %>
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

                                <input type="submit" id="downloadReport" class="report-despatch button tinytable" value="Despatch">
                            </form>
                            <% } %>
                            </td>

                            <td>
                                <% // results column (link) 
                                    if (dispatchStatus == 1) {
                                %>
                                <%
                                    if (firstDespatch != null && !firstDespatch.equals("0")) {
                                %>
                                <div id="reportLinkMsg">Loading..</div>
                                <%
                                    session.setAttribute("obtainedReport", "0");

                                %> <a href="<%=reportResults%>" id="reportLink" target="_blank" style="display:none;">View Report</a>
                                <%
                                } else {
                                %>
                                <a href="<%=reportResults%>" target="_blank">View Report</a>
                                <% }%>
                                <% } else {
                                        out.println("N/A");

                                    }
                                %>
                            </td>


                            </tr>

                            <%
                                    }
                                }
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

                        %>
                        <form data-abide action="ProcessAddVital" method="POST">
                            <h4>Vital Signs</h4><br/>
                            <table width='65%'>
                                <br/>
                                <col width="35%">  
                                <col width="65%">  
                                <!--  <th>Vital Signs/Input/Output</th> -->
                                <tr><td><b>Temperature</b><a href="#" data-reveal-id="tempchart" style="color:white"><img src="img/Historial.jpg"></a></td>
                                    <td><div class="row">
                                            <div class="small-4 columns" style="width:200px">
                                                <!--validates for 1 decimal place-->
                                                <input type="text" name ="temperature" maxlength="4" pattern ="\b(3[4-9](\.[0-9]{1,2})?|4[0-2])(\.[0-9]{1,2})?$\b" />
                                                <small class="error">Temperature must be between 34 - 42.</small>
                                            </div>
                                            <label for="right-label" class="left inline">ºC</label>
                                        </div></td>
                                </tr> 

                                <tr><td><b>Respiratory Rate</b><a href="#" data-reveal-id="RRchart" style="color:white"><img src="img/Historial.jpg"></a></td>
                                    <td><div class="row">
                                            <div class="small-4 columns" style="width:200px">
                                                <input type="text" name ="RR" maxlength="2" pattern ="^([0-9]|[1-5][0-9]|60)$"/>
                                                <small class="error">Respiratory Rate must be between 0 - 60.</small>
                                            </div>

                                            <label for="right-label" class="left inline">breaths/min</label>

                                        </div>
                                </tr>

                                <tr><td><b>Heart Rate</b><a href="#" data-reveal-id="HRchart" style="color:white"><img src="img/Historial.jpg"></a></td>
                                    <td><div class="row">
                                            <div class="small-4 columns" style="width:200px">
                                                <!--validates between 0 - 200-->
                                                <input type="text" name ="HR" maxlength ="3" pattern ="^([0-9]|[1-9][0-9]|[1][0-9][0-9]|30[0-0])$"/>
                                                <small class="error">Heart Rate must be between 0 - 200.</small>
                                            </div>
                                            <label for="right-label" class="left inline">beats/min</label>
                                        </div></td>
                                </tr>

                                <tr><td><b>Blood Pressure<a href="#" data-reveal-id="BPchart" style="color:white"><img src="img/Historial.jpg"></a></td>
                                    <td><div class="row">
                                            <div class="small-4 columns" style="width:200px">
                                                <!--<input type="text" name ="BPsystolic" style="width:200px" value= "0" maxlength = "3" pattern = "^(\d{2,3}|\d{2})$"/>-->
                                                <input type="text" name ="BPsystolic" maxlength = "3" pattern = "^([0-9]{1,2}|[12][0-9]{2}|300)$"/>
                                                <small class="error">BP systolic must be numeric and between 0 - 300.</small>
                                            </div>

                                            <label for="right-label" class="left inline">mmHg (Systolic)</label>

                                        </div>
                                        <div class="row">
                                            <div class="small-4 columns" style="width:200px">
                                                <!--<input type="text" name ="BPdiastolic" style="width:200px" value= "0" maxlength = "3" pattern = "^(\d{2,3}|\d{2})$"/>-->
                                                <input type="text" name ="BPdiastolic" maxlength = "3" pattern = "^([0-9]{1,2}|1[0-9]{2}|200)$"/>
                                                <div class ="input wrapper">
                                                    <small class="error">BP diastolic must be numeric and between 0 - 200.</small>
                                                </div>
                                            </div>

                                            <label for="right-label" class="left inline">mmHg (Diastolic)</label>

                                        </div>
                                    </td></tr>
                                <tr><td><b>SpO<sub>2</sub></b><a href="#" data-reveal-id="SPOchart" style="color:white"><img src="img/Historial.jpg"></a></td>

                                    <td><div class="row">
                                            <div class="small-4 columns" style="width:200px">
                                                <input type="text" name ="SPO" maxlength = "3" pattern ="^[0-9][0-9]?$|^100$"/>
                                                <small class="error">SPO must be numeric and between 0 - 100%.</small>
                                            </div>

                                            <label for="right-label" class="left inline">%</label>

                                        </div></td></tr>
                                <tr><td><b>Intake - Oral/Intragastric</b><a href="#" data-reveal-id="IntakeOI" style="color:blue"><br><i><u>View past records</u></i></a></td>

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

                                <tr><td><b>Intake - Intravenous</b><a href="#" data-reveal-id="IntakeIntra" style="color:blue"><br><i><u>View past records</u></i></a></td>

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

                                <tr><td><b>Output</b><a href="#" data-reveal-id="Output" style="color:blue"><br><i><u>View past records</u></i></a></td>

                                    <td><div class="row">
                                            <div class="small-4 columns" style="width:200px">
                                                <input type="text" name ="output" style="width:170px" value= " "/>
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

                        <input data-reveal-id="medicationHistory" type="submit" value="View Medication History" class="button tiny">  

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
                                </tr>

                                <%
                                    DateFormat dateFormatterFprMedicationHistory = new SimpleDateFormat("dd-MM-yyyy hh:mm a");

                                    for (MedicationHistory medicationHistory : medicationHistoryList) {%>
                                <tr>

                                    <td><%=dateFormatterFprMedicationHistory.format(medicationHistory.getMedicineDatetime())%></td>
                                    <td><%=medicationHistory.getMedicineBarcode()%></td>


                                </tr> 

                                <% }

                                %>
                            </table>
                            <% }
                            %>

                            <a class="close-reveal-modal">&#215;</a>
                        </div>

                        <%
                            ArrayList<Prescription> prescriptionList = PrescriptionDAO.retrieve(scenarioID, stateID);
                            ArrayList<MedicinePrescription> medicinePrescriptionList = MedicinePrescriptionDAO.retrieve(scenarioID, stateID);

                            if (medicinePrescriptionList.size() == 0) {
                                out.println("<br>There's no prescription at the moment.");

                            } else {%>

                        <h4>Step 1: Scan Patient's Barcode</h4>
                        <%
                            String patientBarcodeInput = (String) session.getAttribute("patientBarcodeInput");
                            String isPatientVerified = (String) session.getAttribute("isPatientVerified");
                            String disabled = "disabled";

                            //patient is verified, enable the button
                            if (isPatientVerified != null) {
                                disabled = "";
                                patientBarcodeInput = patientBarcodeInput;
                            }

                        %>

                        <form action = "ProcessPatientBarcode" method = "POST" name = "medicationTab">

                            <%                                if (patientBarcodeInput == null) {
                                    patientBarcodeInput = "";
                                }

                            %>

                            <div class="small-8">
                                <div class="small-3 columns">
                                    <label for="right-label" class="right inline">Patient's Barcode</label>
                                </div>
                                <div class="small-9 columns">
                                    <input type="hidden" name = "patientBarcode" id="patientBarcode" value = "<%=patientNRIC%>">
                                    <input type="text" value = "<%=patientBarcodeInput%>" name = "patientBarcodeInput" autofocus/>
                                </div>
                            </div>    

                        </form>

                        <br><br><p><br>
                        <h4>Step 2: Scan Medicine Barcode</h4>
                        <table>
                            <tr>
                                <td><b>Medicine Barcode</b></td>
                                <td><b>Medicine Name<b></td>
                                            <td><b>Route</b></td>
                                            <td><b>Dosage</b></td>
                                            <td><b>Frequency</b></td>
                                            <td><b>Doctor Name/MCR No.</b></td>
                                            <td><b>Remarks</b></td>
                                            </tr>
                                            <%for (MedicinePrescription medicinePrescription : medicinePrescriptionList) {
                                                    String medicineBarcodeInput = (String) session.getAttribute("medicineBarcodeInput");

                                                    if (medicineBarcodeInput == null) {
                                                        medicineBarcodeInput = "";
                                                    }

                                            %>
                                            <tr>
                                                <td>   

                                                    <form action = "ProcessMedicineBarcode" method = "POST">
                                                        <div class="password-confirmation-field">
                                                            <input type="hidden" name = "medicineBarcode" id="medicineBarcode" value = "<%=medicinePrescription.getMedicineBarcode()%>">
                                                            <input type="text" name = "medicineBarcodeInput" value = "<%=medicineBarcodeInput%>"  <%=disabled%>>

                                                        </div>


                                                    </form></td>
                                                <td>

                                                    <%=MedicineDAO.retrieve(medicinePrescription.getMedicineBarcode()).getMedicineName()%>


                                                </td>
                                                <td>
                                                    <%

                                                        String medicineBarcode = medicinePrescription.getMedicineBarcode();
                                                        if (medicineBarcode != null) {
                                                            Medicine medicine = MedicineDAO.retrieve(medicineBarcode);
                                                            out.println(medicine.getRouteAbbr());
                                                        }
                                                    %>


                                                </td>
                                                <td><%=medicinePrescription.getDosage()%></td>
                                                <td><%=medicinePrescription.getFreqAbbr()%></td>                                          
                                                <td>Dr.Tan/01234Z</td>
                                                <td>
                                                    <%
                                                        String medicineBarcodeToRetrieve = medicinePrescription.getMedicineBarcode();
                                                        Prescription prescription = PrescriptionDAO.retrieve(scenarioID, stateID, medicineBarcodeToRetrieve);

                                                        if (medicineBarcodeToRetrieve != null && prescription != null) {
                                                            out.println(prescription.getDoctorOrder());
                                                        }
                                                    %>

                                                </td>
                                            </tr>  
                                            <%}
                                                    //session.removeAttribute("patientBarcodeInput");
                                                }
                                                session.removeAttribute("isMedicationVerified");
                                                session.removeAttribute("isPatientVerified");
                                            %>

                                            </table>

                                            </div> 
                                            <!--End of medication tab-->

                                            <!--MULTIDISCIPLINARY NOTES-->
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

                                                            <br>
                                                            <input type="submit" name="buttonChoosen" value="Save" class="button tiny"> 
                                                            <input type="submit" name="buttonChoosen" value="Submit" class="button tiny"> 

                                                        </div> 
                                                    </div>  
                                                </form>

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
                                                                    </div>
                                                                </div>
                                                            </div>
                                                        </div>
                                                    </dd>
                                            </div>

                                            <!--DOCUMENTS-->
                                            <div class="<% 
                                                if (active != null && active.equals("documents")) {
                                                    out.println("content active");
                                                } else {
                                                    out.println("content");
                                                } %>" id="documents">

                                                <h4>Consent Forms</h4><br/>

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

                                            <!-- Reveal model for Intake Oral chart -->
                                            <div id="IntakeOI" class="reveal-modal large-10" data-reveal>

                                                <h3>Intake - Oral/Intragastric</h3>

                                                <%
                                                    List<Vital> oralIntakeList = VitalDAO.retrieveIntakeOralByScenarioID(scenarioID);

                                                    DateFormat df = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
                                                    if (oralIntakeList.size() == 0) {
                                                        out.println("<h5>There is no historial data at the moment.</h5>");
                                                    } else {
                                                %>

                                                <table>
                                                    <tr>
                                                        <td>Time taken</td>
                                                        <td>Intake Type</td>
                                                        <td>Intake Amount</td>
                                                    </tr>
                                                    <%
                                                        for (Vital vital : oralIntakeList) {
                                                            String oralType = vital.getOralType();
                                                            String oralAmount = vital.getOralAmount();
                                                            Date oralDate = vital.getVitalDatetime();
                                                            String strOralDate = df.format(oralDate);
                                                    %>
                                                    <tr>
                                                        <td><%=strOralDate%></td>
                                                        <td><%=oralType%></td>
                                                        <td><%=oralAmount%></td>
                                                    </tr>
                                                    <%}
                                                        }
                                                    %>

                                                </table>

                                                <a class="close-reveal-modal">&#215;</a>

                                            </div>

                                            <!-- Reveal model for Intake Intravenous chart -->
                                            <div id="IntakeIntra" class="reveal-modal large-10" data-reveal>

                                                <h3>Intake - Intravenous</h3>

                                                <%
                                                    List<Vital> intakeIntraList = VitalDAO.retrieveIntakeIntraByScenarioID(scenarioID);

                                                    if (intakeIntraList.size() == 0) {
                                                        out.println("<h5>There is no historial data at the moment.</h5>");
                                                    } else {
                                                %>

                                                <table>
                                                    <tr>
                                                        <td>Time taken</td>
                                                        <td>Intake Type</td>
                                                        <td>Intake Amount</td>
                                                    </tr>
                                                    <%
                                                        for (Vital vital : intakeIntraList) {
                                                            String intraType = vital.getIntravenousType();
                                                            String intraAmount = vital.getIntravenousAmount();
                                                            Date intraDate = vital.getVitalDatetime();
                                                            String strIntraDate = df.format(intraDate);
                                                    %>
                                                    <tr>
                                                        <td><%=strIntraDate%></td>
                                                        <td><%=intraType%></td>
                                                        <td><%=intraAmount%></td>
                                                    </tr>
                                                    <%}
                                                        }
                                                    %>

                                                </table>

                                                <a class="close-reveal-modal">&#215;</a>

                                            </div>

                                            <!-- Reveal model for Output chart -->
                                            <div id="Output" class="reveal-modal large-10" data-reveal>

                                                <h3>Output</h3>

                                                <%
                                                    List<Vital> outputList = VitalDAO.retrieveOutputByScenarioID(scenarioID);

                                                    if (outputList.size() == 0) {
                                                        out.println("<h5>There is no historial data at the moment.</h5>");
                                                    } else {
                                                %>

                                                <table>
                                                    <tr>
                                                        <td>Time taken</td>
                                                        <td>Output</td>
                                                    </tr>
                                                    <%
                                                        for (Vital vital : outputList) {
                                                            String output = vital.getOutput();
                                                            Date intraDate = vital.getVitalDatetime();
                                                            String strIntraDate = df.format(intraDate);
                                                    %>
                                                    <tr>
                                                        <td><%=strIntraDate%></td>
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
                                            </div>
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
            $(document).ready(function() {
                var counter = 10;
                var id = setInterval(function() {
                    counter--;

                    if (counter > 0) {

                        var msg = 'Waiting for response..';
                        $('#docLinkMsg').text(msg);
                    } else {
                        $('#docLinkMsg').hide();
                        $('#docDateWaiting').hide();
                        $('#docStatusWaiting').hide();
                        $('#downloadDoc').show();
                        $('#docDateDisplay').show();
                        $('#docStatusDisplay').show();
                        $('#consentLink').show();
                        clearInterval(id);
                    }
                }, 3000);
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
