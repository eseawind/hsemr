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
            $(function () {
                $("#datepicker").datepicker();
            });
        </script>
        <%
        String success = "";
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

        <title>Case Setup - Create Case</title>
    </head>
    <body>

    <center><h1>Case Set Up</h1>
    <h2>Step 1: Create case</h2>
       
    <form data-abide action ="ProcessAddScenario" method ="POST">
            <div class="row">
                <div class="small-8">
                    <div class="row">
                        <div class="small-3 columns">
                            <label for="right-label" class="right inline">Case Name</label>
                        </div>
                        <div class="small-9 columns">
                            <input type="text" id="password" name="scenarioName" required>
                        </div>
                    </div>
                </div>
            </div>

      
    <dl class="accordion" data-accordion>
        <dd class="accordion-navigation">
            <a href="#panel1">Case Information</a>

            <div id="panel1" class="content">
                <center>
                    <div class="large-9">
                        <label>Case Description</label>
                        <textarea style = "resize:vertical"  name="scenarioDescription" rows="2" cols="10" required></textarea>

                        <label>Admission Information</label>
                        <textarea style = "resize:vertical"  name="admissionInfo" rows="2" cols="10" required></textarea>
                    </div>
                </center>
            </div>
        </dd>
        
        <dd class="accordion-navigation">
            <a href="#panel2">Patient's Information</a>
            <div id="panel2" class="content">
                <!--New row 1-->
                <div class="row">

                <div class="row">
                    <div class="large-4 columns">
                        <label>Patient's NRIC
                            <input type="text" maxlength="9" name ="patientNRIC" value="S923445I" required pattern ="^[SFTG]\d{7}[A-Z]$"/>
                            <small class="error">Please enter a valid NRIC according to Singapore's standard.</small>
                        </label>
                        
                    </div>
                    <div class="large-4 columns">
                        <label>First Name
                            <input type="text" name ="firstName" value="grace" required pattern ="^[a-zA-Z]+$"/>
                            <small class="error">Only alphabets accepted.</small>
                        </label>
                    </div>
                    <div class="large-4 columns">
                        <label>Last Name
                            <input type="text" name ="lastName" value="Khoo" required pattern ="^[a-zA-Z]+$"/>
                            <small class="error">Only alphabets accepted.</small>
                        </label>
                    </div>
                </div>
                    
                <!--New Row 2-->
                <div class="row">
                    <div class="large-4 columns">
                        <label>Date of Birth</label>
                        <input type="text" id="datepicker" name = "DOB" value="01/10/1992" required pattern = "^(((0[1-9]|[12]\d|3[01])\/(0[13578]|1[02])\/((19|[2-9]\d)\d{2}))|((0[1-9]|[12]\d|30)\/(0[13456789]|1[012])\/((19|[2-9]\d)\d{2}))|((0[1-9]|1\d|2[0-8])\/02\/((19|[2-9]\d)\d{2}))|(29\/02\/((1[6-9]|[2-9]\d)(0[48]|[2468][048]|[13579][26])|((16|[2468][048]|[3579][26])00))))$">
                        <small class="error">Please enter in DD/MM/YYYY.</small>
                    </div>
                    <div class="large-4 columns">
                        <label>Allergy</label>
                        <input type="text" name ="allergy" value="no allergy" required pattern ="^[a-zA-Z ]+$"/>
                        <small class="error">Only alphabets accepted.</small>
                    </div>
                    <div class="large-4 columns">
                        <label>Gender</label>
                        <input type="radio" value="Male" name = "gender" required> Male <br/>
                        <input type="radio" value="Female" name = "gender"> Female
                    </div>
                </div>
                
            </div>
        </dd>
        <dd class="accordion-navigation">
            <a href="#panel3">Default Vital Signs</a>
            <!--State 0-->
            <div id="panel3" class="content">
                <div style="margin-left:100px;"> Leave empty if not applicable.</div><br/>
                <div class="row">
                    <div class="large-4 columns">
                        <label>Temperature</label>
                        <input type="text" name="temperature0" value="56" maxlength="4" pattern ="\b(3[4-9](\.[0-9]{1,2})?|4[0-2])(\.[0-9]{1,2})?$\b">
                        <small class="error">Temperature must be between 34 - 42.</small>
                    </div>
                    <div class="large-4 columns">
                        <label>Respiratory Rate</label>
                        <input type="text" name="RR0" value="60" maxlength = "2" pattern ="^([0-9]|[1-5][0-9]|60)$">
                        <small class="error">Respiratory Rate must be between 0 - 60.</small>
                    </div>
                    <div class="large-4 columns">
                        <label>Heart Rate</label>
                        <input type="text" name="HR0" value="71" pattern ="^([0-9]|[1-9][0-9]|[1][0-9][0-9]|20[0-0])$">
                        <small class="error">Heart Rate must be between 0 - 200.</small>
                    </div>
                    <div class="large-4 columns">
                        <label>Blood Pressure Systolic</label>
                        <input type="text" name="BPS" value="72" maxlength ="3" pattern = "^([0-9]{1,2}|[12][0-9]{2}|300)$">
                        <small class="error">BP systolic must be numeric and between 0 - 300.</small>
                    </div> 
                    <div class="large-4 columns">
                        <label>Blood Pressure Diastolic</label>
                        <input type="text" name="BPD" value="75" maxlength ="3" pattern = "^([0-9]{1,2}|1[0-9]{2}|200)$">
                        <small class="error">BP diastolic must be numeric and between 0 - 200.</small>
                    </div>
                    <div class="large-4 columns">
                        <label>SpO<sub>2</sub></label>
                        <input type="text" name="SPO0" value="78" maxlength = "3" pattern ="^[0-9][0-9]?$|^100$">
                        <small class="error">SPO must be numeric and between 0 - 100%.</small>
                    </div>
                   
                    <div class="large-4 columns"></div>
                    <div class="large-4 columns"></div>
                </div>
            </div>
        </dd>
    </dl>
    <br/>
    <center><input type ="submit" class ="button" value ="Continue"></center>
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
