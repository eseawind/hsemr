<%-- 
    Document   : viewSubmissionLecturer
    Created on : Dec 26, 2014, 11:36:51 PM
    Author     : Jocelyn
--%>

<%@page import="java.util.ArrayList"%>
<%@page import="java.util.TimeZone"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.Date"%>
<%@page import="java.text.DateFormat"%>
<%@page import="java.util.List"%>
<%@page import="entity.*"%>
<%@page import="dao.*"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="dao.*"%> 
<%@page import="controller.*"%> 
<%@include file="protectPage/protectLecturer.jsp" %>
<!DOCTYPE html>

<html>
    <head>
        <meta charset="utf-8" />
        <meta name="viewport" content="width=device-width, initial-scale=1.0" />

        <!--Web Title-->
        <title>EMR | View Submissions</title>

        <link rel="stylesheet" href="css/foundation.css" />
        <link rel="stylesheet" href="css/original.css" />
        <script src="js/vendor/modernizr.js"></script>
        <script type="text/javascript" src="js/humane.js"></script>
        <script type="text/javascript" src="js/app.js"></script>

        <script src="js/vendor/jquery.js"></script>
        <script>

            $(document).ready(function() {
                $(document).foundation();
            });
        </script>
        <%@include file="/topbar/topbarLecturer.jsp" %>
    </head>
    <body>
        <br/>
        <script src="js/foundation.min.js"></script>
        <div class="row" style="padding-top: 30px;">
            <center><h1>View Submissions</h1></center>
            <div class="large-centered large-6 columns" style="padding-top: 30px;">

                <%                    String success = "";
                    String error = "";
                    if (session.getAttribute("success") != null) {
                        success = (String) session.getAttribute("success");
                        session.setAttribute("success", "");
                    }

                    if (session.getAttribute("error") != null) {
                        error = (String) session.getAttribute("error");
                        session.setAttribute("error", "");
                    }
                    //retrieve note's information
                    List<Note> notesList = NoteDAO.retrieveAll();
                    String userLoggedIn = (String) session.getAttribute("lecturer");
                    String practicalGroupID = "";
                    String nursesInCharge = "";
                    String notes = "";
                    String dateTime = "";

                    if (notesList == null || notesList.size() == 0) {%>

                <center>No groups have entered their notes yet.</center>

                <% } else { %>
                <form action ="ProcessRetrieveNotesByPracticalGroup" method ="POST">
                    <div class="row">
                        <label>Practical Group
                            <select name = "practicalGroup" required>
                                <option disabled="disabled" selected="selected" value = "">--Please select the practical group to view--</option>
                                <%
                                    String loggedInLecturer = (String) session.getAttribute("lecturer");
                                    out.println(loggedInLecturer);
                                    List<PracticalGroup> practicalGroupList = PracticalGroupDAO.retrieveByLecturerID(loggedInLecturer);
                                    for (PracticalGroup practicalGroup : practicalGroupList) {%>
                                <option><%=practicalGroup.getPracticalGroupID()%></option>
                                <% }
                                %>
                            </select>
                        </label>
                    </div>

                    <div class="row">
                        <label>Scenario Name
                            <select name = "scenarioName" required>
                                <option disabled="disabled" selected="selected" value = "">--Please select the scenario to view--</option>
                                <%
                                    List<Scenario> scenarioList = ScenarioDAO.retrieveAll();
                                    for (Scenario scenario : scenarioList) {%>
                                <option><%=scenario.getScenarioName()%></option>
                                <% }
                                %>
                            </select>
                        </label>
                    </div><br/><br/>
                    <center><input type ="submit" value ="View Notes" class = "button"/></center>
                </form>
            </div>


            <%
                //retrieve 1st note to get the practical group
                //Note retrieved1Note = retrievedNoteList.get(0);
                // String practicalGroup = retrieved1Note.getPracticalGroupID();
                //String scenarioName = ScenarioDAO.retrieve(retrieved1Note.getScenarioID()).getScenarioName();
                DateFormat df = new SimpleDateFormat("yyyy-M-dd HH:mm:ss");

                //retrieve practicalgrpID & scenarioID & scenarioName
                ArrayList<Note> noteList = (ArrayList<Note>) request.getAttribute("noteList");
                List<MedicationHistory> medicationHistoryList = (List<MedicationHistory>) request.getAttribute("medicationHistoryList");
                List<Vital> vitalList = (List<Vital>) request.getAttribute("vitalList");

                //Get practialGroupID
                String practicalGrpID = (String) request.getAttribute("practicalGrpID");
                String scenarioName = (String) request.getAttribute("scenarioName");
                String scenarioID = (String) request.getAttribute("scenarioID");
                String isPageLoaded = (String) request.getAttribute("isPageLoaded");


            %>

            <hr>
            <div class="large-centered large-12 columns" style="padding-top: 10px;">

                <!--TABLE 1 for notes-->
                <% if (noteList == null || noteList.size() == 0) {
                        if (isPageLoaded == null) {
                            //first time loading this page
                            out.println(" ");
                        } else {%>

                <center><h3>Submissions for <%=practicalGrpID%> for <%=scenarioName%> </h3></center><br/>
                    <%
                            out.println("<p>No Multidisciplinary notes submitted at the moment.</p>");
                        }

                    } else { %>
                <table class="responsive" id="cssTable">
                    <col width="10%">
                    <col width="25%">
                    <col width="50%">
                    <col width="15%">
                    <thead>
                    <p>Multidisciplinary Notes</p>
                    <tr>
                        <th>Time Submitted</th>
                        <th>Practical Group ID</th> 
                        <th>Nurses In-Charge</th>
                        <th>Multidisciplinary Notes</th>
                        
                    </tr>
                    </thead>
                    <%for (Note note : noteList) {

                    %>

                    <tr>
                        <td><%=df.format(note.getNoteDatetime())%></td>
                        <td><%=note.getPracticalGroupID()%></td>
                        <td><%=note.getGrpMemberNames()%></td>
                        <td><%=note.getMultidisciplinaryNote()%></td>
                       
                    </tr>
                    <%
                            }//end of for
                        }//end of else 
                    %> 

                </table>
                <br/><br/>



                <!--TABLE 2 for MEdication history-->

                <%
                    if (medicationHistoryList == null || medicationHistoryList.size() == 0) {
                        if (isPageLoaded == null) {
                            out.println(" ");
                        } else {
                            out.println("<p>No medication history submitted at the moment</p>");
                        }
                    } else {
                %>
                <table class="responsive" id="cssTable">
                    <col width="10%">
                    <col width="25%">
                    <col width="50%">
                    <col width="15%">
                    <thead>
                    <p>Medication History</p>
                    <tr>
                        <th>Medication Datetime</th> 
                        <th>Medication administered</th>
                    </tr>
                    </thead>
                    <%for (MedicationHistory mh : medicationHistoryList) {

                    %>

                    <tr>
                        <td><%=mh.getMedicineDatetime()%></td>
                        <td><%=mh.getMedicineBarcode()%></td>

                    </tr>
                    <% }//end of for loop

                        }//end of else
                    %>
                </table>
                <br/><br/>

                <!--TABLE 3 for Vital signs-->
                <%
                    if (vitalList == null || vitalList.size() == 0) {
                        if (isPageLoaded == null) {
                            out.println(" ");
                        } else {
                            out.println("<p>No Vitals Signs submitted at the moment</p>");
                        }
                    } else {
                        boolean allZero = true;
                        for (Vital vitals : vitalList) {
                            if (vitals.getTemperature() == 0.0 || vitals.getRr() == 0 || vitals.getBpSystolic() == 0 || vitals.getBpDiastolic() == 0 || vitals.getHr() == 0 || vitals.getSpo() == 0) {
                                allZero = false;
                            }
                        }
                        if (allZero == false) {%>
                <table class="responsive" id="cssTable">
                    <col width="10%">
                    <col width="25%">
                    <col width="50%">
                    <col width="15%">
                    <thead>
                    <p>Vital signs </p>
                    <tr>
                        <th>Vitals Datetime</th> 
                        <th>Temperature</th>
                        <th>RR</th>
                        <th>BP Systolic</th>
                        <th>BP Diastolic</th>
                        <th>HR</th>
                        <th>SPO</th>

                    </tr>
                    </thead>
                    <%
                        //DateFormat df = new SimpleDateFormat("yyyy-M-dd HH:mm:ss");
                        for (Vital vitals : vitalList) {
                            if (vitals.getTemperature() == 0.0 && vitals.getRr() == 0 && vitals.getBpSystolic() == 0 && vitals.getBpDiastolic() == 0 && vitals.getHr() == 0 && vitals.getSpo() == 0) {
                                out.println("");
                            } else {
                    %>

                    <tr>
                        <td><%=vitals.getVitalDatetime()%></td>
                        <td><%=vitals.getTemperature()%></td>
                        <td><%=vitals.getRr()%></td>
                        <td><%=vitals.getBpSystolic()%></td>
                        <td><%=vitals.getBpDiastolic()%></td>
                        <td><%=vitals.getHr()%></td>
                        <td><%=vitals.getSpo()%></td>

                    </tr>
                    <%
                                    } //end of else
                                }//end of for loop
                            }//end of allzero false
                        }//end of else

                    %> 

                </table>
                <br/><br/>

                <!--TABLE 4 for Input output-->
                <% if (vitalList == null || vitalList.size() == 0) {
                        if (isPageLoaded == null) {
                            out.println(" ");
                        } else {
                            out.println("<p>No Input/Output submitted at the moment</p>");
                        }
                    } else {
                        boolean allDashes = true;
                        for (Vital vitals : vitalList) {
                            if (!vitals.getOutput().equals("-") || !vitals.getOralType().equals("-") || !vitals.getOralAmount().equals("-") || !vitals.getIntravenousType().equals("-") || !vitals.getIntravenousAmount().equals("-")) {
                                allDashes = false;
                            }
                        }
                        if (allDashes == false) {

                %>
                <table class="responsive" id="cssTable">
                    <col width="20%">
                    <col width="20%">
                    <col width="20%">
                    <col width="20%">
                    <col width="20%">
                    <thead>
                    <p> Intake/Output</p>
                    <tr>
                        <th>Vitals Datetime</th> 
                        <th>Output</th> 
                        <th>Oral Type</th>
                        <th>Oral Amount</th>
                        <th>Intravenous Type</th>
                        <th>Intravenous Amount</th>

                    </tr>
                    </thead>
                    <%                        for (Vital vitalsInputOutput : vitalList) {
                            if (vitalsInputOutput.getOutput().equals("-") && vitalsInputOutput.getOralType().equals("-") && vitalsInputOutput.getOralAmount().equals("-") && vitalsInputOutput.getIntravenousType().equals("-") && vitalsInputOutput.getIntravenousAmount().equals("-")) {
                                out.println("");
                            } else {

                    %>

                    <tr>
                        <td><%=vitalsInputOutput.getVitalDatetime()%></td>
                        <td><%=vitalsInputOutput.getOutput()%></td>
                        <td><%=vitalsInputOutput.getOralType()%></td>
                        <td><%=vitalsInputOutput.getOralAmount()%></td>
                        <td><%=vitalsInputOutput.getIntravenousType()%></td>
                        <td><%=vitalsInputOutput.getIntravenousAmount()%></td>

                    </tr>
                    <%
                                }//end of for loop
                            }
                        }%>
                </table>



                <%//end of else
                        // } //end of big if

                    }
        //end of big else
                %> 

                <form action="ProcessExportPDF" method="POST" target="_blank">
                    <%
                        //For export purpose
                        if (noteList == null && medicationHistoryList == null && vitalList == null) {
                            out.println(" ");
                        } else {
                            session.setAttribute("practicalGrpID", practicalGrpID);
                            session.setAttribute("scenarioID", scenarioID);
                            session.setAttribute("scenarioName", scenarioName);
                    %>
                    <br/><br/><br/>
                    <center> <input type="submit" class="button" value="Export to PDF"> </center>
                    <br/><br/><br/>
                    <%
                            }
                        }
                    %>
                    <!-- <center> <input type="submit" class="report-despatch button tinytable" value="Export to PDF"> </center> -->
                </form>

            </div>
        </div>

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
