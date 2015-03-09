<%-- 
    Document   : createScenario
    Created on : Sep 27, 2014, 10:29:56 PM
    Author     : Administrator
--%>

<%@page import="dao.ScenarioDAO"%>
<%@page import="entity.State"%>
<%@page import="java.util.ArrayList"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@include file="protectPage/protectAdmin.jsp" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">

        <!--Web Title-->
        <title>EMR | Case Management | Create Case | Manual | Case Creation</title>

        <link rel="stylesheet" href="css/foundation.css" />
        <link rel="stylesheet" href="responsive-tables.css">
        <script src="responsive-tables.js"></script>
        <%@include file="/topbar/topbarAdmin.jsp" %>

        <link rel="stylesheet" href="//code.jquery.com/ui/1.11.1/themes/smoothness/jquery-ui.css">
        <script src="//code.jquery.com/jquery-1.10.2.js"></script>
        <script src="//code.jquery.com/ui/1.11.1/jquery-ui.js"></script>
        <link rel="stylesheet" href="/resources/demos/style.css">
        <script type="text/javascript" src="js/humane.js"></script>
        <link rel="stylesheet" href="css/original.css" />
        <script>
            $(function() {
                $("#datepicker").datepicker();
            });

        </script>
        <%            String success = "";
            String error = "";

            if (session.getAttribute("success") != null && !session.getAttribute("success").equals("")) {
                success = (String) session.getAttribute("success");
                session.setAttribute("success", "");
            }

            if (session.getAttribute("error") != null && !session.getAttribute("error").equals("")) {
                error = (String) session.getAttribute("error");
                session.setAttribute("error", "");
            }
            if (session.getAttribute("s") != null && !session.getAttribute("s").equals("")) {
                String s = (String) session.getAttribute("s");
                out.println(s);

            }
        %>
    </head>
    <body>
        <br>
        <!--Breadcrumbs-->
        <ul class="breadcrumbs">
            <li class="current">Step 1: Case Creation</li>
            <li class="unavailable">Step 2: State Creation</li>
            <li class="unavailable"><a href="#">Step 3: Medication Creation</a></li>
            <li class="unavailable"><a href="#">Step 4: Report and Document Creation</a></li>
        </ul>

        <div class="large-centered large-6 columns">

            <%
                //for repopulating the fields, if there is an error
                String scenarioName = "";
                String scenarioDescription = "";
                String admissionInfo = "";
                String patientNRIC = "";
                String firstName = "";
                String lastName = "";
                String dobString = "";
                String allergy = "";
                String temperature0 = "";
                String RR0 = "";
                String HR0 = "";
                String BPS = "";
                String BPD = "";
                String SPO0 = "";
                String intragastricType = "";
                String intragastricAmount = "";
                String intravenousType = "";
                String intravenousAmount = "";
                String output = "";

                if (request.getAttribute("scenarioName") != null) {
                    scenarioName = (String) request.getAttribute("scenarioName");
                }

                if (request.getAttribute("scenarioDescription") != null) {
                    scenarioDescription = (String) request.getAttribute("scenarioDescription");
                }

                if (request.getAttribute("admissionInfo") != null) {
                    admissionInfo = (String) request.getAttribute("admissionInfo");
                }

                if (request.getAttribute("patientNRIC") != null) {
                    patientNRIC = (String) request.getAttribute("patientNRIC");
                }

                if (request.getAttribute("firstName") != null) {
                    firstName = (String) request.getAttribute("firstName");
                }

                if (request.getAttribute("lastName") != null) {
                    lastName = (String) request.getAttribute("lastName");
                }

                if (request.getAttribute("dobString") != null) {
                    dobString = (String) request.getAttribute("dobString");
                }

                if (request.getAttribute("allergy") != null) {
                    allergy = (String) request.getAttribute("allergy");
                }

                if (request.getAttribute("temperature0") != null) {
                    temperature0 = String.valueOf(request.getAttribute("temperature0"));
                }

                if (request.getAttribute("RR0") != null) {
                    RR0 = String.valueOf(request.getAttribute("RR0"));
                }

                if (request.getAttribute("HR0") != null) {
                    HR0 = String.valueOf(request.getAttribute("HR0"));
                }

                if (request.getAttribute("BPS") != null) {
                    BPS = String.valueOf(request.getAttribute("BPS"));
                }

                if (request.getAttribute("BPD") != null) {
                    BPD = String.valueOf(request.getAttribute("BPD"));
                }

                if (request.getAttribute("SPO0") != null) {
                    SPO0 = String.valueOf(request.getAttribute("SPO0"));
                }

                if (request.getAttribute("intragastricType") != null && !request.getAttribute("intragastricType").equals("-")) {
                    intragastricType = (String) request.getAttribute("intragastricType");
                }

                if (request.getAttribute("intragastricAmount") != null && !request.getAttribute("intragastricAmount").equals("-")) {
                    intragastricAmount = (String) request.getAttribute("intragastricAmount");
                }

                if (request.getAttribute("intravenousType") != null && !request.getAttribute("intravenousType").equals("-")) {
                    intravenousType = (String) request.getAttribute("intravenousType");
                }

                if (request.getAttribute("intravenousAmount") != null && !request.getAttribute("intravenousAmount").equals("-")) {
                    intravenousType = (String) request.getAttribute("intravenousAmount");
                }

                if (request.getAttribute("output") != null && !request.getAttribute("output").equals("-")) {
                    intravenousType = (String) request.getAttribute("output");
                }

            %>

            <form data-abide action ="ProcessAddScenario" method ="POST">
                <!--Case Details-->
                <div class="panelCase">
                    <div>
                        <label>Case Name
                            <input type="text" name="scenarioName" value = "<%=scenarioName%>" required pattern ="^[a-zA-Z0-9 ]+$">
                            <small class="error">Please enter a case name.</small>
                        </label>
                    </div>
                    <div>

                        <label>Case Description
                            <textarea style = "resize:vertical"  name="scenarioDescription" rows="10" cols="10" placeholder ="<%=scenarioDescription%>" required></textarea>
                        </label>
                    </div>
                    <div>
                        <label>Admission Information
                            <textarea style = "resize:vertical"  name="admissionInfo" rows="10" cols="10" placeholder = "<%=admissionInfo%>" required></textarea>
                        </label>
                    </div>
                </div>

                <div class="panelCase">
                    <div class="row">
                        <div class="large-4 columns">
                            <label>Patient's NRIC
                                <input type="text" maxlength="9" name ="patientNRIC" value="<%=patientNRIC%>" placeholder="e.g. S9472733Z" required pattern ="^[SFTG]\d{7}[A-Z]$"/>
                                <small class="error">Please enter a valid NRIC according to Singapore's standard. <i>E.g. S9472733Z</i></small>
                            </label>

                        </div>
                        <div class="large-4 columns">
                            <label>First Name
                                <input type="text" name ="firstName" value="<%=firstName%>" required pattern ="^[a-zA-Z ]+$"/>
                                <small class="error">Only alphabets accepted.</small>
                            </label>
                        </div>
                        <div class="large-4 columns">
                            <label>Last Name
                                <input type="text" name ="lastName" value="<%=lastName%>" required pattern ="^[a-zA-Z ]+$"/>
                                <small class="error">Only alphabets accepted.</small>
                            </label>
                        </div>
                    </div>

                    <!--New Row 2-->
                    <div class="row">
                        <div class="large-4 columns">
                            <label>Date of Birth
                                <input type="text" id="datepicker" name = "DOB" value="<%=dobString%>" placeholder="e.g. 21/09/1988" required pattern = "^(((0[1-9]|[12]\d|3[01])\/(0[13578]|1[02])\/((19|[2-9]\d)\d{2}))|((0[1-9]|[12]\d|30)\/(0[13456789]|1[012])\/((19|[2-9]\d)\d{2}))|((0[1-9]|1\d|2[0-8])\/02\/((19|[2-9]\d)\d{2}))|(29\/02\/((1[6-9]|[2-9]\d)(0[48]|[2468][048]|[13579][26])|((16|[2468][048]|[3579][26])00))))$">
                                <small class="error">Please enter in DD/MM/YYYY.</small>
                            </label>
                        </div>
                        <div class="large-4 columns">
                            <label>Allergy
                                <input type="text" name ="allergy" value="<%=allergy%>" required pattern ="^[a-zA-Z ]+$"/>
                                <small class="error">Only alphabets accepted.</small>
                            </label>
                        </div>
                        <div class="large-4 columns">
                            <label>Gender</label>
                            <input type="radio" name="gender" value="Male" id="male" checked="true"><label for="male" class="right inline">Male</label>
                            <input type="radio" name="gender" value="Female" id="female"><label for="female">Female</label>
                        </div>
                    </div>
                </div>

                <!--Health Details-->
                <center>Leave the fields below empty if not applicable.</center><br/>
                <div class="panelCase">
                    <div class="row">
                        <div class="large-4 columns">
                            <label>Temperature
                                <input type="text" name="temperature0" value="<%=temperature0%>" maxlength="4" pattern ="\b(3[4-9](\.[0-9]{1,2})?|4[0-2])(\.[0-9]{1,2})?$\b">
                                <small class="error">Temperature must be between 34 - 42.</small>
                            </label>
                        </div>
                        <div class="large-4 columns">
                            <label>Respiratory Rate
                                <input type="text" name="RR0" value="<%=RR0%>" maxlength = "2" pattern ="^([0-9]|[1-5][0-9]|60)$">
                                <small class="error">Respiratory Rate must be between 0 - 60.</small>
                            </label>
                        </div>
                        <div class="large-4 columns">
                            <label>Heart Rate
                                <input type="text" name="HR0" value="<%=HR0%>" pattern ="^([0-9]|[1-9][0-9]|[1][0-9][0-9]|20[0-0])$">
                                <small class="error">Heart Rate must be between 0 - 200.</small>
                            </label>
                        </div>      
                        <div class="large-4 columns">
                            <label>Blood Pressure Systolic
                                <input type="text" name="BPS" value="<%=BPS%>" maxlength ="3" pattern = "^([0-9]{1,2}|[12][0-9]{2}|300)$">
                                <small class="error">BP systolic must be numeric and between 0 - 300.</small>
                            </label>
                        </div> 
                        <div class="large-4 columns">
                            <label>Blood Pressure Diastolic
                                <input type="text" name="BPD" value="<%=BPD%>" maxlength ="3" pattern = "^([0-9]{1,2}|1[0-9]{2}|200)$">
                                <small class="error">BP diastolic must be numeric and between 0 - 200.</small>
                            </label>
                        </div>
                        <div class="large-4 columns">
                            <label>SpO<sub>2</sub>
                                <input type="text" name="SPO0" value="<%=SPO0%>" maxlength = "3" pattern ="^[0-9][0-9]?$|^100$">
                                <small class="error">SPO must be numeric and between 0 - 100%.</small>
                            </label>
                        </div>
                        <div class="large-4 columns">
                            <label>Intake - Oral/Intragastric<br>(Type)
                                <input type="text" name="intragastricType" value="<%=intragastricType%>">
                            </label>
                        </div>
                        <div class="large-4 columns">
                            <label>Intake - Oral/Intragastric <br>(Amount)
                                <input type="text" name="intragastricAmount" value="<%=intragastricAmount%>">
                            </label>
                        </div>  
                        <div class="large-4 columns">
                            <label>Intake - Intravenous <br>(Type)
                                <input type="text" name="intravenousType" value="<%=intravenousType%>">
                            </label>
                        </div>  
                        <div class="large-4 columns">
                            <label>Intake - Intravenous <br>(Amount)
                                <input type="text" name="intravenousAmount" value="<%=intravenousAmount%>">
                            </label>
                        </div>
                        <div class="large-4 columns">
                            <label><br>Output
                                <input type="text" name="output" value="<%=output%>">
                            </label>
                        </div>
                        <div class="large-4 columns">
                        </div>  
                    </div>
                </div> 
                <br/><br/>
                <center><input type="submit" value="Proceed to Step 2  >>" class="button"></center> 
            </form>
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

    </body>
    <script type="text/javascript" src="js/humane.js"></script>
</html>
