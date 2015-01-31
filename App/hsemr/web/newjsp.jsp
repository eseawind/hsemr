<%-- 
    Document   : newjsp
    Created on : Feb 1, 2015, 12:07:39 AM
    Author     : Administrator
--%>

<%@page import="java.util.ArrayList"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <body>
        <h1>Hello World!</h1>
        
        <%
        String practicalGroupID = (String) request.getSession().getAttribute("nurse");
        
        
        
        String medicineBarcode = (String) request.getParameter("medicineBarcode");
        String medicineBarcodeInput = (String) request.getParameter("medicineBarcodeInput");
        String scenarioID = (String) session.getAttribute("scenarioID");
        
        ArrayList<String> medicineVerifiedListReturned = (ArrayList<String>) (session.getAttribute("medicineVerifiedList"));

        if (medicineBarcode.equals(medicineBarcodeInput)) {//correct combination
            //MedicationHistoryDAO.add(medicineBarcode, practicalGroupID, scenarioID);
            session.setAttribute("success", medicineBarcodeInput + " barcode verified, you can proceed to administer. Medication has been added to historial records.");
            
            
            medicineVerifiedListReturned.add(medicineBarcode);
            
            session.setAttribute("medicineVerifiedListReturned",medicineVerifiedListReturned);
            
            session.setAttribute("isMedicationVerified", "true");
            
            session.setAttribute("isPatientVerified", "true");
            session.setAttribute("active", "medication");
            
    
            response.sendRedirect("viewPatientInformation.jsp");
        } else {
            session.setAttribute("active", "medication");
            session.setAttribute("error", "Wrong medicine! Please verify and rescan.");
            session.setAttribute("isPatientVerified", "true");
            response.sendRedirect("viewPatientInformation.jsp");
        }
        %>
    </body>
</html>
