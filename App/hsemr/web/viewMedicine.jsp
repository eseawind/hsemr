<%-- 
    Document   : viewMedicine
    Created on : Mar 12, 2015, 11:53:29 PM
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
            List<Medicine> medicineList = MedicineDAO.retrieveAll();
        %>
        <div class="row" style="padding-top: 30px;">
            <div class="large-centered large-12 columns">
                <center><h1>Medicine Management</h1><br/><br/>
            <%            
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
                <!--TABLE-->
                <table class="responsive" id="cssTable">
                    <col width="30%">
                    <col width="30%">
                    <col width="10%">
                    <col width="10%">
                    <thead>
                        <tr>
                            <td><b>Medicine Name</b></td>
                            <td><b>Medicine Barcode</b></td>
                            <td colspan="2" align="center" valign="middle"><b>Actions</b></td>
                        </tr>
                    </thead>
                    <%
                        for (Medicine medicine : medicineList) {
                    %>
                    <tr>
                        <td> <%=medicine.getMedicineName()%> </td>
                        <td> <%=medicine.getMedicineBarcode()%> </td>
                        <td> 
                            <form action="editMedicine.jsp" method="post">
                                <input type="hidden" name="medicineBarcode" value="<%=medicine.getMedicineBarcode()%>">       
                                <center><input type="submit" class="button tinytable" value="edit"></center>
                            </form>
                        </td>
                        <%
                            String userLoggedIn = (String) session.getAttribute("admin");
                        %>
                        <td>
                            <form action="ProcessDeleteMedicine" method="post">
                                <input type="hidden" name="medicineBarcode" value="<%=medicine.getMedicineBarcode()%>">       
                                <center><input type="submit" class="deletebutton tinytableone" value="delete"></center>
                            </form>
                        </td>
                        <%
                            }
                        %>
                    </tr>

                </table><br/><br/><br/>

                <!--Create New Account button-->
                <form action="createMedicine.jsp" method="post">
                    <input type="hidden" name="type" value="admin">
                    <input type="submit" class="button important" value="Create New Medicine">
                </form>
                </center>
            </div>
        </div>
        <!--Scripts-->
        <script src="js/vendor/jquery.js"></script>
        <script src="js/foundation.min.js"></script>
        <script>
            $(document).ready(function() {
                $(document).foundation();
                var humaneSuccess = humane.create({baseCls: 'humane-original', addnCls: 'humane-original-success', timeout: 8000, clickToClose: true})
                var humaneError = humane.create({baseCls: 'humane-original', addnCls: 'humane-original-error', timeout: 8000, clickToClose: true})

                var success1 = "<%=success%>";
                var error1 = "<%=error%>";
                if (success1 !== "") {
                    humaneSuccess.log(success1);
                } else if (error1 !== "") {
                    humaneError.log(error1);
                }
            });

        </script>
        <script type="text/javascript" src="js/humane.js"></script>
    </body>

</html>