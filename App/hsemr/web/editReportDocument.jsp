<%-- 
    Document   : editReportDocument
    Created on : Feb 1, 2015, 1:02:33 PM
    Author     : gladyskhong.2012
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
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
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
        <title>Edit Report and Document</title>
    </head>
    <body>
        <br>
        <ul class="breadcrumbs">
            <li><a href="editScenario.jsp">Edit Case Information</a></li>
            <li><a href="editState.jsp">Edit State Information</a></li>
            <li><a href="editMedication.jsp">Edit Medication </a></li>
            <li class="current"><a href="#">Edit Report and Document </a></li>
        </ul><br/>
    <center><h1>Edit Report and Document Creation</h1></center>
    <br>

    <%              
        String success = "";
        String error = "";

        String scenarioID = (String) session.getAttribute("scenarioID");
        //String patientNRIC = (String) session.getAttribute("patientNRIC");
        List<State> stateList = StateDAO.retrieveAll(scenarioID);

    %>


    <center><h2>Upload new Reports <a href="#" data-reveal-id="uploadReports"><img src="img/add.png" height ="30" width = "30"></a></h2></center>

    <!--Display reports that are in the database-->
    <center>
        <%   List<Report> reportList = ReportDAO.retrieveReportsByScenario(scenarioID);
            if (reportList == null || reportList.size() == 0) {
                out.println("<h3>" + "There are no reports(s) uploaded yet." + "</h3>");

            } %>
    </center>
    <!--End of display reports in the database-->

    <!--Reveal modal for upload reports-->
    <div id="uploadReports" class="reveal-modal" data-reveal>
        <h2>Upload new Report</h2>

        Please upload ONE at a time. <br><br>

        <form action = "ProcessReportUpload" method = "POST" enctype = "multipart/form-data"> 
            
            
            State
            <select name = "stateID" required>
                <option disabled="disabled" selected="selected" value = "">--Please select the state that this report will be tag to--</option>
                <%                             for (State state : stateList) {%>
                <option><%=state.getStateID()%></option>
                <% }
                String editing = "editingInProgress";
                %>
            </select>

            Report Name <input type="text" name="reportName" required/>

            Please ensure that your file is named to what you want it to be shown.<br>
            
            <input type ="file" name = "file" required /><br>
            <input type ="hidden" name ="scenarioID" value ="<%=scenarioID%>"/>
            <input type ="hidden" name ="editReport" value ="<%=editing%>"/>
            <input type ="submit" class ="button" value ="Upload Report">

        </form><br>   
        <a class="close-reveal-modal">&#215;</a>
    </div>

    <center><h2>Upload new Documents <a href="#" data-reveal-id="uploadDocuments"><img src="img/add.png" height ="30" width = "30"></a></h2></center>


    <!--Display documents that are in the database-->
    <center>
        <%  List<Document> documentList = DocumentDAO.retrieveDocumentsByScenario(scenarioID);
        
        String editingdocument = "editingInProgress";
            if (documentList == null || documentList.size() == 0) {
                out.println("<h3>" + "There are no documents(s) uploaded yet." + "</h3>");

            }%>
    </center>
    <!--End of display documents in the database-->


    <!--Reveal modal for upload documents-->
    <div id="uploadDocuments" class="reveal-modal" data-reveal>
        <h2>Upload new Documents</h2>

        Please upload ONE at a time. <br><br>

        <form action = "ProcessDocumentUpload" method = "POST" enctype = "multipart/form-data"> 

            Document Name <input type="text" name="documentName" required/>

            Please ensure that your file is named to what you want it to be shown.<br>
            <input type ="file" name = "file" required /><br>
            <input type ="hidden" name ="scenarioID" value ="<%=scenarioID%>"/>
            <input type ="hidden" name ="editDocument" value ="<%=editingdocument%>"/>
            <input type ="submit" class ="button" value ="Upload Document">

        </form><br>   
        <a class="close-reveal-modal">&#215;</a>
    </div>        

    <br/><br/>
    <div class="large-12 columns">
   
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
        
         <center><h3>Current Reports</h3></center>
    <!-- Report table -->

    <table class="responsive" id="cssTable" align="center">

        <col width="10%">
        <col width="20%">
        <col width="40%">
        <col width="20%">
        <col width="30%">
        <thead>
            <tr>
                <th>State</th>
                <th>Report Name</th>
                <th>File Name</th>
                <th>View Report</th>
                <th>Action</th>
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
            <td><form action ="ProcessDeleteReport" method = "POST">
                    <input type="hidden" name="reportFile" value="<%=reportFile%>">
                    <input type = "submit" Value ="Delete Report" class="button tiny">
                </form></td>
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
                
    <center><h3> Current Documents</h3></center>

    <!-- Documents table -->
    <table class="responsive" id="cssTable" align="center">
        <col width="10%">
        <col width="20%">
        <col width="40%">
        <col width="20%">
        <col width="30%">
        <thead>
            <tr>
                <th>State</th>
                <th>Document Name</th>
                <th>Document URL</th>
                <th>View Report</th>
                <th>Action</th>
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
            <td><form action ="ProcessDeleteDocument">
                    <input type="hidden" name="consentFile" value="<%=docURL%>">
                    <input type = "submit" Value ="Delete Document" class="button tiny">
                </form></td>
        </tr>
        <%
                counterDoc++;
            }
        %>
    </table>
    <%}%>
    <br><br><br>
    
    <!-- End Report table -->
    <form action="viewScenarioAdmin.jsp" method="POST">
        <center><input type ="submit" class ="button" value ="Proceed to Admin Homepage"></center>
    </form>
    </div>
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



    <script type="text/javascript" src="js/humane.js"></script>
</body>
</html>
