<%-- 
    Document   : newjsp
    Created on : Jan 13, 2015, 10:28:24 PM
    Author     : Administrator
--%>

<%@page import="dao.*"%>
<%@page import="entity.*"%>
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
        String scenarioID = request.getParameter("scenarioID");
        String patientNRIC = request.getParameter("patientNRIC");
        String stateDescription = request.getParameter("stateDescription");
        
        ArrayList<State> stateList = (ArrayList<State>) StateDAO.retrieveAll(scenarioID);
        int stateNumber = stateList.size();
        out.println(stateNumber);
        out.println(scenarioID);
        out.println(patientNRIC);
        
        String stateID = "ST" + stateNumber;

        //StateDAO.add(stateID, scenarioID, RR, BP, HR, SPO, intake, output, temperature, stateDescription, patientNRIC);
        StateDAO.add(stateID, scenarioID, stateDescription, 0, patientNRIC);

        
        %>
    </body>
</html>
