<%-- 
    Document   : mainLogin
    Created on : Sep 24, 2014, 4:48:29 PM
    Author     : Jocelyn
--%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <link rel="shortcut icon" href="img/DefaultLogo-favicon.ico">
        <!--CSS-->
        <link rel="stylesheet" href="css/foundation.css" />
        <link href='http://fonts.googleapis.com/css?family=Playfair+Display+SC:400,700,900' rel='stylesheet' type='text/css'>
        <script src="js/vendor/modernizr.js"></script>

        <!--ICON-->
        <link rel="stylesheet" type="text/css" href="css/foundation-icons/foundation-icons.css">
        <link rel="stylesheet" type="text/css" href="css/foundation-icons/foundation-icons.svg">

        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>NP Health Sciences | Hospital Ward Management System</title>
    </head>
    <body>
        <div class="large-centered large-12 columns">
            <!--HS EMR LOGO-->
            <center><br/>
                <div class="large-centered large-5 columns">
                    <!--To insert icon if needed-->
                    <!--<table style="border-color: white ">
                        <col width="5%">
                        <col width="95%">
                        <tr>
                            <td><img src="img/MainIcon.png" width="100" height="100" alt="MainIcon"/></td>
                            <td><h0><font color="##368a55">HS EMR</font></h0></td>
                        </tr>
                    </table>-->
                    <h0><font color="##368a55">HS EMR</font></h0>
                    <h1><font color="#009a4d">Passion to Touch Lives</font></h1>
                </div>
            </center>
            <div class="row" style="width:460px; padding-top: 15px">
                <!--Error Validation-->
                <%
                    String userid = "";
                    String error = (String) request.getAttribute("error");
                    if (error != null) {
                        userid = request.getParameter("userid");
                %>
                <!--Error Alert Box-->
                <div data-alert class="alert-box alert">
                    <%=error%>
                    <a href="viewMainLogin.jsp" class="close">&times;</a>
                </div>
                <%
                    }
                %> 

                <!--Post form to ProcessLogin to validate the user's credentials-->
                <form action="ProcessLogin" method="post">
                    <div class="panelHome" style="background-color: white">
                        <br/>
                        <!--User ID-->
                        <label><strong>User ID</strong>
                            <div class="row collapse">
                                <div class="small-3 columns">
                                    <span class="prefix radius"><i class="fi-torso size-24"></i></span>
                                </div>
                                <div class="small-9 columns">
                                    <input type="text" name="userid" placeholder="Enter your user ID" value="<%=userid%>" required>

                                </div>
                            </div> 
                        </label>
                        <br/>

                        <!--Password-->
                        <label><strong>Password</strong>
                            <div class="row collapse">
                                <div class="small-3 columns">
                                    <span class="prefix radius"><i class="fi-lock size-24"></i></span>
                                </div>
                                <div class="small-9 columns">
                                    <input type="password" name="password" placeholder="Enter your password" required>
                                </div>
                            </div> 
                        </label>  
                        <br/>

                        <!--Role-->
                        <label><strong>Role</strong>
                            <div class="row collapse">
                                <div class="small-3 columns">
                                    <span class="prefix radius"><i class="fi-torsos-all size-24"></i></span>
                                </div>
                                <div class="small-9 columns">
                                    <select name = "userType">
                                        <option value="practicalGroup">PRACTICAL GROUP</option>
                                        <option value="lecturer">NP STAFF</option>
                                        <option value="admin">ADMIN</option>
                                    </select> 
                                    <br/>
                                </div>
                            </div>    
                        </label>
                        <br/>

                        <!--Submit-->
                        <center><input type="submit" class="button normal radius expand" value="Login"></center>
                    </div>
                </form>
                <br/>
                
                <!--Footer-->
                <div class="zurb-footer-bottom">
                    <center><font size="1" color="#666666">&copy; Ngee Ann Polytechnic. School of Health Sciences. Electronic Medical Records. All rights reserved.</font></center>
                </div>             
            </div>
        </div>

        <!--Scripts-->
        <script src="js/vendor/jquery.js"></script>
        <script src="js/foundation.min.js"></script>
        <script>$(document).foundation();</script>

    </body>
</html>
