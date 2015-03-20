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
        
        <!--Web Title-->
        <title>EMR | Case Management | Manage Case | Edit Case Information</title>
        
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
        %>

    </head>
    <body>
        <br>
        <!--Breadcrumbs-->
        <ul class="breadcrumbs">
            <li class="current">Edit Case Information</li>
            <li><a href="editState.jsp">Edit State Information</a></li>
            <li><a href="editMedication.jsp">Edit Medication </a></li>
            <li><a href="editReportDocument.jsp">Edit Report and Document </a></li>
        </ul>

        <div class="large-centered large-6 columns">
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
                    String firstName = "";
                    String lastName = "";
                    String dobString = "";

                    String allergy = "";
                    String gender = "";
                    
                    if(!patientNRIC.equals("-")){      
                        Patient pat = PatientDAO.retrieve(patientNRIC);


                        firstName = pat.getFirstName();
                        lastName = pat.getLastName();
                        dobString = pat.getDob();

                        allergy = PatientDAO.retrieveAllergy(patientNRIC);
                        gender = pat.getGender();
                    }
                    List<Vital> vitalList = VitalDAO.retrieveAllVitalByScenarioID(scenarioID);
                    Vital initialVital;
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
                   
                    String newDefaultVital = "no";
                    if(vitalList != null){
                        for (int i = 0; i < vitalList.size(); i++) {
                            Vital v = vitalList.get(i);
                            if (v.getInitialVital() == 1) {
                                initialVital = v;

                                temperature0 = String.valueOf(initialVital.getTemperature());
                                RR0 = String.valueOf(initialVital.getRr());
                                HR0 = String.valueOf(initialVital.getHr());
                                BPS = String.valueOf(initialVital.getBpSystolic());
                                BPD = String.valueOf(initialVital.getBpDiastolic());
                                SPO0 = String.valueOf(initialVital.getSpo());
                                intragastricType = initialVital.getOralType();
                                intragastricAmount = initialVital.getOralAmount();
                                intravenousType = initialVital.getIntravenousType();
                                intravenousAmount = initialVital.getIntravenousAmount();
                                output = initialVital.getOutput();
                            }
                        }
                            
                            if (vitalList.size() <= 0) {
                                newDefaultVital = "yes";
                            }
                    }
                    if (temperature0.equals("0.00") || temperature0.equals("0.0")) {
                        temperature0 = "";
                    }
                    if (RR0.equals("0")) {
                        RR0 = "";
                    }
                    if (HR0.equals("0")) {
                        HR0 = "";
                    }
                    if (BPS.equals("0")) {
                        BPS = "";
                    }
                    if (BPD.equals("0")) {
                        BPD = "";
                    }
                    if (SPO0.equals("0")) {
                        SPO0 = "";
                    }
                    
                    if (intragastricType.equals("-")) {
                        intragastricType = "";
                    }
                    
                    if (intragastricAmount.equals("-")) {
                        intragastricAmount = "";
                    }
                    
                    if (intravenousType.equals("-")) {
                        intravenousType = "";
                    }
                    
                    if (intravenousAmount.equals("-")) {
                        intravenousAmount = "";
                    }
                    
                    if (output.equals("-")) {
                        output = "";
                    }
            %>

            <form data-abide action ="ProcessEditScenario" method ="POST">
                <!--Case Details-->
                <div class="panelCase">
                    
                    <input type="hidden" name="retrieveNRIC" value="<%=patientNRIC%>">
                    <input type="hidden" name="scenarioID" value="<%=scenarioID%>">  
                    <div class="row">
                        <label>Case Name
                            <input type="text" name="scenarioName" value = "<%=scenarioName%>" required pattern ="^[a-zA-Z0-9 ]+$">
                            <small class="error">Please enter a case name.</small>
                        </label>
                    </div>
                    <div class="row">
                        <label>Case Description
                            <textarea style = "resize:vertical"  name="scenarioDescription" rows="10" cols="10"  required><%=scenarioDescription%></textarea>
                        </label>
                    </div>
                    
                    <div class="row">
                        <label>Admission Information
                            <textarea style = "resize:vertical"  name="admissionInfo" rows="10" cols="10" required><%=admissionInfo%></textarea>
                        </label>
                    </div>
                </div>
                    
                <div class="row">  
                    <div class="panelCase">
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
                                <label>Date of Birth
                                    <input type="text" id="datepicker" name = "DOB" value="<%=dobString%>" required pattern = "^(((0[1-9]|[12]\d|3[01])\/(0[13578]|1[02])\/((19|[2-9]\d)\d{2}))|((0[1-9]|[12]\d|30)\/(0[13456789]|1[012])\/((19|[2-9]\d)\d{2}))|((0[1-9]|1\d|2[0-8])\/02\/((19|[2-9]\d)\d{2}))|(29\/02\/((1[6-9]|[2-9]\d)(0[48]|[2468][048]|[13579][26])|((16|[2468][048]|[3579][26])00))))$">
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
                                <%
                                    if (gender.equals("Male")) {
                                %>
                                <input type="radio" name="gender" value="Male" id="male" checked="true"><label for="male" class="right inline">Male</label>
                                <input type="radio" name="gender" value="Female" id="female"><label for="female">Female</label>

                                <%
                                } else {
                                %>
                                <input type="radio" name="gender" value="Male" id="male"><label for="male" class="right inline">Male</label>
                                <input type="radio" name="gender" value="Female" id="female" checked="true"><label for="female">Female</label>
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
                    <!--Health Details-->
                    <center>Leave the fields below empty if not applicable.</center><br/>
                    <div class="panelCase">
                        <div class="row">
                            <div class="large-4 columns">
                                <input type="hidden" name="newDefaultVital" value="<%=newDefaultVital%>">
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
                                <label>Intake - Oral/Intragastric <br>(Type)
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
                </div>
                <!--</dd>-->
                <!--</dl>-->
                <br/>
                <center><input type="submit" value="Save and Proceed  >>" class="button small"></center>
            </form>
            <%
                }
            %>
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
