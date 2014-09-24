<%
   if(session.getAttribute("user") == null){
       response.sendRedirect("viewMainLogin.jsp");
   }
    
%>