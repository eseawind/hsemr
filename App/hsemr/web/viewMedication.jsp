<%-- 
    Document   : viewMedication
    Created on : Mar 1, 2015, 7:04:19 PM
    Author     : Administrator
--%>

<%@page import="dao.*"%>
<%@page import="entity.*"%>
<%@page import="java.util.List"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    </head>
    <body>
        
        <h4>Step 1: Scan Patient's Barcode > Step 2: Scan Medicine's Barcode > Step 3: Administer Medicine </h4>
                            <input data-reveal-id="medicationHistory" type="submit" value="View Medication History" class="button tiny"><br>  

                            <!--Start of Reveal Modal for Medication History-->
                            <div id="medicationHistory" class="reveal-modal" data-reveal>
                                <h2>Medication History</h2>

                                <%
                                   // List<MedicationHistory> medicationHistoryList = new ArrayList<MedicationHistory>();
                                    String practicalGroupID = (String)session.getAttribute("nurse");
                                    List<MedicationHistory> medicationHistoryList = MedicationHistoryDAO.retrieveAllInPracticalGroup(scenarioID,practicalGroupID);
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
                                        <td><%=medicationHistory.getPracticalGroupID()%></td>
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

                                                        if (medicineVerifiedList != null) {
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


                                                    <%                                                        if (discontinueState != null) {
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
                                                    <td><%                                                            //MedicinePrescriptionDAO.retrieve(prescription.getMedicineBarcode()).getDosage();
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
                                                            if (medicineVerifiedList != null) {
                                                                if (medicineVerifiedList.contains(medicineBarcode)) {
                                                        %>
                                                        <b><font color="#368a55"> YES</font></b>
                                                        <img src="img/verified.gif" width = "15" height = "15"/>

                                                        <%}
                                                            }
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

        
        
    </body>
</html>
