<%-- 
    Document   : editMedicine
    Created on : Mar 13, 2015, 12:01:25 AM
    Author     : Administrator
--%>

<%@page import="entity.*"%>
<%@page import="java.util.List"%>
<%@page import="dao.*"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@include file="protectPage/protectAdmin.jsp" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        
        <!--Web Title-->
        <title>EMR | Medicine Management | Edit Medicine</title>
        
        <link rel="stylesheet" href="css/foundation.css" />
        <link rel="stylesheet" href="responsive-tables.css">
        <link rel="stylesheet" href="css/original.css" />
        <script type="text/javascript" src="js/humane.js"></script>
        <script src="responsive-tables.js"></script>
        <%@include file="/topbar/topbarAdmin.jsp" %>
        
    </head>
    <body> 
      
        <%
            String medicineBarcode = request.getParameter("medicineBarcode");
            Medicine medicine = MedicineDAO.retrieve(medicineBarcode);
        %>
        <div class="large-10 large-centered columns">  
            <div class="row" style="width:400px; padding-top: 50px">
                <center><h1>Edit <%=medicine.getMedicineName() %>'s details</h1></center>
                    <%
                        String error = (String) request.getAttribute("error");
                        if (error == null) {
                            error = "";
                        }
                    %>

                <form action = "ProcessEditMedicine" method = "post">
                    <br/>
                    <div class="panelCase">
                        <!--User ID-->
                        <label><strong>Medicine Barcode</strong>
                            <input type="text" id="medicineBarcode" name="medicineBarcode" value="<%=medicineBarcode%>" readonly>
                        </label>
                        <br/>

                        <!--Password-->
                        <label><strong>New Mediine Name</strong>
                            <input type="text" id="medicineName" name="medicineName" value ="<%=medicine.getMedicineName()%>" required autofocus>
                        </label>  
                        <br/>

                    </div>
                    <br/>
                    <input type="hidden" id="right-label" name="type" value="<%=request.getParameter("type")%>">
                    <br/>
                    <%String location = "viewMedicine.jsp"; %>
                    <center> 
                        <input type="button" value="Cancel" class="button small" onClick="window.location = '<%=location%>'"/>
                        <input type="submit" class="button small" value="Save"></center>

                </form>
            </div>
        </div>
        <script>

            $(document).ready(function() {
                $(document).foundation();
                var humaneError = humane.create({baseCls: 'humane-original', addnCls: 'humane-original-error', timeout: 1000, clickToClose: true})

                var error1 = "<%=error%>";
                if (error1 !== "") {
                    humaneError.log(error1);
                }

            });
        </script>
    </body>
</html>

