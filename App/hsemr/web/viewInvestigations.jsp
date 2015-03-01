<%-- 
    Document   : viewInvestigations
    Created on : Mar 1, 2015, 8:01:44 PM
    Author     : Administrator
--%>

<%@page import="java.util.*"%>
<%@page import="dao.*"%>
<%@page import="entity.*"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <script type="text/javascript" src="jquery.js"></script>
    </head>

    <h4>Doctor's Order</h4><br/>

        <%
            //for autorefresh testing
            
            out.println(StateHistoryDAO.retrieveLatestStateActivatedByLecturer("lec1").getStateID());
            out.println(System.currentTimeMillis());
            
            //for autorefresh testing
            
            if (StateHistoryDAO.retrieveAll(scenarioID).isEmpty()) {
                StateHistoryDAO.addStateHistory(scenarioID, stateID, pg.getLecturerID() );
            }
            HashMap<String, String> activatedStates = StateHistoryDAO.retrieveAll(scenarioID);
            // to store reports of all activated states
            HashMap<List<Report>, String> stateReportsHM = new HashMap<List<Report>, String>();
            // remove duplicates
            List<String> tempList = new ArrayList<String>();
            // remove duplicates and add reports of that state into array reports
            for (Map.Entry<String, String> entry : activatedStates.entrySet()) {
                String state = entry.getKey();
                if (tempList.size() == 0) {
                    tempList = new ArrayList<String>();
                }
                if (tempList.contains(state)) {
                    activatedStates.remove(state);
                } else {
                    tempList.add(state);
                    List<Report> reports = ReportDAO.retrieveReportsByState(scenarioID, state);
                    String doctorOrderTime = entry.getValue();
                    if (reports != null && reports.size() != 0) {
                        stateReportsHM.put(reports, doctorOrderTime);
                    }
                }
            }
            if (stateReportsHM != null && stateReportsHM.size() != 0) {
        %>

        <table>
            <tr>
                <td><b>Reports Ordered</b></td>
                <td><b>Order Time</b></td>
                <td><b>Despatched Time</b></td>
                <td><b>Action</b></td>
                <td><b>Report Results</b></td>
            </tr>

            <%
                DateFormat df = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");

                if (StateHistoryDAO.retrieveAll(scenarioID).isEmpty()) {
                   // StateHistoryDAO.addStateHistory(scenarioID, stateID);

                    StateHistoryDAO.addStateHistory(scenarioID, stateID, pg.getLecturerID());
                }

                // loop through each report
                int counter = 0;
                for (Map.Entry<List<Report>, String> entry : stateReportsHM.entrySet()) {
                    List<Report> stateReports = entry.getKey();

                    // if needed to display:
                    String doctorOrderTime = entry.getValue();

                    for (Report report : stateReports) {
                        String reportName = report.getReportName();
                        String reportFile = report.getReportFile();

                        String reportDatetime = df.format(report.getReportDatetime());
                        int reportID = report.getReportID();
                        PracticalGroupReport practicalGroupReport = PracticalGroupReportDAO.retrieve(reportID, scenarioID);
                        //int dispatchStatus = report.getDispatchStatus();

                        String reportResults = "";

                        if (practicalGroupReport != null || report.getInitialReport() == 1) {

                            reportResults = "reports/" + reportFile;
                        }


            %> 

            <tr>
                <td><%=reportName%></td>
                <td><%=doctorOrderTime%></td>
                <%
                    // check if require retrieve process 
                    // despatch Date time column 

                    String counterStr = String.valueOf(counter);
                    String firstDespatch = (String) session.getAttribute("clickedID");

                    if (practicalGroupReport != null  || report.getInitialReport() == 1) {
                        if (firstDespatch != null && !firstDespatch.equals("") && firstDespatch.equals(counterStr)) {%>
                <td><div id="reportDateWaiting">Waiting..</div>
                    <div id="reportDateDisplay" style="display:none;"><%=reportDatetime%></div></td>
                    <%
                    } else {%>  
                <td><%=reportDatetime%></td>
                <% }
                    } else {
                        out.println("<td>-</td>");
                    }%> 

                <td><% // action (despatch status) column 
                    if (practicalGroupReport != null  || report.getInitialReport() == 1) {
                        if (firstDespatch != null && !firstDespatch.equals("") && firstDespatch.equals(counterStr)) {%>
                    <div id="reportStatusWaiting">Waiting..</div>
                    <div id="reportStatusDisplay" style="display:none;">Despatched</div></td>
                    <%
                    } else {%> 
                Despatched</td>
                <%  }
                } else {
                %>
            <form action="ProcessDespatch" method="POST">
                <input type="hidden" name="reportName" value="<%=reportName%>">
                <input type="hidden" name="scenarioID" value="<%=scenarioID%>">
                <input type="hidden" name="stateID" value="<%=report.getStateID()%>">
                <input type ="hidden" name="clickedID" value ="<%=counter%>">
                <input type="submit" id="downloadReport" class="report-despatch button tinytable" value="Despatch">
            </form>
            <% } %>
            </td>

            <td>
                <% // results column (link) 
                    if (practicalGroupReport != null  || report.getInitialReport() == 1) {
                        if (firstDespatch != null && !firstDespatch.equals("") && firstDespatch.equals(counterStr)) {
                %>

                <div id="reportLinkMsg">Loading..</div>
                <a href="<%=reportResults%>" id="reportLink" target="_blank" style="display:none;">View Report</a>
                <%
                } else {
                %>
                <a href="<%=reportResults%>" target="_blank">View Report</a>
                <%  }
                    } else {
                        out.println("N/A");

                    }
                %>
            </td>


            </tr>

            <%
                        counter++;
                    }
                }
                session.setAttribute("clickedID", "");
            %>
        </table>
        <%
            } else {
                // if no reports in the array
                out.println("No doctor's order at the moment.");

            }
            session.setAttribute("active", null);

        %>  
</html>
