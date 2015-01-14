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

        <script>
            function add() {
                //out.println("<input type='text' name ='medicine'>");
                //<input type='text' name ='medicine'>
                //document.getElementById("input").value= "hi"
                document.getElementById("input").innerHTML = "<input type='text' name ='medicine'>";

            }
        </script>


    </head>
    <body>

        <script src="js/vendor/jquery.js"></script>
        <script src="js/foundation.min.js"></script>
    <center>
        <h1>Case Setup</h1>
    </center>

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
                out.println("<h4> States created: </h4>");
                for (State state : stateList) {

                    out.print("<h3>" + state.getStateID().replace("ST", "State ") + "</h3>");
                }
            }

        %>


        <!--Reveal modal for step 2: create state-->
        <div id="createState" class="reveal-modal" data-reveal>
            <h2>Step 2: Create State</h2>
            Please create states in <b>ascending</b> order. <br><br>

            <form action = "ProcessAddState" method = "POST"> 
                State Description <input type =text name = "stateDescription" required> 
                <input type ="hidden" name ="scenarioID" value ="<%=scenarioID%>">
                <input type ="hidden" name ="patientNRIC" value ="<%=patientNRIC%>">
                <input type ="submit" class ="button" value ="Create State">
            </form>   
            <a class="close-reveal-modal">&#215;</a>
        </div>

        <h2>Step 3: Create Medicine<a href="#" data-reveal-id="createMedicine"><img src="img/add.png" height ="30" width = "30"></a></h2>

        <%
            ArrayList<String> medicineStateList = (ArrayList<String>) session.getAttribute("medicineStateDisplay");
            if (medicineStateList == null || medicineStateList.size() == 0) {
                out.println("There are no medicine created yet. Click the + to create a medicine.");
            } else {
                out.println("<h4> Medicine created: </h4>");
                for (String medicineState : medicineStateList) {

                    out.print("<h3>" + medicineState + "</h3>");
                }
            }
        %>
        <div id="createMedicine" class="reveal-modal" data-reveal>
            <h2>Step 3: Create Medicine</h2>
            <form data-abide action ="ProcessAddMedicine" method ="POST">

                <%
                    List<Medicine> medicineList = MedicineDAO.retrieveAll();
                    List<Route> routeList = RouteDAO.retrieveAll();
                    List<Frequency> freqList = FrequencyDAO.retrieveAll();
                    //List<Prescription> prescriptionList= PrescriptionDAO.retrieveAll();

                %>
                State
                <select name = "stateID">
                    <option selected>--Please select the state that this medicine will be tag to--</option>
                    <%                             for (State state : stateList) {%>
                    <option><%=state.getStateID()%></option>
                    <% }
                    %>
                </select>

                Medicine Name <select name="medicineName">

                    <option selected>--Please select the Medicine--</option>
                    <%
                            for (Medicine medicine : medicineList) {%>
                    <option><%=medicine.getMedicineName()%></option>
                    <%}
                    %>
                </select>
                Can't find the medicine you're looking for? 
                <div class="input_fields_wrap">
                    <button class="add_field_button">Add New Medicine</button>
                </div><br><br>


                <!--<input type ="text" name ="medicineBarcode" style="text-transform:uppercase;" required pattern ="/^[A-z]+$/">
                 
                <small class="error">No space and numbers allowed.</small> -->

                Route <select name="route">
                    <option selected>--Please select the Route--</option>
                    <%
                        for (Route route : routeList) {
                        //out.println(route.getRouteAbbr() + " [" + route.getRouteDescription() + "]");
%>
                    <option><%=route.getRouteAbbr()%></option>
                    <%}
                    %>
                </select>

                Frequency <select name="frequency">
                    <option selected>--Please select the Frequency--</option>
                    <%
                        for (Frequency freq : freqList) {
                        //out.println(freq.getFreqAbbr() + " [" + freq.getFreqDescription() + "]");
%>
                    <option><%=freq.getFreqAbbr()%></option>
                    <%}
                    %>
                </select>


                Doctor's Name/MCR No.
                <input type="text" name="doctorName" value="Dr.Tan/01234Z">

                Doctor's Order
                <input type="text" name="doctorOrder">

                Dosage
                <input type="text" name="dosage">



                <input type ="submit" class ="button" value ="Create Medicine">

            </form>
            <a class="close-reveal-modal">&#215;</a>
        </div>


        <h2>Step 4: Upload Reports <a href="#" data-reveal-id="uploadReports"><img src="img/add.png" height ="30" width = "30"></a></h2>
        <!--Reveal modal for upload reports-->
        <div id="uploadReports" class="reveal-modal" data-reveal>
            <h2>Upload Report</h2>
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
                    $(wrapper).append('<div>Medicine Name <input type="text" name="newMedicineName"/>Medicine Barcode <input type="text" name="newMedicineBarcode"/><a href="#" class="remove_field">Remove</a></div>'); //add input box
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
