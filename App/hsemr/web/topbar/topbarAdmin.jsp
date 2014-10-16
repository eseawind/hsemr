<%-- 
    Document   : topbarAdmin
    Created on : Sep 24, 2014, 5:18:42 PM
    Author     : Jocelyn
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html><html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        
        <!--ICON-->
        <link rel="stylesheet" type="text/css" href="css/foundation-icons/foundation-icons.css">
        <link rel="stylesheet" type="text/css" href="css/foundation-icons/foundation-icons.svg">

    </head>
       <body>
        <nav class="top-bar" data-topbar>
            <ul class="title-area">
                <li class="name">
                    <h1><a href="./viewAdminHomePage.jsp"><i class="fi-home size-24"></i>    HS EMR</a></h1>
                </li>
            </ul>
         
            <section class="top-bar-section">
                
                <ul class="left">
                    <li class="has-dropdown">
                        <a href="#">Case Management</a>
                        <ul class="dropdown">
                            <li><a href="./viewScenarioAdmin.jsp">Manage Case</a></li>
                            <li><a href="./createCase.jsp">Create Case</a></li>
                        </ul>   
                    </li>
                    <li class="has-dropdown">
                        <a href="#">User Management</a>
                        <ul class="dropdown">
                            <li><a href="./viewAdminAccounts.jsp">Admin</a></li>
                            <li><a href="./viewLecturerAccounts.jsp">Lecturer</a></li>
                            <li><a href="./viewPracticalGroupAccounts.jsp">Practical Group</a></li>
                        </ul>   
                    </li>
                </ul>

                <ul class="right"> 
                    <li><a href="./viewAdminHomePage.jsp">Welcome, Admin!</a></li>
                    <li><a href="ProcessLogoutAdmin">Log Out</a></li>
                </ul>

            </section>
        </nav>

        <script src ="js/vendor/jquery.js"></script>
        <script src="js/foundation.min.js"></script>
        <script>
            $(document).foundation();
        </script>
    </body>
</html>
