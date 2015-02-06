<%-- 
    Document   : editScenario
    Created on : Oct 8, 2014, 10:41:45 PM
    Author     : Administrator
--%>
<%@page import="entity.Vital"%>
<%@page import="java.util.List"%>
<%@page import="dao.VitalDAO"%>
<%@page import="dao.AllergyPatientDAO"%>
<%@page import="dao.StateDAO"%>
<%@page import="entity.Patient"%>
<%@page import="dao.PatientDAO"%>
<%@page import="entity.Scenario"%>
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

        <%
//            } else {
//                scenarioName = (String) session.getAttribute("scenarioName");
//                location = (String) session.getAttribute("location");
//            }

        %>

        <title>Edit Case Information</title>

    </head>
    <body>
        <br>
    <center>
        <ul class="breadcrumbs">
            <li>Edit Case Information</li>
            <li><a href="editState.jsp">Edit State Information</a></li>
            <li><a href="editMedication.jsp">Edit Medication </a></li>
            <li><a href="editReportDocument.jsp">Edit Report and Document </a></li>
        </ul>

        <div class="large-centered large-10 columns">



            <h1>Edit Case Information</h1><br/>


            <%                
            String scenarioID = "";
                String sessionScenario = (String) session.getAttribute("scenarioID");
                if (request.getParameter("scenarioID") != null) {
                    scenarioID = request.getParameter("scenarioID");
                    session.setAttribute("scenarioID", scenarioID);
                } else if (sessionScenario != null) {
                    scenarioID = sessionScenario;
                }
                
                Scenario scen = ScenarioDAO.retrieve(scenarioID);
                
                if (scen == null) {
                    out.println("no case selected");
                } else {
                    String scenarioName = scen.getScenarioName();
                    String scenarioDescription = scen.getScenarioDescription();
                    String admissionInfo = scen.getAdmissionNote();

                    State st = StateDAO.retrieveStateInScenario(scenarioID);

                    String patientNRIC = st.getPatientNRIC();
                    Patient pat = PatientDAO.retrieve(patientNRIC);

                    String firstName = pat.getFirstName();
                    String lastName = pat.getLastName();
                    String dobString = pat.getDob();

                    String allergy = PatientDAO.retrieveAllergy(patientNRIC);
                    String gender = pat.getGender();

                    List<Vital> vitalList = VitalDAO.retrieveAllVitalByScenarioID(scenarioID);
                    Vital initialVital;
                    double temperature0 = 0.0;
                    int RR0 = 0;
                    int HR0 = 0;
                    int BPS = 0;
                    int BPD = 0;
                    int SPO0 = 0;

                    for (int i = 0; i < vitalList.size(); i++) {
                        Vital v = vitalList.get(i);
                        if (v.getInitialVital() == 1) {
                            initialVital = v;

                            temperature0 = initialVital.getTemperature();
                            RR0 = initialVital.getRr();
                            HR0 = initialVital.getHr();
                            BPS = initialVital.getBpSystolic();
                            BPD = initialVital.getBpDiastolic();
                            SPO0 = initialVital.getSpo();
                        }
                    }

                
            %>

            <form data-abide action ="ProcessEditScenario" method ="POST">

                <input type="hidden" name="retrieveNRIC" value="<%=patientNRIC%>">
                <input type="hidden" name="scenarioID" value="<%=scenarioID%>">
                <div class="row">
                    <div class="small-8">
                        <div class="row">
                            <div class="small-3 columns">
                                <label for="right-label" class="right inline" >Case Name</label>
                            </div>
                            <div class="small-9 columns">
                                <input type="text" name="scenarioName" value = "<%=scenarioName%>" required pattern ="^[a-zA-Z ]+$">
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
                            <textarea style = "resize:vertical"  name="scenarioDescription" rows="2" cols="10"  required><%=scenarioDescription%></textarea>

                            <label>Admission Information</label>
                            <textarea style = "resize:vertical"  name="admissionInfo" rows="2" cols="10" required><%=admissionInfo%></textarea>
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
                            <%
                                if (gender.equals("Male")) {
                            %>
                            <input type="radio" value="Male" name = "gender" checked="true"> Male <br/>
                            <input type="radio" value="Female" name = "gender"> Female <br/>
                            <%
                            } else {
                            %>
                            <input type="radio" value="Male" name = "gender"> Male <br/>
                            <input type="radio" value="Female" name = "gender" checked = "true"> Female<br/>
                            <%
                                }

                            %>


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
                <input type="submit" value="Save and Proceed" class="button tiny">  
            </form>
                                            <% 
                }
    %>
        </div>
    </center>
    
    <script src="js/vendor/jquery.js"></script>
    <script src="js/foundation.min.js"></script>

    <script>
            $(document).ready(function () {
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
