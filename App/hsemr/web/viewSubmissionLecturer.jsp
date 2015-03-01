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
            <div class="large-centered large-6 columns" style="padding-top: 10px;">

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
                    </div><br/>
                    <center><input type ="submit" value ="View Notes" class = "button small"/></center>
                </form>
            </div>

            <%
                DateFormat df = new SimpleDateFormat("yyyy-M-dd HH:mm:ss");

                List<Note> retrievedNoteList = (List<Note>) request.getAttribute("retrievedNoteList");

                if (retrievedNoteList != null) {
            %>
            <%
                //retrieve 1st note to get the practical group
                Note retrieved1Note = retrievedNoteList.get(0);
                String practicalGroup = retrieved1Note.getPracticalGroupID();
                String scenarioName = ScenarioDAO.retrieve(retrieved1Note.getScenarioID()).getScenarioName();

            %>

            <hr>
            <div class="large-centered large-12 columns" style="padding-top: 10px;">
                <center><h3>Submissions for <%=practicalGroup%> for <%=scenarioName%> </h3></center><br/>
                <!--TABLE-->
                <table class="responsive" id="cssTable">
                    <col width="15%">
                    <col width="20%">
                    <col width="30%">
                    <col width="15%">
                    <thead>
                        <tr>
                            <th>Practical Group ID</th> 
                            <th>Nurses In-Charge</th>
                            <th>Multidisciplinary Notes</th>
                            <th>Time Submitted</th>
                        </tr>
                    </thead>
                    <%for (Note note : retrievedNoteList) {

                    %>

                    <tr>
                        <td><%=note.getPracticalGroupID()%></td>
                        <td><%=note.getGrpMemberNames()%></td>
                        <td><%=note.getMultidisciplinaryNote()%></td>
                        <td><%=df.format(note.getNoteDatetime())%></td>
                    </tr>
                    <%
                                }
                            }//end of if

                        }//end of else
                    %> 

                </table>
                <br/><br/>
                <form action="ProcessExportPDF" method="POST" target="_blank">
                    <%
                        List<Note> retrievedNoteList = (List<Note>) request.getAttribute("retrievedNoteList");

                        //For export purpose
                        if (retrievedNoteList != null) {
                            //request.setAttribute("notesExport", retrievedList);
                            session.setAttribute("notesExport", retrievedNoteList);%>
                    <center> <input type="submit" class="button small" value="Export to PDF"> </center>
                        <%   }%>
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
