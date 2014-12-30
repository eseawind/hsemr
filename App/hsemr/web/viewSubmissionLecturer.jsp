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
                    List<Note> notesListRetrieved = NoteDAO.retrieveAll();

                    if (notesListRetrieved == null || notesListRetrieved.size() == 0) {%>

                <label for="right-label" class="right inline">No groups have enter their notes yet.</label>

                <% } else { %>
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
                    <%
                        DateFormat df = new SimpleDateFormat("yyyy-M-dd HH:mm:ss");
                        //String reportDatetime = df.format(notesRetrieve.getNoteDatetime());
                        for (int i = notesListRetrieved.size() - 1; i >= 0; i--) {
                            Note notesRetrieve = notesListRetrieved.get(i);
                            String practicalGroupID = notesRetrieve.getPracticalGroupID();
                            String nursesInCharge = notesRetrieve.getGrpMemberNames();
                            String notes = notesRetrieve.getMultidisciplinaryNote();
                            String dateTime = df.format(notesRetrieve.getNoteDatetime());
                    %>
                    <tr>
                        <td><%=practicalGroupID%></td>
                        <td><%=nursesInCharge%></td>
                        <td><%=notes%></td>
                        <td><%=dateTime%></td>
                    </tr>
                    <% }
                        }
                    %>
                </table>
            </div>
        </div>
    </body>
    <script type="text/javascript" src="js/humane.js"></script>

</html>
