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
//            function ValidateForm()
//            {
//                $('span.error_msg').html('');
//               var success = true;
//                $("#personID input").each(function()
//                    {
//                        if($(this).val()=="")
//                        {
//                            $(this).next().html("Field needs filling");
//                            success = false;
//                        }
//                });
//                return success;
//            }
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
        %>

        <title>Case Setup - Case Creation</title>

    </head>
    <body>
        <br>
    <center>
        
        <ul class="breadcrumbs">
                <li class="current">Step 1: Case Creation</li>
                <li class="unavailable">Step 2: State Creation</li>
                <li class="unavailable"><a href="#">Step 3: Medication Creation</a></li>
                <li class="unavailable"><a href="#">Step 4: Report and Document Creation</a></li>
            </ul>
        <div class="large-centered large-10 columns">

            

            <h1>Step 1: Case Set Up</h1><br/>
            <!--<b>Step 1: Case creation</b> > Step 2: State creation > Step 3: Medication creation > Step 4: Report and Document creation-->
            <!--    <ul class="breadcrumbs">
                    <li><a href="#">Step 1: Create Case</a></li>
                    <li><a href="#">Step 2: Create State</a></li>
                    <li><a href="#">Step 3: Create Medication</a></li>
                    <li><a href="#">Step 3: Upload Reports</a></li>
                    <li><a href="#">Step 3: Upload Documents</a></li>
                    <li class="unavailable"><a href="#">Gene Splicing</a></li>
                    <li class="current"><a href="#">Cloning</a></li>
                </ul>-->

            <!--    <h2>Step 1: Create case</h2>-->

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


            %>

            <form data-abide action ="ProcessAddScenario" method ="POST">
                <div class="row">
                    <div class="small-8">
                        <div class="row">
                            <div class="small-3 columns">
                                <label for="right-label" class="right inline" >Case Name</label>
                            </div>
                            <div class="small-9 columns">
                                <input type="text" name="scenarioName" value = "<%=scenarioName%>" required pattern ="^[a-zA-Z0-9 ]+$">
                                <small class="error">Please enter a case name.</small>
                            </div>
                        </div>
                    </div>
                </div>


                <!--<dl class="accordion" data-accordion>-->
                <!--<dd class="accordion-navigation">-->
                <!--<a href="#panel1">Case Information</a>-->

                <div id="panel1" class="content">
                    <center>
                        <div class="large-9">
                            <label>Case Description</label>
                            <textarea style = "resize:vertical"  name="scenarioDescription" rows="2" cols="10" placeholder ="<%=scenarioDescription%>" required></textarea>
                              
                            <label>Admission Information</label>
                            <textarea style = "resize:vertical"  name="admissionInfo" rows="2" cols="10" placeholder = "<%=admissionInfo%>" required></textarea>
                        </div>
                    </center>
                </div>
                <!--</dd>-->

                <!--<dd class="accordion-navigation">-->
                <!--<a href="#panel2">Patient's Information</a>-->
                <!--<div id="panel2" class="content">-->
                <!--New row 1-->
                <div class="row">

                    <div class="row">
                        <div class="large-4 columns">
                            <label>Patient's NRIC
                                <input type="text" maxlength="9" name ="patientNRIC" value="<%=patientNRIC%>" required pattern ="^[SFTG]\d{7}[A-Z]$"/>
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
                            <label>Date of Birth</label>
                            <input type="text" id="datepicker" name = "DOB" value="<%=dobString%>" required pattern = "^(((0[1-9]|[12]\d|3[01])\/(0[13578]|1[02])\/((19|[2-9]\d)\d{2}))|((0[1-9]|[12]\d|30)\/(0[13456789]|1[012])\/((19|[2-9]\d)\d{2}))|((0[1-9]|1\d|2[0-8])\/02\/((19|[2-9]\d)\d{2}))|(29\/02\/((1[6-9]|[2-9]\d)(0[48]|[2468][048]|[13579][26])|((16|[2468][048]|[3579][26])00))))$">
                            <small class="error">Please enter in DD/MM/YYYY.</small>
                        </div>
                        <div class="large-4 columns">
                            <label>Allergy</label>
                            <input type="text" name ="allergy" value="<%=allergy%>" required pattern ="^[a-zA-Z ]+$"/>
                            <small class="error">Only alphabets accepted.</small>
                        </div>
                        <div class="large-4 columns">
                            <label>Gender</label>
                            <input type="radio" value="Male" name = "gender" checked="true"> Male <br/>
                            <input type="radio" value="Female" name = "gender"> Female
                        </div>
                    </div>

                </div>
                <!--</dd>-->
                <!--<dd class="accordion-navigation">-->
                <!--<a href="#panel3">Default Vital Signs for State 0</a>-->
                <!--State 0-->
                <div id="panel3" class="content">
                    <div style="margin-left:100px;"> Leave empty if not applicable.</div><br/>
                    <div class="row">
                        <div class="large-4 columns">
                            <label>Temperature</label>
                            <input type="text" name="temperature0" value="<%=temperature0%>" maxlength="4" pattern ="\b(3[4-9](\.[0-9]{1,2})?|4[0-2])(\.[0-9]{1,2})?$\b">
                            <small class="error">Temperature must be between 34 - 42.</small>
                        </div>
                        <div class="large-4 columns">
                            <label>Respiratory Rate</label>
                            <input type="text" name="RR0" value="<%=RR0%>" maxlength = "2" pattern ="^([0-9]|[1-5][0-9]|60)$">
                            <small class="error">Respiratory Rate must be between 0 - 60.</small>
                        </div>
                        <div class="large-4 columns">
                            <label>Heart Rate</label>
                            <input type="text" name="HR0" value="<%=HR0%>" pattern ="^([0-9]|[1-9][0-9]|[1][0-9][0-9]|20[0-0])$">
                            <small class="error">Heart Rate must be between 0 - 200.</small>
                        </div>
                        <div class="large-4 columns">
                            <label>Blood Pressure Systolic</label>
                            <input type="text" name="BPS" value="<%=BPS%>" maxlength ="3" pattern = "^([0-9]{1,2}|[12][0-9]{2}|300)$">
                            <small class="error">BP systolic must be numeric and between 0 - 300.</small>
                        </div> 
                        <div class="large-4 columns">
                            <label>Blood Pressure Diastolic</label>
                            <input type="text" name="BPD" value="<%=BPD%>" maxlength ="3" pattern = "^([0-9]{1,2}|1[0-9]{2}|200)$">
                            <small class="error">BP diastolic must be numeric and between 0 - 200.</small>
                        </div>
                        <div class="large-4 columns">
                            <label>SpO<sub>2</sub></label>
                            <input type="text" name="SPO0" value="<%=SPO0%>" maxlength = "3" pattern ="^[0-9][0-9]?$|^100$">
                            <small class="error">SPO must be numeric and between 0 - 100%.</small>
                        </div>

                        <div class="large-4 columns"></div>
                        <div class="large-4 columns"></div>
                    </div>
                </div>
                <!--</dd>-->
                <!--</dl>-->
                <br/>
                <input type="submit" value="Proceed" class="button tiny">  
            </form>
        </div>
    </center>
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
