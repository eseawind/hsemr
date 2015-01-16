<%@page import="java.util.List"%>
<%@page import="java.util.ArrayList"%>
<%@page import="dao.*"%>
<%@page import="entity.*"%>
<%--<%@include file="protectPage/protectAdmin.jsp" %>--%>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link rel="stylesheet" href="css/foundation.css" />
        <link rel="stylesheet" href="responsive-tables.css">
        <script src="responsive-tables.js"></script>
        <%@include file="/topbar/topbarAdmin.jsp" %>

        <link rel="stylesheet" href="//code.jquery.com/ui/1.11.1/themes/smoothness/jquery-ui.css">
        <script src="//code.jquery.com/jquery-1.10.2.js"></script>
        <script src="//code.jquery.com/ui/1.11.1/jquery-ui.js"></script>
        <script type="text/javascript" src="js/humane.js"></script>
        <script type="text/javascript" src="js/app.js"></script>
        <link rel="stylesheet" href="/resources/demos/style.css">

    </head>
    <body>

        <script src="js/vendor/jquery.js"></script>
        <script src="js/foundation.min.js"></script>
        <center><h1>Case Setup</h1></center>

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

        %>
        <center>

        <h2>Step 2: Create State <a href="#" data-reveal-id="createState"><img src="img/add.png" height ="30" width = "30"></a></h2>
        <!--Display states that are in the database-->

        <%                out.println("");
            List<State> stateList = StateDAO.retrieveAll(scenarioID);

            if (stateList == null || stateList.size() == 0) {
                out.println("There are no states created yet. Click the + to create a state.");
            } else {
                out.println("<h3> States created: </h3>");
                for (State state : stateList) {

                    out.print("<h4>" + state.getStateID().replace("ST", "State ") + "</h4>");
                }
            }

        %>
        
        <!--Reveal modal for step 2: create state-->
        <div id="createState" class="reveal-modal" data-reveal>

            <h2>Step 2: Create State <%=stateList.size()%></h2>
            States are created in <b>ascending</b> order. <br><br>

            <form action = "ProcessAddState" method = "POST"> 
                State Description <input type =text name = "stateDescription" required> 
                <input type ="hidden" name ="scenarioID" value ="<%=scenarioID%>">
                <input type ="hidden" name ="patientNRIC" value ="<%=patientNRIC%>">
                <input type ="submit" class ="button" value ="Create State">
            </form>   
            <a class="close-reveal-modal">&#215;</a>
        </div>

        <h2>Step 3: Create Medication <a href="#" data-reveal-id="createMedicine"><img src="img/add.png" height ="30" width = "30"></a></h2>
        <%
            List<MedicinePrescription> medicinePrescriptionList = MedicinePrescriptionDAO.retrieveFromScenario(scenarioID);
            
            for(MedicinePrescription medicinePrescription : medicinePrescriptionList){%>
        <h4><%=medicinePrescription.getStateID() +  " - " + medicinePrescription.getMedicineBarcode() + " " + medicinePrescription.getFreqAbbr()+ " " + medicinePrescription.getDosage() +  "<br>"%></h4>
            
           <% }
        
        %>
        
        
        <div id="createMedicine" class="reveal-modal" data-reveal>
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
            <form data-abide action ="ProcessAddMedication" method ="POST">

                <%
                    List<Medicine> medicineList = MedicineDAO.retrieveAll();
                    
                    List<Frequency> freqList = FrequencyDAO.retrieveAll();
                    //List<Prescription> prescriptionList= PrescriptionDAO.retrieveAll();

                %>
                State
                <select name = "stateID" required>
                    <option>--Please select the state that this medicine will be tag to--</option>
                    <%                             for (State state : stateList) {%>
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
                
<!--                
                <div class="input_fields_wrap">  
                    <button class="add_field_button" class = "button tiny">Add New Medicine</button>
                </div><br><br>-->

                <!--<input type ="text" name ="medicineBarcode" style="text-transform:uppercase;" required pattern ="/^[A-z]+$/">
                 
                <small class="error">No space and numbers allowed.</small> -->
                
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



                <input type ="submit" class ="button" value ="Create Medication">

            </form>
            <a class="close-reveal-modal">&#215;</a>
        </div>
        
        <!--add of add medication reveal modal-->


        <h2>Step 4: Upload Reports <a href="#" data-reveal-id="uploadReports"><img src="img/add.png" height ="30" width = "30"></a></h2>
        <!--Reveal modal for upload reports-->
        <div id="uploadReports" class="reveal-modal" data-reveal>
            <h2>Step 4: Upload Report</h2>
            Please upload ONE at a time. <br>

            <form action = "ProcessReportUpload" method = "POST" enctype = "multipart/form-data"> 
                Please ensure that your file is named to what you want it to be shown.<br>
                <input type ="file" name = "file"/><br>
                <input type ="hidden" name ="scenarioID" value ="<%=scenarioID%>"/>
                <input type ="submit" class ="button" value ="Upload Report">

            </form><br>   
            <a class="close-reveal-modal">&#215;</a>
        </div>

    </center>

    <input type ="hidden" name ="scenarioID" value ="<%=scenarioID%>"/>
    <input type ="hidden" name ="patientNRIC" value ="<%=patientNRIC%>"/>
    <center><input type ="submit" class ="button" value ="Create State(s)"></center>

    
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
