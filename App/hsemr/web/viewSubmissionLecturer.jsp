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
        <title>NP Health Sciences | View Submissions</title>
        <%@include file="/topbar/topbarLecturer.jsp" %>
    </head>
    <body>
        <br/>
        <script src="js/foundation.min.js"></script>
        <div class="row" style="padding-top: 30px;">
            <center>
                <h1>View Submissions</h1></center>
            <br/>
            <div class="large-12 columns" style="padding-top: 20px;">

                <%                    //retrieve note's information
                    List<Note> notesList = NoteDAO.retrieveAll();
                    String userLoggedIn = (String) session.getAttribute("lecturer");
                    String practicalGroupID = "";
                    String nursesInCharge = "";
                    String notes = "";
                    String dateTime = "";
                    if (notesList == null || notesList.size() == 0) {%>

                <label for="right-label" class="right inline">No groups have entered their notes yet.</label>

                <% } else { %>
                <form action ="ProcessRetrieveNotesByPracticalGroup" method ="POST">
                    <div class="row">
                      <div class="small-8">
                        <div class="row">
                          <div class="small-3 columns">
                            <label for="right-label" class="right">Practical Group</label>
                          </div>
                          <div class="small-9 columns">
                            <select name = "practicalGroup" required>
                                <option disabled="disabled" selected="selected" value = "">--Please select the practical group to view--</option>
                                <% 
                                String loggedInLecturer = (String)session.getAttribute("lecturer");
                                out.println(loggedInLecturer);
                                List<PracticalGroup> practicalGroupList = PracticalGroupDAO.retrieveByLecturerID(loggedInLecturer);
                                for (PracticalGroup practicalGroup : practicalGroupList) {%>
                                <option><%=practicalGroup.getPracticalGroupID()%></option>
                                <% }
                                %>
                            </select>
                          </div>   
                        </div>
                      </div>
                    </div>

                    <div class="row">
                      <div class="small-8">
                        <div class="row">
                          <div class="small-3 columns">
                            <label for="right-label" class="right">Scenario Name</label>
                          </div>
                          <div class="small-9 columns">
                            <select name = "scenarioName" required>
                                <option disabled="disabled" selected="selected" value = "">--Please select the scenario to view--</option>
                                <% 
                                List<Scenario> scenarioList = ScenarioDAO.retrieveAll();
                                for (Scenario scenario : scenarioList) {%>
                                <option><%=scenario.getScenarioName()%></option>
                                <% }
                                %>
                            </select>
                          </div>   
                        </div>
                      </div>
                    </div>
                            <center><input type ="submit" value ="View Notes" class = "button tiny"/></center>
                </form>

            
            
                    <%

                        DateFormat df = new SimpleDateFormat("yyyy-M-dd HH:mm:ss");
                        
                        List<Note> retrievedNoteList = (List<Note>)request.getAttribute("retrievedNoteList");
                        
                        if(retrievedNoteList != null){%>
                        <%
                            //retrieve 1st note to get the practical group
                            Note retrieved1Note = retrievedNoteList.get(1); 
                            String practicalGroup = retrieved1Note.getPracticalGroupID();
                            String scenarioName = ScenarioDAO.retrieve(retrieved1Note.getScenarioID()).getScenarioName();
                        
                        %>
                            <center><h2>Submissions for <%=practicalGroup%> for <%=scenarioName%> </h2></center>
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
                            <%for (Note note: retrievedNoteList) {

                    %>
                    
                    <tr>
                        <td><%=note.getPracticalGroupID() %></td>
                        <td><%=note.getGrpMemberNames() %></td>
                        <td><%=note.getMultidisciplinaryNote()%></td>
                        <td><%=df.format(note.getNoteDatetime())%></td>
                    </tr>
                    <%

                        }
                        }
                        
                    }


                    %> 

                </table>
                <!--<form action="ProcessExportPDF" method="POST">
                    <br>
                    <input type="submit" class="report-despatch button tinytable" value="Export to PDF">
                </form>-->
            </div>
        </div>
        <script type="text/javascript" src="js/humane.js"></script>
    </body>
    

</html>
