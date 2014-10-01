<%-- 
    Document   : mainLogin
    Created on : Sep 24, 2014, 4:48:29 PM
    Author     : Jocelyn
--%>
<%@page import="dao.AdminDAO"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>

    <head>
        <link rel="stylesheet" href="css/foundation.css" />

        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Hospital Ward Management System for NP Health Sciences</title>
    </head>
    <body>
        <div class="row" style="padding-top: 30px;">
            <center>
                <h1>HSEMR</h1>
                <h2>Enriching Lives, Enriching You</h2> 
                <div class="large-centered large-4 columns" style = "padding-top:30px;">

                    <%

                        String userid = "";
                        String error = (String) request.getAttribute("error");
                        if (error != null) {
                            userid = request.getParameter("userid");
                            out.println(error);
                        }

                    %> 

                    <form action="ProcessLogin" method="post">
                        <table>
                            <tr>
                                <td>
                                    <label for="userid">User ID: </label>
                                </td>
                                <td>
                                    <input type="text" id="userid" placeholder="User ID" name="userid" value=<%=userid%> >
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    <label for="password">Password: </label>
                                </td>
                                <td>
                                    <input type="password" class="password" placeholder="Password" name="password">
                                </td>
                            </tr>
                            <tr>    
                                <td>
                                    Domain: 
                                </td>
                                <td>
                                    <select name="userType">
                                        <option value="student">NPSTUDENT</option>
                                        <option value="lecturer">NPSTAFF</option>
                                        <option value="admin">Admin</option>
                                    </select>
                                </td>
                            </tr>
                        </table>
                        <p><input type="submit" class="button tiny" value = "Enter"></p>
                    </form>
            </center>

        </div>
    </body>
</html>
