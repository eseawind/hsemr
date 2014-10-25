<%-- 
    Document   : mainLogin
    Created on : Sep 24, 2014, 4:48:29 PM
    Author     : Jocelyn
--%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
       <!--CSS-->
        <link rel="stylesheet" href="css/foundation.css" />
        <script src="js/vendor/modernizr.js"></script>

        <!--ICON-->
        <link rel="stylesheet" type="text/css" href="css/foundation-icons/foundation-icons.css">
        <link rel="stylesheet" type="text/css" href="css/foundation-icons/foundation-icons.svg">

        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>NP Health Sciences | Hospital Ward Management System</title>
    </head>
    <!--<body style="background-image:url(img/Rate.png)">-->
    <body>
        <div class="row" style="padding-top: 10px;">
            <div class="large-centered large-5 columns" style = "padding-top:30px;">
                <img src="img/Home.png" width="1388" height="586" alt="Home"/>

                <!--Error-->
                <%
                    String userid = "";
                    String error = (String) request.getAttribute("error");
                    if (error != null) {
                        userid = request.getParameter("userid");
                %>
                <div data-alert class="alert-box alert">
                    <%=error%>
                    <a href="viewMainLogin.jsp" class="close">&times;</a>
                </div>
                <%
                    }
                %> 

                <form action="ProcessLogin" method="post">
                     <div class="panel radius" style="background-color: #fcfcfc">
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
                </form>
            </div>
        </div>
        
        <script src="js/vendor/jquery.js"></script>
        <script src="js/foundation.min.js"></script>
        <script>
            $(document).foundation();
        </script>
    </body>
</html>
