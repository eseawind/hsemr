<%-- 
    Document   : autorefreshtest
    Created on : Mar 1, 2015, 8:21:31 PM
    Author     : Administrator
--%>
<%@page import="dao.StateHistory"%>
<%@page import="java.util.List"%>
<%@page import="dao.StateHistoryDAO"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>

  
        <script src="js/vendor/jquery.js"></script>

        <!--Web Title-->
        <title>EMR | Patient Information</title>

  

        
    </head>
    <body>

        
        <% 
            StateHistoryDAO.retrieveLatestStateActivatedByLecturer("lec1");
            out.println(StateHistoryDAO.retrieveLatestStateActivatedByLecturer("lec1").getStateID());
            out.println(System.currentTimeMillis());
        %>
    </body>
</html>
