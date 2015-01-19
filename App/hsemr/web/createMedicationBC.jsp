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
        <title>Case Setup of Medication</title>
    </head>
    <body>
        <script src="js/vendor/jquery.js"></script>
        <script src="js/foundation.min.js"></script>
        <center><h1>Medication creation</h1></center>
        <br>
        <b>Step 1: Case creation > <a href="createStateBC.jsp">Step 2: State creation</a>  > <a href="createMedicationBC.jsp">Step 3: Medication creation</a> </b> > Step 4: Report and Document creation
         <%

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
        
        
        <%
            List<MedicinePrescription> medicinePrescriptionList = MedicinePrescriptionDAO.retrieveFromScenario(scenarioID);
            
            for(MedicinePrescription medicinePrescription : medicinePrescriptionList){%>
        <h4><%=medicinePrescription.getStateID().replace("ST", "State ") +  " - " + medicinePrescription.getMedicineBarcode() + " [" + medicinePrescription.getFreqAbbr()+ " " + medicinePrescription.getDosage() + "] " +"<br>"%></h4>
            
           <% }
        
        %>
         
        
        <h2>Step 3: Create Medication</h2>
            Can't find the medicine you're looking for? Add new medicine <a href="#" data-reveal-id="addNewMedicine">here</a><br><br>
            
            <!--add new medicine reveal modal-->
            <div id="addNewMedicine" class="reveal-modal" data-reveal>
                <h2>Add New Medicine</h2>
                <form action ="ProcessAddNewMedicine" method ="POST" data-abide>
                Medicine Name <input type="text" name="newMedicineName" required/>
                
                Medicine Barcode <input type ="text" name ="newMedicineBarcode" style="text-transform:uppercase;" required pattern ="^[0-9a-zA-Z]+$">
                 
                <small class="error">No space and numbers allowed.</small> 
                
                <!--Medicine Barcode <input type="text" name="newMedicineBarcode" style="text-transform:uppercase;" required />-->
                Route <select name="route">
                <option>--Please select the Route--</option>
                <%
                    List<Route> routeList = RouteDAO.retrieveAll();
                    for (Route route : routeList) {
                %>
                <option><%=route.getRouteAbbr()%></option>
                <%}%>
                </select>
                <input type ="submit" class ="button" value ="Create Medicine">
                </form>
                <a class="close-reveal-modal">&#215;</a>
            </div>
            <!--end of add new medicine reveal modal-->
                
            <!--Add medication form-->
            <form action ="ProcessAddMedication" method ="POST">
                
                <%
                    int counter=0; 
                    String counterStr= (String) request.getAttribute("counter");
                    
                    if(counterStr==null){
                        counter=0;
                    }else{                 
                         counter = Integer.parseInt(counterStr);
                    }
                %>

                <%
                    List<Medicine> medicineList = MedicineDAO.retrieveAll();
                    
                    List<Frequency> freqList = FrequencyDAO.retrieveAll();
                    //List<Prescription> prescriptionList= PrescriptionDAO.retrieveAll();

                %>
                State
                <select name = "stateID" required>
                    <option>--Please select the state that this medicine will be tag to--</option>
                    <%      
                    for (State state : stateList) {%>
                    <option><%=state.getStateID()%></option>
                    <% }
                    %>
                </select>
                Medicine Name 
                <select name="medicineName">
                    <%
                    for (Medicine medicine : medicineList) {%>
                    <option><%=medicine.getMedicineName()%></option>
                    <%}
                        %>
                </select>
                 <!--if select same route as database, then use the medicine in the database, else take this route-->
                Route 
                <select name="route">
                    <option>--Please select the Route--</option>
                    <%
                        for (Route route : routeList) {
                    %>
                    <option><%=route.getRouteAbbr()%></option>
                    <%}%>
                </select>
                
                
                Frequency 
                <select name="frequency">
                    <option selected>--Please select the Frequency--</option>
                    <%
                        for (Frequency freq : freqList) {
                        //out.println(freq.getFreqAbbr() + " [" + freq.getFreqDescription() + "]");
                    %>
                    <option><%=freq.getFreqAbbr()%></option>
                    <%}
                    %>
                </select>

                Doctor's Name/MCR No.<input type="text" name="doctorName" value="Dr.Tan/01234Z" required>

                Doctor's Order <input type="text" name="doctorOrder" required>

                Dosage <input type="text" name="dosage" required>

                <input type ="hidden" name ="counter" value ="<%=counter%>">
                <% if(counter == 0) {%>
                    <input type ="submit" class ="button" value ="Create Medication">
              <%  }else{ %>
                    <input type ="submit" class ="button" value ="Create Medication">
              </form>
                    
                    <form action="createReportDocumentBC.jsp" method="POST">
                    <input type ="submit" class ="button" value ="Proceed to Step 4">
                    </form>
              <%  } %>

                

 <!--Script for "Add Medicine" button-->
    <script>
        $(document).ready(function() {
            var max_fields = 2; //maximum input boxes allowed
            var wrapper = $(".input_fields_wrap"); //Fields wrapper
            var add_button = $(".add_field_button"); //Add button ID

            var x = 1; //initlal text box count
            $(add_button).click(function(e) { //on add input button click
                e.preventDefault();
                if (x < max_fields) { //max input box allowed
                    x++; //text box increment
                    $(wrapper).append('<div>Medicine Name <input type="text" name="newMedicineName" required/>Medicine Barcode <input type="text" name="newMedicineBarcode" required/><a href="#" class="remove_field">Remove</a></div>'); //add input box
                }
            });

            $(wrapper).on("click", ".remove_field", function(e) { //user click on remove text
                e.preventDefault();
                $(this).parent('div').remove();
                x--;
            })
        });
    </script>

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
