<%@page import="dao.StateDAO"%>
<%@page import="dao.PatientDAO"%>
<%@page import="dao.ScenarioDAO"%>
<%@include file="protectPage/protectAdmin.jsp" %>
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
        <link rel="stylesheet" href="/resources/demos/style.css">
    </head>
    <body>

        <script src="js/vendor/jquery.js"></script>
        <script src="js/foundation.min.js"></script>
        <center>
        <h1>Case Setup</h1>
        <h2>Step 2: Create State(s)</h2>
        </center>
    
        <%          
            String totalNumberOfStatesString = (String) session.getAttribute("totalNumberOfStates");
            int totalNumberOfStates = Integer.parseInt(totalNumberOfStatesString);

            String scenarioID = (String) session.getAttribute("scenarioID");
            String patientNRIC = (String) session.getAttribute("patientNRIC");
        
            for (int i = 0; i < totalNumberOfStates; i++) {
                //to differentiate different states
                String stateDescription = "stateDescription" + (i + 1);
        %>
        <form action ="ProcessAddState" method ="POST">
            <center>
                <h2>State <%=i + 1%></h2>

                <div class="row">
                    <div class = "large-12">
                        <label>State Description</label>
                        <textarea style = "resize:vertical" name = "<%=stateDescription%>" rows = "2" cols = "10"></textarea>
                    </div>
                </div>

            <!--                    
                    <label>Is report applicable for this state? </label> 
                    <input type="radio" id="report1" name="report" value="yes">Yes<br>
                    <input type="radio" id="report2" name="report" value="no" checked>No<br>
                    <select name="reportNumber" id="reportNumber">
                    <option value="1">1</option>
                    <option value="2">2</option>
                    <option value="3">3</option>
                    <option value="4">4</option>
                    <option value="5">5</option>
                </select>-->
<!--               <div class="input_fields_wrap"> 
                   <p><center><button class="add_field_button">Add more</button></center></p><br><br>
                </div>-->
                </center>


            <%   }
            %>

            <input type ="hidden" name ="totalNumberOfStates" value ="<%=totalNumberOfStates%>"/>
            <input type ="hidden" name ="scenarioID" value ="<%=scenarioID%>"/>
            <input type ="hidden" name ="patientNRIC" value ="<%=patientNRIC%>"/>
            <center><input type ="submit" class ="button" value ="Create State(s)"></center>

        </form>


        <script>
            $(document).foundation();
//            $('#reportNumber').hide();
//            $('#report2').change(function() {
//                if (this.checked) {
//                    $('#reportNumber').hide();
//                }
//            });
//            $('#report1').change(function() {
//                if (this.checked) {
//                    $('#reportNumber').show();
//                }
//            });
            $(document).ready(function() {
                var max_fields = 10; //maximum input boxes allowed
                var wrapper = $(".input_fields_wrap"); //Fields wrapper
                var add_button = $(".add_field_button"); //Add button ID

                var x = 1; //initlal text box count
                $(add_button).click(function(e) { //on add input button click
                    e.preventDefault();
                    if (x < max_fields) { //max input box allowed
                        x++; //text box increment
//                        $(wrapper).append('<div><input type="text" name="filename" placeholder="Report name"><a href="#" class="remove_field">Remove</a></div>'); //add input box
                        $(wrapper).append('<form action = "ProcessReportUpload" method = "POST" enctype = "multipart/form-data"> <input type ="file" name = "file" size = "50"/> <br> <input type ="submit" value = "Upload Report" /></form><br>'); //add input box
                    }
                });

                $(wrapper).on("click", ".remove_field", function(e) { //user click on remove text
                    e.preventDefault();
                    $(this).parent('div').remove();
                    x--;
                })
            });
        </script>

    </body>
</html>
