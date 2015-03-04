<%-- 
    Document   : newjsp
    Created on : Mar 4, 2015, 5:10:30 PM
    Author     : Administrator
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>

    <input id="btntest" type="button" value="Check" 
       onclick="return btntest_onclick()" />
<script language="javascript" type="text/javascript">

function btntest_onclick() 
{
    window.location.href = "http://www.google.com";
}

</script>
    
</html>
