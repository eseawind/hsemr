<%
   if(session.getAttribute("nurse") == null){
       response.sendRedirect("viewMainLogin.jsp");
   }
    
%>