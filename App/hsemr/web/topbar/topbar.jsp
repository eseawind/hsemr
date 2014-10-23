<%-- 
    Document   : topbar
    Created on : Sep 24, 2014, 04:50:54 PM
    Author     : Jocelyn
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
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
                    <h1><a href="#"><i class="fi-home size-24"></i>    HS EMR</a></h1>

                </li>
                <!-- Remove the class "menu-icon" to get rid of menu icon. Take out "Menu" to just have icon alone -->
                <li class="toggle-topbar menu-icon"><a href="#"><span>Menu</span></a></li>
            </ul>
                
            <% 
                String nurseId = (String)session.getAttribute("nurse");
            %>
            <secion class="top-bar-section">
                <!-- Right Nav Section -->

                 <ul class="left">
<!--                    <li><a href="#"><span data-tooltip aria-haspopup="true" class="has-tip" title="<b>Scenario Name:</b> ECS UK Anaphylactic Reaction <br><b>Ward:</b> B  <b>Bed:</b> B3 <br><br>
                                          <b>Scenario Description: </b>This simulated clinical experience was designed to expose the learner to the patient who experiences an adverse reaction to blood transfusion. The patient is first day postoperative gynecological surgery who develops the complication of hypovolemia that requires a blood transfusion. The simulated clinical experience will automatically progress to anaphylaxis and subsequent shock states without prompt recognition of the transfusion reaction. With prompt recognition and intervention, the patient stabilises. The anaphylactic component of this simulated clinical experience may be used separately depending on learning objectives and may be overlaid on any patient or other scenario. This simulated clinical experience is intended for the learner in Semester VI.
                                          ">Case Information</span></a></li>-->
                  
                    <li><a href="#">Patient Management</a></li>
                    <li><a href="#">Ward Management</a></li>
                  </ul>
                
                <ul class="right"> 
                        <li><a href="#">Welcome, <%= nurseId%>!</a></li>
                    <li><a href="ProcessLogoutNurse">Log Out</a></li>
                </ul>
            </secion>
        </nav>

    </body>
</html>
