<%-- 
    Document   : viewCaseAdmin
    Created on : Mar 10, 2015, 9:46:38 PM
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
        <title>EMR | Case Management | Manage Case | Case Information</title>
        
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
            <li class="current">Case Information</li>
            <li><a href="viewState.jsp">State Information</a></li>
            <li><a href="viewMedication.jsp">Medication </a></li>
            <li><a href="viewReportDocument.jsp">Report and Document </a></li>
        </ul>

        <div class="large-centered large-6 columns">
            <%                String scenarioID = "";
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
                    String newDefaultVital = "no";
                    if (vitalList.size() <= 0) {
                        newDefaultVital = "yes";
                    }
                    if (temperature0.equals("0.00") || temperature0.equals("0.0")) {
                        temperature0 = "";
                    }
                    if (RR0.equals("0")) {
                        RR0 = "-";
                    }
                    if (HR0.equals("0")) {
                        HR0 = "-";
                    }
                    if (BPS.equals("0")) {
                        BPS = "-";
                    }
                    if (BPD.equals("0")) {
                        BPD = "-";
                    }
                    if (SPO0.equals("0")) {
                        SPO0 = "-";
                    }
            %>

            <form data-abide action ="viewState.jsp" method ="POST">
                <!--Case Details-->
                <div class="panelCase">
                    
                    <input type="hidden" name="retrieveNRIC" value="<%=patientNRIC%>">
                    <input type="hidden" name="scenarioID" value="<%=scenarioID%>">  
                    <div class="row">
                        <label>Case Name</label>
                            <p><%=scenarioName%></p>
                        
                    </div>
                    <div class="row">
                        <label>Case Description</label>
                        <p><%=scenarioDescription%></p>
                           
                    </div>
                    
                    <div class="row">
                        <label>Admission Information</label>
                        <p><%=admissionInfo%></p>
                        
                    </div>
                </div>
                    
                <div class="row">  
                    <div class="panelCase">
                        <div class="row">
                            <div class="large-4 columns">
                                <label>Patient's NRIC</label>
                                   
                                <p><%=patientNRIC%></p>

                            </div>
                            <div class="large-4 columns">
                                <label>First Name</label>
                                <p><%=firstName%></p>
                                
                            </div>
                            <div class="large-4 columns">
                                <label>Last Name</label>
                                <p><%=lastName%></p>
                            </div>
                        </div>

                        <!--New Row 2-->
                        <div class="row">
                            <div class="large-4 columns">
                                <label>Date of Birth</label>
                                    <p><%=dobString%></p>
                                
                            </div>
                            <div class="large-4 columns">
                                <label>Allergy</label>
                                <p><%=allergy%></p>
                                
                            </div>
                            <div class="large-4 columns">
                                <label>Gender</label>
                                <p><%=gender%></p>
                                
                            </div>
                        </div>
                    </div>

                    <!--Health Details-->
                    <div class="panelCase">
                        <div class="row">
                            <div class="large-4 columns">
                                <input type="hidden" name="newDefaultVital" value="<%=newDefaultVital%>">
                                <label>Temperature</label>
                                <p><%=temperature0%></p>
                            </div>
                            <div class="large-4 columns">
                                <label>Respiratory Rate</label>
                                <p><%=RR0%></p>
                            </div>
                            <div class="large-4 columns">
                                <label>Heart Rate</label>
                                <p><%=HR0%></p>
                            </div>
                            <div class="large-4 columns">
                                <label>Blood Pressure Systolic</label>
                                <p><%=BPS%></p>
                            </div> 
                            <div class="large-4 columns">
                                <label>Blood Pressure Diastolic</label>
                                <p><%=BPD%></p></label>
                            </div>
                            <div class="large-4 columns">
                                <label>SpO<sub>2</sub></label>
                                <%
                                    if(SPO0.equals("")) {
                                        SPO0 = "-";
                                    }
                                %>
                                <p><%=SPO0%></p>
                            </div>
                                    
                            <div class="large-4 columns">
                                <label>Intake - Oral/Intragastric <br>(Type)</label>
                                <p><%=intragastricType%></p>
                            </div>
                            <div class="large-4 columns">
                                <label>Intake - Oral/Intragastric <br>(Amount)</label>
                                <p><%=intragastricAmount%></p>
                            </div>  
                            <div class="large-4 columns">
                                <label>Intake - Intravenous <br>(Type)</label>
                                <p><%=intravenousType%></p>
                            </div>  
                            <div class="large-4 columns">
                                <label>Intake - Intravenous <br>(Amount)</label>
                                <p><%=intravenousAmount%></p>
                            </div>
                            <div class="large-4 columns">
                                <label><br>Output</label>
                                <p><%=output%></p>
                            </div>
                                <div class="large-4 columns">
                            </div>
                        </div>
                    </div>
                </div>
                <br/>
                <center><input type="submit" value="Next  >>" class="button small"></center>
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
