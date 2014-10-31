<%-- 
    Document   : topbarAdmin
    Created on : Sep 24, 2014, 5:18:42 PM
    Author     : Jocelyn
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html><html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        
        <!--FONT-->
        <link href='http://fonts.googleapis.com/css?family=Roboto:400,100,300,500,700,900' rel='stylesheet' type='text/css'>
        
        <!--ICON-->
        <link rel="stylesheet" type="text/css" href="css/foundation-icons/foundation-icons.css">
        <link rel="stylesheet" type="text/css" href="css/foundation-icons/foundation-icons.svg">

    </head>
    <body>
      <nav class="top-bar" data-topbar>
            <ul class="title-area">
                <li class="name">
                    <h1><a href="viewScenarioAdmin.jsp"><img src="./img/DefaultLogo.png" width="30" height="30"/> EMR</a></h1>

                </li>
                <!-- Remove the class "menu-icon" to get rid of menu icon. Take out "Menu" to just have icon alone -->
                <li class="toggle-topbar menu-icon"><a href="#"><span>Menu</span></a></li>
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
