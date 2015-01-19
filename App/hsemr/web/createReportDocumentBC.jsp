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
        <title>Case Setup of Report and Document</title>
    </head>
    <body>  
        <script src="js/vendor/jquery.js"></script>
        <script src="js/foundation.min.js"></script>
        <center><h1>Report and Document creation</h1></center>
        <br>
        <b> Step 1: Case creation > <a href="createStateBC.jsp">Step 2: State creation</a>  > <a href="createMedicationBC.jsp">Step 3: Medication creation</a> > <a href="createReportDocumentBC.jsp">Step 4: Report and Document Creation</a> </b>
   
          <%

            String success = "";
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
            String patientNRIC = (String) session.getAttribute("patientNRIC");
             List<State> stateList = StateDAO.retrieveAll(scenarioID);

        %>
        
        
         <h2>Step 4: Upload Reports <a href="#" data-reveal-id="uploadReports"><img src="img/add.png" height ="30" width = "30"></a></h2>
         <% 
               List<Report> reportList=  ReportDAO.retrieveReportsByScenario(scenarioID);
                for(Report reportRetrieve : reportList){%>
        <h4><%=reportRetrieve.getStateID().replace("ST", "State ") +  " - " + reportRetrieve.getReportName() + " (" + reportRetrieve.getReportFile()+ ") " +  "<br>"%></h4>
            
           <% }
        
        %>
        
        <!--Reveal modal for upload reports-->
        <div id="uploadReports" class="reveal-modal" data-reveal>
            <h2>Step 4: Upload Report</h2>
            
            Please upload ONE at a time. <br><br>

            <form action = "ProcessReportUpload" method = "POST" enctype = "multipart/form-data"> 
                State
                <select name = "stateID" required>
                    <option>--Please select the state that this report will be tag to--</option>
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
                
        <h2>Step 4: Upload Documents <a href="#" data-reveal-id="uploadDocuments"><img src="img/add.png" height ="30" width = "30"></a></h2>
         <%  
             
             List<Document> documentList= DocumentDAO.retrieveDocumentsByScenario(scenarioID);

              for(Document documentRetrieve : documentList){%>
        <h4><% out.println(documentRetrieve.getConsentName() + " (" + documentRetrieve.getConsentFile()+ ") " +  "<br>");%></h4>
            
           <% } %>
           
        
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
    <center><input type ="submit" class ="button" value ="Return to Admin Homepage"></center>
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
