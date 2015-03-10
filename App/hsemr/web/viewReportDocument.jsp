<%-- 
    Document   : viewReportDocument
    Created on : Mar 10, 2015, 9:57:04 PM
    Author     : Administrator
--%>


<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.text.DateFormat"%>
<%@page import="java.util.Date"%>
<%@page import="java.util.List"%>
<%@page import="java.util.ArrayList"%>
<%@page import="dao.*"%>
<%@page import="entity.*"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@include file="protectPage/protectAdmin.jsp" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        
        <!--Web Title-->
        <title>EMR | Case Management | Manage Case | Edit Report and Document</title>
        
        <link rel="stylesheet" href="css/foundation.css" />
        <link rel="stylesheet" href="responsive-tables.css">
        <link rel="stylesheet" href="css/original.css" />
        <script src="responsive-tables.js"></script>
        <%@include file="/topbar/topbarAdmin.jsp" %>

        <link rel="stylesheet" href="//code.jquery.com/ui/1.11.1/themes/smoothness/jquery-ui.css">
        <script src="//code.jquery.com/jquery-1.10.2.js"></script>
        <script src="//code.jquery.com/ui/1.11.1/jquery-ui.js"></script>
        <script type="text/javascript" src="js/humane.js"></script>
        <script type="text/javascript" src="js/app.js"></script>
        <link rel="stylesheet" href="/resources/demos/style.css">
        <title>EMR | Case Management | Manage Case | Report and Document</title>
    </head>
    <body>
        <br>
        <ul class="breadcrumbs">
            <li><a href="viewCaseAdmin.jsp">Case Information</a></li>
            <li><a href="viewState.jsp">State Information</a></li>
            <li><a href="viewMedication.jsp">Medication </a></li>
            <li class="current"><a href="#">Report and Document </a></li>
        </ul><br/>

        <br>
        <div class="large-centered large-6 columns">
            <%        String success = "";
                String error = "";

                if (session.getAttribute("success") != null) {

                    success = (String) session.getAttribute("success");
                    session.setAttribute("success", "");
                }
                if (session.getAttribute("error") != null) {

                    error = (String) session.getAttribute("error");
                    session.setAttribute("error", "");
                }
                String scenarioID = (String) session.getAttribute("scenarioID");
                List<State> stateList = StateDAO.retrieveAll(scenarioID);

            %>

                <!--Display reports that are in the database-->
                <%   List<Report> reportList = ReportDAO.retrieveReportsByScenario(scenarioID);
                    if (reportList == null || reportList.size() == 0) {
                        out.println("<center><h3>" + "There are no reports(s) uploaded yet." + "</h3></center>");

                    } %>
            </div>
            <!--End of display reports in the database-->

            

                <!--Display documents that are in the database-->
                <%  List<Document> documentList = DocumentDAO.retrieveDocumentsByScenario(scenarioID);

                    String editingdocument = "editingInProgress";
                    if (documentList == null || documentList.size() == 0) {
                        out.println("<h3>" + "There are no documents(s) uploaded yet." + "</h3>");

                    }%>

            <!--End of display documents in the database-->


            
            <br/><br/>

            <%
                List<Report> currentReportList = ReportDAO.retrieveReportsByScenario(scenarioID);
                String stateID = "";
                String reportName = "";
                String reportURL = "";
                String dateTime = "";
                String reportFile = "";
                Date date = null;
                int counter = 0;
                int sizeList = currentReportList.size();
                DateFormat df = new SimpleDateFormat("MM/dd/yyyy HH:mm:ss");

                if (sizeList > 0) {
            %> 

            <h3>Current Reports</h3>
            <!-- Report table -->

            <table class="responsive" id="cssTable" align="center">

                <col width="10%">
                <col width="20%">
                <col width="40%">
                <col width="20%">
                <thead>
                    <tr>
                        <th>State</th>
                        <th>Report Name</th>
                        <th>File Name</th>
                        <th>View Report</th>
                    </tr>
                </thead>

                <%for (Report r : currentReportList) {
                        stateID = r.getStateID();
                        reportName = r.getReportName();
                        reportFile = r.getReportFile();
                        date = r.getReportDatetime();
                        dateTime = df.format(date);
                        reportURL = "reports/" + reportFile;
                        //                String currentStateID = "state" + counter;
                        //                String stateIDNum = "state" + counter;
                        String dateTimeNum = "dateTime" + counter;


                %>

                <tr>
                    <td><%=stateID%></td>
                    <td><%=reportName%></td>
                    <td><%=reportFile%></td>



                    <td><a href="<%=reportURL%>" target="_blank" >View Report</a></td>
      
                </tr>
                <%
                        counter++;
                    }

                %>
            </table>
            <% } %>
            <!-- End Report table -->
            <br><br>


            <%
                List<Document> currentDocumentList = DocumentDAO.retrieveDocumentsByScenario(scenarioID);
                String docStateID = "";
                String consentName = "";
                String docURL = "";
                String documentURL = "";
                int counterDoc = 0;

                if (currentDocumentList.size() > 0) {
            %>

            <h3> Current Documents</h3>

            <!-- Documents table -->
            <table class="responsive" id="cssTable" align="center">
                <col width="10%">
                <col width="20%">
                <col width="40%">
                <col width="20%">
                <thead>
                    <tr>
                        <th>State</th>
                        <th>Document Name</th>
                        <th>Document URL</th>
                        <th>View Report</th>
                    </tr>
                </thead>

                <%
                    for (Document d : currentDocumentList) {
                        docStateID = d.getStateID();
                        consentName = d.getConsentName();
                        docURL = d.getConsentFile();
                        documentURL = "documents/" + docURL;

                %>

                <tr>
                    <td><%=consentName%></td>
                    <td>

                        <%=docStateID%>

                    </td>
                    <td><%=docURL%></td>

                    <td><a href="<%=documentURL%>" target="_blank" >View Document</a></td>
      
                </tr>
                <%
                        counterDoc++;
                    }
                %>
            </table>
            <%}%>

            <!-- End Report table -->
            <form action="viewScenarioAdmin.jsp" method="POST">
                <br>
                <br>
                <center><input type ="submit" class ="button small" value ="Proceed to Admin Homepage"></center>
            </form>
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
