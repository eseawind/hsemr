<%-- 
    Document   : editMedication
    Created on : Jan 31, 2015, 4:03:11 PM
    Author     : gladyskhong.2012
--%>

<%@page import="java.util.List"%>
<%@page import="java.util.ArrayList"%>
<%@page import="dao.*"%>
<%@page import="entity.*"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@include file="protectPage/protectAdmin.jsp" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">

        <!--Web Title-->
        <title>EMR | Case Management | Manage Case | Edit Medication</title>

        <link rel="stylesheet" href="css/foundation.css" />
        <link rel="stylesheet" href="responsive-tables.css">
        <link rel="stylesheet" href="css/original.css" />
        <script src="responsive-tables.js"></script>
        <%@include file="/topbar/topbarAdmin.jsp" %>

        <link rel="stylesheet" href="//code.jquery.com/ui/1.11.1/themes/smoothness/jquery-ui.css">
        <script src="//code.jquery.com/jquery-1.10.2.js"></script>
        <script src="//code.jquery.com/ui/1.11.1/jquery-ui.js"></script>
        <script type="text/javascript" src="js/humane.js"></script>
        <script type="text/javascript" src="js/app.js"></script>
        <link rel="stylesheet" href="/resources/demos/style.css">
        <title>Case Setup - Medication Creation</title>
    </head>
    <body>
        <br>
        <ul class="breadcrumbs">
            <li><a href="editScenario.jsp">Edit Case Information</a></li>
            <li><a href="editState.jsp">Edit State Information </a></li>
            <li class="current">Edit Medication</li>
            <li><a href="editReportDocument.jsp">Edit Report and Document </a></li>
        </ul><br/>

        <%             //for printing of error/success messages
            String success = "";
            String error = "";

            if (session.getAttribute("success") != null) {

                success = (String) session.getAttribute("success");
                session.setAttribute("success", "");
            }

            if (session.getAttribute("error") != null) {

                error = (String) session.getAttribute("error");
                session.setAttribute("error", "");
            }

            String scenarioID = (String) session.getAttribute("scenarioID");
            String scenario = scenarioID.replace("SC", "Case ");
            String patientNRIC = (String) session.getAttribute("patientNRIC");
            List<State> stateList = StateDAO.retrieveAll(scenarioID);
            String editingMedicine = "editingInProgress";
        %>

    <center>
        <h5><a href="#" data-reveal-id="addNewMedication">Click here to Add New Medication for <%=scenario%></a></h5>    
        <!--add new medicine reveal modal-->
        <div id="addNewMedicine" class="reveal-modal" data-reveal>
            <h2>Add New Medicine</h2>
            <form action ="ProcessAddNewMedicine" method ="POST" data-abide>
                <label>Medicine Name <input type="text" name="newMedicineName" required/></label>
                <label>Medicine Barcode <input type ="text" name ="newMedicineBarcode" style="text-transform:uppercase;" required pattern ="^[0-9a-zA-Z]+$"></label>

                <small class="error">No space and numbers allowed.</small> 

                <input type ="hidden" name ="route" value ="I.V.">
                <!--To differentiate it comes from which page. If edit medicine, route it back to editMedicationPage-->
                <input type ="hidden" name ="editMedicine" value ="Yes">
                <input type ="submit" class ="button" value ="Create Medicine">
            </form>

            <a class="close-reveal-modal">&#215;</a>
        </div>
        <!--end of add new medicine reveal modal-->

        <!--Add medication form-->
        <!--add new medicine reveal modal-->
        <div id="addNewMedication" class="reveal-modal" data-reveal>
            <center>
                <h2>Add New Medication</h2>
                <p>Can't find the medicine you're looking for? Add new medicine <a href="#" data-reveal-id="addNewMedicine">here</a></p><br><br></center>

            <form action ="ProcessAddMedication" method ="POST">
                <%
                    String editMedicine = "editingInProgress";
                %>

                <input type="hidden" name="editingMedicine" value="<%=editMedicine%>" >
                <%
                    List<Medicine> medicineList = MedicineDAO.retrieveAll();

                    List<Frequency> freqList = FrequencyDAO.retrieveAll();
                %>

                <div class="row">
                    <div class="small-3 columns">
                        <label for="right-label" class="right inline" >State</label>
                    </div>
                    <div class="small-9 columns">
                        <select name = "stateID" required>
                            <option disabled="disabled" selected="selected" value = "">--Please select the state that this medicine will be tag to--</option>
                            <%
                                for (State state : stateList) {%>
                            <option><%=state.getStateID()%></option>
                            <% }
                            %>
                        </select>
                    </div>
                </div>
                <div class="row">
                    <div class="small-3 columns">
                        <label for="right-label" class="right inline" >Discontinue State</label>
                    </div>   
                    <div class="small-9 columns">
                        <select name = "discontinueStateID" required>
                            <option disabled="disabled" selected="selected" value = "">--Please select the state that this medicine discontinues--</option>
                            <%
                                for (State state : stateList) {%>
                            <option><%=state.getStateID()%></option>
                            <% }
                            %>
                        </select>
                    </div>
                </div>

                <div class="row">
                    <div class="small-3 columns">
                        <label for="right-label" class="right inline" > Medicine Name </label>
                    </div>
                    <div class="small-9 columns">
                        <select name="medicineName" required>
                            <option disabled="disabled" selected="selected" value = "">--Please select the Medicine--</option>
                            <%
                                for (Medicine medicine : medicineList) {%>
                            <option><%=medicine.getMedicineName()%></option>
                            <%}
                            %>
                        </select>
                    </div>
                </div>

                <div class="row">
                    <div class="small-3 columns">
                        <label for="right-label" class="right inline" > Route </label>
                    </div>
                    <div class="small-9 columns">
                        <select name="route" required>
                            <option disabled="disabled" selected="selected" value = "">--Please select the Route--</option>
                            <%
                                List<Route> routeList = RouteDAO.retrieveAll();
                                for (Route route : routeList) {
                            %>
                            <option><%=route.getRouteAbbr()%></option>
                            <%}%>
                        </select>
                    </div>
                </div>

                <div class="row">
                    <div class="small-3 columns">
                        <label for="right-label" class="right inline" > Frequency </label>
                    </div>
                    <div class="small-9 columns">
                        <select name="frequency" required>
                            <option disabled="disabled" selected="selected" value = "">--Please select the Frequency--</option>
                            <%
                                for (Frequency freq : freqList) {
                                    //out.println(freq.getFreqAbbr() + " [" + freq.getFreqDescription() + "]");
                            %>
                            <option><%=freq.getFreqAbbr()%></option>
                            <%}
                            %>
                        </select>
                    </div>
                </div>

                <div class="row">
                    <div class="small-3 columns">
                        <label for="right-label" class="right inline" > Doctor's Name/MCR No. </label>
                    </div>
                    <div class="small-9 columns">
                        <input type="text" name="doctorName" value="Dr.Tan/01234Z" required>
                    </div>
                </div>

                <div class="row">
                    <div class="small-3 columns">
                        <label for="right-label" class="right inline" > Doctor's Order </label>
                    </div>
                    <div class="small-9 columns">
                        <input type="text" name="doctorOrder">
                    </div>
                </div>

                <div class="row">
                    <div class="small-3 columns">
                        <label for="right-label" class="right inline" > Dosage </label>
                    </div>
                    <div class="small-9 columns">
                        <input type="text" name="dosage">
                    </div>
                </div>


                <center>
                    <input type="submit" value="Add Medication" class="button tiny">
                </center> 

            </form>

            <a class="close-reveal-modal">&#215;</a>
        </div>
        <!--end of add new medicine reveal modal-->
        <div class="large-12 columns">
            <!--Display medication that are in the database-->
            <center>
                <%
                    List<Prescription> prescriptionList = PrescriptionDAO.retrieve(scenarioID);

                    if (prescriptionList == null || prescriptionList.size() == 0) {
                        out.println("<h3><br/><br/>" + "There are no medication created yet." + "</h3>");%>
                <form action ="editReportDocument.jsp" method ="POST">
                    <br/><br/>
                    <input type = "submit" Value ="Continue  >>" class="button small"> 
                </form>               
                <%} else {
                %>

                <form action ="ProcessEditMedication" method ="POST">
                    <table class="responsive" id="cssTable">
                        <col width="5%">
                        <col width="5%">
                        <col width="10%">
                        <col width="10%">
                        <col width="10%">
                        <col width="10%">
                        <col width="10%">
                        <col width="25%">
                        <col width="10%">
                        <thead>
                            <tr>
                                <th>State</th> 
                                <th>Discontinue State</th> 
                                <th>Medicine Barcode</th>
                                <th>Medicine Name</th>
                                <th>Route</th>
                                <th>Frequency</th>
                                <th>Doctor's Name/ MCR No.</th>
                                <th>Doctor's Order</th>
                                <th>Dosage</th>
                            </tr>
                        </thead>
                        <%
                            List<Frequency> fList = FrequencyDAO.retrieveAll();
                            out.print("<h3>Medication(s) Created</h3><br/>");

                            String doctorOrder = "";
                            String doctorName = "";
                            String medBarcode = ""; // from medicine
                            String stateID = "";
                            String freqAbbr = "";
                            String dosage = "";
                            String medicineID = "";
                            String discontinueStateID = "";
                            String medicineName = "";

                            Medicine m = null;
                            Prescription p = null;
                            String route = "";
                            int counter = 0;
                            //int counter2 = 0;
                            String stateDesc = "";
                            String discontinueStateDesc = "";

                            for (Prescription prescription : prescriptionList) { // loop 9 times
                                doctorOrder = prescription.getDoctorOrder();
                                doctorName = prescription.getDoctorName();
                                stateID = prescription.getStateID();
                                discontinueStateID = prescription.getDiscontinueState();
                                freqAbbr = prescription.getFreqAbbr();

                                medBarcode = prescription.getMedicineBarcode();

                                String counterNumber = "";
                                String stateIDNumber = "";
                                String medBarcodeNumber = "";
                                String routeNumber = "";
                                String routeDefault = "";
                                String frequencyNumber = "";
                                String frequencyDefault = "";
                                String doctorNameNumber = "";
                                String doctorOrderNumber = "";
                                String dosageNumber = "";
                                String medicineNameNumber = "";

                                String docOrderDefault = "";

                                if (!medBarcode.equals("NA")) {
                                    //stateID.replace("ST", "State ");
                                    stateDesc = stateID.replace("ST", "State ");
                                    discontinueStateDesc = discontinueStateID.replace("ST", "State ");
                                    //out.println(counter);
                                    medBarcodeNumber = "medBarcode" + counter;
                                    //String stateDescNumber = "stateDesc" + counter;
                                    routeNumber = "route" + counter;
                                    routeDefault = "routeDefault" + counter;
                                    frequencyNumber = "frequency" + counter;
                                    frequencyDefault = "frequencyDefault" + counter;
                                    doctorNameNumber = "doctorName" + counter;
                                    doctorOrderNumber = "doctorOrder" + counter;
                                    dosageNumber = "dosage" + counter;
                                    stateIDNumber = "stateID" + counter;
                                    medicineNameNumber = "medicineName" + counter;
                                    counterNumber = "counter" + counter;

                                    //docOrderDefault= "doctorOrder" + counter;
                                    //barcodeList.add(medBarcode);
                                    p = PrescriptionDAO.retrieve(scenarioID, stateID, medBarcode, doctorOrder);
                                    route = p.getRouteAbbr();
                                    dosage = p.getDosage();

                                    m = MedicineDAO.retrieve(medBarcode);
                                    medicineName = m.getMedicineName();

                                    //dosage = MedicinePrescriptionDAO.retrieveDosage(scenarioID, stateID, medBarcode, freqAbbr);

                        %>

                        <!--End of display medication in the database-->

                        <tr>

                            <td>
                                <input type="hidden" name="<%=counterNumber%>" value="<%=counter%>">
                                <input type="hidden" name="<%=stateIDNumber%>" value="<%=stateID%>">
                                <input type="hidden" name="stateDesc" value="<%=stateDesc%>">
                                <input type="hidden" name ="prescriptionListSize" value="<%=prescriptionList.size()%>">

                                <%=stateDesc%>
                            </td>
                            <td>
                                <%=discontinueStateDesc%>
                            </td>
                            <td>
                                <%=medBarcode%>
                                <input type="hidden" name="<%=medBarcodeNumber%>" value="<%=medBarcode%>">
                            </td>
                            <td>
                                <input type="hidden" name="<%=medicineNameNumber%>" value="<%=medicineName%>">
                                <%=medicineName%>
                            </td>
                            <td>
                                <input type="hidden" name="<%=routeDefault%>" value="<%=route%>">
                                <select name="<%=routeNumber%>" required>
                                    <option disabled="disabled" selected="selected" value = "<%=route%>"><%=route%></option>
                                    <%
                                        List<Route> rList = RouteDAO.retrieveAll();
                                        for (Route rr : rList) {
                                    %>
                                    <option value="<%=rr.getRouteAbbr()%>"><%=rr.getRouteAbbr()%></option>
                                    <%}%>
                                </select>

                            </td>
                            <td> <input type="hidden" name="<%=frequencyDefault%>" value="<%=freqAbbr%>">
                                <select name="<%=frequencyNumber%>" required>
                                    <option disabled="disabled" selected="selected" value="<%=freqAbbr%>"><%=freqAbbr%></option>
                                    <%
                                        for (Frequency freq : freqList) {
                                            out.println(freq.getFreqAbbr() + " [" + freq.getFreqDescription() + "]");
                                    %>
                                    <option value="<%=freq.getFreqAbbr()%>"><%=freq.getFreqAbbr()%></option>
                                    <%
                                        }
                                    %>
                                </select>

                            </td>
                            <td>
                                <!-- <input type="hidden" name="<%=docOrderDefault%>" value="<%=doctorOrder%>"> -->
                                <input type="text" name="<%=doctorNameNumber%>" value="<%=doctorName%>" required></td>
                            <td><input type="text" name="<%=doctorOrderNumber%>" value="<%=doctorOrder%>"></td>
                            <td><input type="text" name="<%=dosageNumber%>" value="<%=dosage%>" required></td>

                        </tr>
                        <%
                                    counter++;
                                }
                            }}%>
                    </table> <br/><br/>
                    <input type = "submit" Value ="Save and Proceed  >>" class="button small"></center>  
                    <br>
                    <br>
                    <br>
                    <center>

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
