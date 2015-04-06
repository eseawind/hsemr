<%
   if(session.getAttribute("lecturer") == null){
       response.sendRedirect("viewMainLogin.jsp");
   }
    
%>