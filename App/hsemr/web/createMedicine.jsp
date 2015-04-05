<%-- 
    Document   : createMedicine
    Created on : Mar 15, 2015, 12:44:22 AM
    Author     : Administrator
--%>

<%@page import="entity.*"%>
<%@page import="java.util.List"%>
<%@page import="java.util.List"%>
<%@page import="dao.*"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@include file="protectPage/protectAdmin.jsp" %>
<!DOCTYPE html>
<html>
        <head>
        <meta charset="utf-8" />
        <meta name="viewport" content="width=device-width, initial-scale=1.0" />
        
        <!--Web Title-->
        <title>EMR | Medicine Management | Medicine</title>
        
        <link rel="stylesheet" href="css/foundation.css" />
        <link rel="stylesheet" href="css/original.css" />
        <script type="text/javascript" src="js/humane.js"></script>
        <script src="js/vendor/modernizr.js"></script>
        <%@include file="/topbar/topbarAdmin.jsp" %>

        <script type="text/javascript">

            function deleteConfirmation() {
                var deleteButton = confirm("Are you sure you want to delete? ")
                if (deleteButton) {
                    return true;
                }
                else {
                    return false;
                }
            }

        </script>
    </head>
    <body> 
        <%
            String medicineName = (String) request.getAttribute("medicineName");
            String medicineBarcode = (String) request.getAttribute("medicineBarcode");
            
            if(medicineName == null || medicineName.equals("")){
                medicineName = "";
            }
            if(medicineBarcode == null || medicineBarcode.equals("")){
                medicineBarcode = "";
            }
            
            String success = "";
            String error = "";

            if (session.getAttribute("success") != null && !session.getAttribute("success").equals("")) {
                success = (String) session.getAttribute("success");
                session.setAttribute("success", "");
            }

            if (session.getAttribute("error") != null && !session.getAttribute("error").equals("")) {
                error = (String) session.getAttribute("error");
                session.setAttribute("error", "");
            }
        %>
        <div class="row" style="padding-top: 100px;">
            <div class="large-centered large-12 columns">
         <h1>Add New Medicine</h1>
                         
            <form action ="ProcessAddNewMedicine" method ="POST" data-abide>
                <label>Medicine Name <input type="text" name="newMedicineName" value="<%=medicineName%>" required/></label>
                <label>Medicine Barcode <input type ="text" name ="newMedicineBarcode" value="<%=medicineBarcode%>" style="text-transform:uppercase;" required pattern ="^[0-9a-zA-Z]+$"></label>
                <p>To generate the medicine barcode for printing on medicine, click <a href="http://www.barcode-generator.org/" target="_blank">here</a>. <br>Under "Create Free", please select <b>Code 128 (Standard)</b></p><br>
                
                <small class="error">No space and numbers allowed.</small> 
                <br/><br/><br/>
                <input type ="hidden" name ="route" value ="I.V.">
                <!--To differentiate it comes from which page. If edit medicine, route it back to editMedicationPage-->
                <input type ="hidden" name ="createMedicine" value ="Yes">
                <center><input type ="submit" class ="button important" value ="Create Medicine"></center>
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
