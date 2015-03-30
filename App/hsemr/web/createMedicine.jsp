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
        <div class="row" style="padding-top: 30px;">
            <div class="large-centered large-12 columns">
        
        
         <h1>Add New Medicine</h1>
                         <p>Create the medicine barcode <a href="http://www.barcode-generator.org/" target="_blank">here</a>. Under "Create Free", please select <b>Code 128 (Standard)</b></p><br>
            <form action ="ProcessAddNewMedicine" method ="POST" data-abide>
                <label>Medicine Name <input type="text" name="newMedicineName" required/></label>
                <label>Medicine Barcode <input type ="text" name ="newMedicineBarcode" style="text-transform:uppercase;" required pattern ="^[0-9a-zA-Z]+$"></label>
                
                <small class="error">No space and numbers allowed.</small> 

                <input type ="hidden" name ="route" value ="I.V.">
                <!--To differentiate it comes from which page. If edit medicine, route it back to editMedicationPage-->
                <input type ="hidden" name ="createMedicine" value ="Yes">
                <input type ="submit" class ="button" value ="Create Medicine">
            </form>
         
            </div>
        </div>
    </body>
</html>
