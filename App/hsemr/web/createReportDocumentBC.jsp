<%-- 
    Document   : createReportDocumentBC
    Created on : Jan 20, 2015, 1:53:54 AM
    Author     : hpkhoo.2012
--%>
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
        <title>Case Setup - Upload Report and Document</title>
    </head>
    <body>
        <br>
        <ul class="breadcrumbs">
            <li class="unavailable">Step 1: Case Creation</li>
            <li><a href="createStateBC.jsp">Step 2: State Creation</a></li>
            <li><a href="createMedicationBC.jsp">Step 2: State Creation</a></li>
            <li class="unavailable"><a href="#">Step 4: Report and Document Creation</a></li>
        </ul>
        <center><h1>Step 4: Report and Document Creation</h1></center>
        <br>
    
          <%

            String success = "";
            String error = "";

            String scenarioID = (String) session.getAttribute("scenarioID");
            String patientNRIC = (String) session.getAttribute("patientNRIC");
             List<State> stateList = StateDAO.retrieveAll(scenarioID);

        %>
        
        
        <center><h2>Step 4: Upload Reports <a href="#" data-reveal-id="uploadReports"><img src="img/add.png" height ="30" width = "30"></a></h2></center>

        <!--Display reports that are in the database-->
            <center>
            <%   List<Report> reportList=  ReportDAO.retrieveReportsByScenario(scenarioID);
                if (reportList == null || reportList.size() == 0 ) {
                    out.println("<h3>" + "There are no reports(s) uploaded yet." + "</h3>");

                } else {
                    out.print("<h3>Reports(s) Uploaded</h3>");
            %>

            <%for (Report report : reportList) {
                    String stateNumber = report.getStateID();
                    String reportName = report.getReportName();
                    String reportFile = report.getReportFile();

                    stateNumber.replace("ST", "State ");
                    String stateDesc = stateNumber.replace("ST", "State ") + " - " + reportName + "(" + reportFile + ")";%>

            <a href="#" class="button casecreationbutton tiny"><%=stateDesc%></a>
       

            <%}}%>
            </center>
        <!--End of display reports in the database-->
        
        <!--Reveal modal for upload reports-->
        <div id="uploadReports" class="reveal-modal" data-reveal>
            <h2>Upload Report</h2>
            
            Please upload ONE at a time. <br><br>

            <form action = "ProcessReportUpload" method = "POST" enctype = "multipart/form-data"> 
                State
                <select name = "stateID" required>
                    <option disabled="disabled" selected="selected" value = "">--Please select the state that this report will be tag to--</option>
                    <%                             for (State state : stateList) {%>
                    <option><%=state.getStateID()%></option>
                    <% }
                    %>
                </select>
                
                Report Name <input type="text" name="reportName" required/>
                
                Please ensure that your file is named to what you want it to be shown.<br>
                <input type ="file" name = "file" required /><br>
                <input type ="hidden" name ="scenarioID" value ="<%=scenarioID%>"/>
                <input type ="submit" class ="button" value ="Upload Report">

            </form><br>   
            <a class="close-reveal-modal">&#215;</a>
        </div>
                
            <center><h2>Step 4: Upload Documents <a href="#" data-reveal-id="uploadDocuments"><img src="img/add.png" height ="30" width = "30"></a></h2></center>
           
           
            <!--Display documents that are in the database-->
            <center>
            <%  List<Document> documentList= DocumentDAO.retrieveDocumentsByScenario(scenarioID);
                if (documentList == null || documentList.size() == 0) {
                    out.println("<h3>" + "There are no documents(s) uploaded yet." + "</h3>");

                } else {
                    out.print("<h3>Documents(s) Uploaded</h3>");
            %>

            <%for (Document document : documentList) {
                    String stateNumber = document.getStateID();
                    String consentName = document.getConsentName();
                    String consentFile = document.getConsentFile();
                  

                        stateNumber.replace("ST", "State ");
                        String stateDesc = stateNumber.replace("ST", "State ") + " - " + consentName + "(" + consentFile + ")";%>

            <a href="#" class="button casecreationbutton tiny"><%=stateDesc%></a>
       

            <%}}%>
            </center>
            <!--End of display documents in the database-->
           
        
        <!--Reveal modal for upload documents-->
        <div id="uploadDocuments" class="reveal-modal" data-reveal>
            <h2>Step 4: Upload Documents</h2>
            
            Please upload ONE at a time. <br><br>

            <form action = "ProcessDocumentUpload" method = "POST" enctype = "multipart/form-data"> 
                
                Document Name <input type="text" name="documentName" required/>
                
                Please ensure that your file is named to what you want it to be shown.<br>
                <input type ="file" name = "file" required /><br>
                <input type ="hidden" name ="scenarioID" value ="<%=scenarioID%>"/>
                <input type ="submit" class ="button" value ="Upload Document">

            </form><br>   
            <a class="close-reveal-modal">&#215;</a>
        </div>        

                
      <form action="viewScenarioAdmin.jsp" method="POST">
    <center><input type ="submit" class ="button tiny" value ="Return to Admin Homepage"></center>
    </form>
                
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
