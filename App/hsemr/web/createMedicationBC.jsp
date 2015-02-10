<%-- 
    Document   : createMedicationBC
    Created on : Jan 20, 2015, 1:23:50 AM
    Author     : hpkhoo.2012
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
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
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
        <!--Breadcrumbs-->
        <ul class="breadcrumbs">
            <li class="unavailable">Step 1: Case Creation</li>
            <li><a href="createStateBC.jsp">Step 2: State Creation</a></li>
            <li class="current"><a href="#">Step 3: Medication Creation</a></li>
            <li class="unavailable"><a href="#">Step 4: Report and Document Creation</a></li>
        </ul>

        <div class="large-centered large-6 columns">

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
                String patientNRIC = (String) session.getAttribute("patientNRIC");
                List<State> stateList = StateDAO.retrieveAll(scenarioID);

            %>

            <center><h4>Can't find the medicine you're looking for? Add new medicine <a href="#" data-reveal-id="addNewMedicine">here</a></h4></center>

            <!--add new medicine reveal modal-->
            <div id="addNewMedicine" class="reveal-modal" data-reveal>
                <h2>Add New Medicine</h2>
                <form action ="ProcessAddNewMedicine" method ="POST" data-abide>
                    Medicine Name <input type="text" name="newMedicineName" required/>

                    Medicine Barcode <input type ="text" name ="newMedicineBarcode" style="text-transform:uppercase;" required pattern ="^[0-9a-zA-Z]+$">

                    <small class="error">No space and numbers allowed.</small> 

                    <input type ="hidden" name ="route" value ="I.V.">
                    <input type ="submit" class ="button" value ="Create Medicine">
                </form>
                <a class="close-reveal-modal">&#215;</a>
            </div>
            <!--end of add new medicine reveal modal-->

            <!--Add medication form-->
            <form action ="ProcessAddMedication" method ="POST">
                <%                    List<Medicine> medicineList = MedicineDAO.retrieveAll();

                    List<Frequency> freqList = FrequencyDAO.retrieveAll();
                %>

                <div class="row">  
                    <div class="panelCase">
                        <div class="row">
                            <div class="large-6 columns">
                                <label>State
                                    <select name = "stateID" required>
                                        <option disabled="disabled" selected="selected" value = "">--Please select--</option>
                                        <%
                                        for (State state : stateList) {%>
                                        <option><%=state.getStateID()%></option>
                                        <% }
                                        %>
                                    </select>
                                </label>
                            </div>

                            <div class="large-6 columns">
                                <label>Discontinue State
                                    <select name = "discontinueStateID" required>
                                        <option disabled="disabled" selected="selected" value = "">--Please select--</option>
                                        <%
                                        for (State state : stateList) {%>
                                        <option><%=state.getStateID()%></option>
                                        <% }
                                        %>
                                    </select>
                                </label>
                            </div>
                        </div>

                        <div class="row">
                            <div class="large-4 columns">
                                <label>Medicine Name
                                    <select name="medicineName" required>
                                        <option disabled="disabled" selected="selected" value = "">--Please select--</option>
                                        <%
                                        for (Medicine medicine : medicineList) {%>
                                        <option><%=medicine.getMedicineName()%></option>
                                        <%}
                                        %>
                                    </select>
                                </label>
                            </div>


                            <div class="large-4 columns">  
                                <label>Route
                                    <select name="route" required>
                                        <option disabled="disabled" selected="selected" value = "">--Please select--</option>
                                        <%
                                            List<Route> routeList = RouteDAO.retrieveAll();
                                            for (Route route : routeList) {
                                        %>
                                        <option><%=route.getRouteAbbr()%></option>
                                        <%}%>
                                    </select>
                                </label>
                            </div>

                            <div class="large-4 columns"> 
                                <label>Frequency
                                    <select name="frequency" required>
                                        <option disabled="disabled" selected="selected" value = "">--Please select--</option>
                                        <%
                                            for (Frequency freq : freqList) {
                                                //out.println(freq.getFreqAbbr() + " [" + freq.getFreqDescription() + "]");
                                        %>
                                        <option><%=freq.getFreqAbbr()%></option>
                                        <%}
                                        %>
                                    </select>
                                </label>
                            </div>
                        </div>
                    </div>

                    <div class="panelCase">
                        <label>Doctor's Name/MCR No.
                            <input type="text" name="doctorName" value="Dr.Tan/01234Z" required>
                        </label>
                        
                        <label> Doctor's Order 
                            <input type="text" name="doctorOrder" required>
                        </label>
                        
                        <label>Dosage
                            <input type="text" name="dosage" required>
                        </label>
                    </div>
                    <center><input type="submit" value="Create Medication" class="button small"></center> 
            </form>

            <div class="panelCase">              
                <!--Display medication that are in the database-->
                <center>
                    <%  List<Prescription> prescriptionList = PrescriptionDAO.retrieve(scenarioID);
                        if (prescriptionList == null || prescriptionList.size() == 0) {
                            out.println("There are no medication created yet.");

                        } else {
                            out.print("<h3>Medication(s) Created</h3>");
                    %>

                    <%for (Prescription prescription : prescriptionList) {
                            String stateNumber = prescription.getStateID();
                            String doctorOrder = prescription.getDoctorOrder();

                            stateNumber.replace("ST", "State ");
                            String stateDesc = stateNumber.replace("ST", "State ") + " - " + doctorOrder;%>

                    <a href="#" class="button casecreationbutton tiny"><%=stateDesc%></a>
                    <%

                            }
                        }%>
                </center>
            </div>
            <!--End of display medication in the database-->
            <center><a href="createReportDocumentBC.jsp" class="button small">Proceed to Step 4  >></a></center>

        </div>
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
