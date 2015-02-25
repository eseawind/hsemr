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

        
                    <div class ="show-for-small-only">

                                                    <%
                                                        String active = (String) session.getAttribute("active");
                    String success = "";
                    String error = "";
                    //retrieve all successfulmessages
                    //retrieve patient's information
                    String patientNRIC = "";
                    Patient retrievePatient = PatientDAO.retrieve(patientNRIC);



                    State retrieveScenarioState = null;

                    //retrieve current scenario
                    Scenario scenarioActivated = ScenarioDAO.retrieveActivatedScenario();
                    retrieveScenarioState = StateDAO.retrieveActivateState(scenarioActivated.getScenarioID());


                    //get the most recently activated scenario's state
                    if (scenarioActivated == null || retrieveScenarioState == null) {
                        out.println("<center><h1>No Case/States Activated</h1><br>Please contact administrator/lecturer for case activation.</center>");
                    } else{

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
                    }
                                                        
                                                        //get the most recently activated scenario's state
                                                        retrieveScenarioState = StateDAO.retrieveActivateState(scenarioActivated.getScenarioID());
                                                        if (scenarioActivated == null) {
                                                            out.println("<center>No Case/States Activated<br>Please contact administrator/lecturer for case activation.</center>");
                                                        }  else {  
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
                                                    
                                                        %>   
                                                </div>

                                               


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
