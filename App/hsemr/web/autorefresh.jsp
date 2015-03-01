<%-- 
    Document   : autorefresh
    Created on : Mar 1, 2015, 6:46:05 PM
    Author     : Administrator
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<html>
    <head>
        <Title>Just A Test</Title>
        <script type="text/javascript" src="jquery.js"></script>
        <script type="text/javascript">
        var auto_refresh = setInterval(
        function ()
        {
        $('#load_me').load('autorefreshtest.jsp').fadeIn("slow");
        }, 1000); // autorefresh the content of the div after
                   //every 10000 milliseconds(10sec)
        </script>
   </head>
    <body>
    <div id="load_me"> <%@ include file="autorefreshtest.jsp" %></div>
    </body>
</html>