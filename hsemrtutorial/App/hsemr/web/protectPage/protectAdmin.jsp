<%
   if(session.getAttribute("admin") == null){
       response.sendRedirect("viewMainLogin.jsp");
   }
    
%>