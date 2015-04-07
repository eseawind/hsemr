<%-- 
    Document   : createPDFUpload
    Created on : Feb 11, 2015, 8:58:08 PM
    Author     : weiyi.ngow.2012
--%>

<%@page import="dao.KeywordDAO"%>
<%@page import="entity.Keyword"%>
<%@page import="entity.State"%>
<%@page import="dao.StateDAO"%>
<%@page import="entity.Scenario"%>
<%@page import="dao.ScenarioDAO"%>
<%@page import="java.util.List"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <link rel="stylesheet" href="css/foundation.css" />
        <link rel="stylesheet" href="css/original.css" />
        <script type="text/javascript" src="js/humane.js"></script>
        <script src="js/vendor/modernizr.js"></script>

        <%@include file="/topbar/topbarAdmin.jsp" %>

        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">

        <!--Web Title-->
        <title>EMR | Case Management | Create Case | PDF Text Recognition</title>
    </head>
    <body>
        <%
            String keywordID = "";
            String keywordDescription = "";
            String fieldsToMap = "";
            int currentKeyword = 0;

            List<Keyword> keywordList = KeywordDAO.retrieveAll();
            if (keywordList != null) {
                //keywordID = Integer.toString(keywordList.size() + 1);
                int length = keywordList.size();
                Keyword lastKeyword = keywordList.get(length-1);
                int lastKeywordID = lastKeyword.getKeywordID();
                keywordID = Integer.toString(lastKeywordID + 1);
            }

        %>
        <div class="large-10 large-centered columns">  
            <div class="row" style="width:600px; padding-top: 50px">
                <h1>PDF Text Recognition Case Setup</h1> 
                <br/><br/>
       
                <center><h3>Select Case PDF File:</h3></center>
                <div class="panelCase">
                    <form action = "ProcessPDFCreation" method = "POST" enctype = "multipart/form-data"> 
                        <%

                            String success = "";
                            String error = "";

                            if (session.getAttribute("success") != null) {

                                success = (String) session.getAttribute("success");
                                session.setAttribute("success", "");
                            }

                            if (session.getAttribute("error") != null) {

                                error = (String) session.getAttribute("error");
                                session.setAttribute("error", "");
                            }

                            if (session.getAttribute("s") != null) {

                                String s = (String) session.getAttribute("s");
                                session.setAttribute("s", "");
                            }

                            List<Scenario> scenarioList = ScenarioDAO.retrieveAll();
                            int max = scenarioList.size() - 1;
                            Scenario lastScenario = scenarioList.get(max);
                            int nextScenarioID = lastScenario.getBedNumber() + 1;
                            String nextScenarioIDStr = "SC" + nextScenarioID;

                        %>

                        <input type ="file" name = "file" required /><br>
                        <input type ="hidden" name ="scenarioID" value ="<%=nextScenarioIDStr%>"/> 
                        <br/><br/>
                        <center><input type ="submit" class ="button small" value ="Upload Case"></center>

                    </form>
                </div>
                
                         <center><h3>Add New Keywords (optional):</h3></center>

                <form action = "ProcessAddKeyword" method = "post">
                    <br/>
                    <!--Keyword ID-->
                    <input type="hidden" name="keywordID" value="<%=keywordID%>">

                    <div class="panelCase">
                        <!--Keyword Description-->
                        <label>Keyword Description
                            <input type="text" id="keywordDesc" name="keywordDesc">
                        </label>
                        <br/>

                        <!--Fields To Map-->
                        <label>Fields To Map
                            <select name = "fieldsToMap">
                                <option value="doctorOrder">Doctor's Order</option>
                                <option value="scenarioName">Scenario Name</option>
                                <option value="scenarioDescription">Scenario Description</option>
                                <option value="admissionNote">Admission Note</option>
                                <option value="stateID">State ID</option>
                                <option value="allergy">Allergy</option>
                            </select> 
                        </label>
                        <br/>
                        <center> 
                            <input type="submit" class="button small" value="Add new keyword"></center>
                    </div>
                    <br/>

                </form>
                <br/>

                <!--Display states that are in the database-->
                <%                    
                    if (keywordList == null || keywordList.size() - 1 == 0 || keywordList.size() - 1 == -1) {
                        out.println("<center>" + "There are no keywords created yet." + "</center>");

                    } else {
                        out.print("<center><h3>Keyword(s) Created:</h3></center>");
                %>

                <div class="panelCase">
                    <table style="border-color: white">
                        <tr>
                            <!--Doctor's Order-->
                            <td><p>Doctor's Order</p></td>
                            <td>
                                <!--Delete Keyword--> 
                                <%
                                    for (Keyword keyword : keywordList) {
                                        keywordDescription = keyword.getKeywordDesc();
                                        currentKeyword = keyword.getKeywordID();
                                        fieldsToMap = keyword.getFieldsToMap();

                                        if (fieldsToMap.equals("doctorOrder")) {%>

                                <div class="floatdiv">
                                    <form action = "ProcessDeleteKeyword" method = "POST"> 
                                        <input type="hidden" name="currentKeyword" value="<%=currentKeyword%>">
                                        <input type="hidden" name="keywordDescription" value="<%=keywordDescription%>">
                                        <input type = "submit" class="keyword" onclick="if (!deleteConfirmation())
                                                    return false" value="<%=keywordDescription%>">
                                    </form>
                                </div> 
                                <% }
                                    } %>
                            </td>
                        </tr>
                        <tr>
                            <!--Scenario Name-->
                            <td><p>Scenario Name</p></td>
                            <td>
                                <!--Delete Keyword--> 
                                <%
                                    for (Keyword keyword : keywordList) {
                                        keywordDescription = keyword.getKeywordDesc();
                                        currentKeyword = keyword.getKeywordID();
                                        fieldsToMap = keyword.getFieldsToMap();

                                        if (fieldsToMap.equals("scenarioName")) {%>

                                <div class="floatdiv">
                                    <form action = "ProcessDeleteKeyword" method = "POST"> 
                                        <input type="hidden" name="currentKeyword" value="<%=currentKeyword%>">
                                        <input type="hidden" name="keywordDescription" value="<%=keywordDescription%>">
                                        <input type = "submit" class="keyword" onclick="if (!deleteConfirmation())
                                                    return false" value="<%=keywordDescription%>">
                                    </form>
                                </div> 
                                <% }
                                    } %>
                            </td>
                        </tr>
                        <tr>
                            <!--Scenario Description-->
                            <td><p>Scenario Description</p></td>
                            <td>
                                <!--Delete Keyword--> 
                                <%
                                    for (Keyword keyword : keywordList) {
                                        keywordDescription = keyword.getKeywordDesc();
                                        currentKeyword = keyword.getKeywordID();
                                        fieldsToMap = keyword.getFieldsToMap();

                                        if (fieldsToMap.equals("scenarioDescription")) {%>

                                <div class="floatdiv">
                                    <form action = "ProcessDeleteKeyword" method = "POST"> 
                                        <input type="hidden" name="currentKeyword" value="<%=currentKeyword%>">
                                        <input type="hidden" name="keywordDescription" value="<%=keywordDescription%>">
                                        <input type = "submit" class="keyword" onclick="if (!deleteConfirmation())
                                                    return false" value="<%=keywordDescription%>">
                                    </form>
                                </div> 
                                <% }
                                    } %>
                            </td>
                        </tr>
                        <tr>
                            <!--Admission Note-->
                            <td><p>Admission Note</p></td>
                            <td>
                                <!--Delete Keyword--> 
                                <%
                                    for (Keyword keyword : keywordList) {
                                        keywordDescription = keyword.getKeywordDesc();
                                        currentKeyword = keyword.getKeywordID();
                                        fieldsToMap = keyword.getFieldsToMap();

                                        if (fieldsToMap.equals("admissionNote")) {%>

                                <div class="floatdiv">
                                    <form action = "ProcessDeleteKeyword" method = "POST"> 
                                        <input type="hidden" name="currentKeyword" value="<%=currentKeyword%>">
                                        <input type="hidden" name="keywordDescription" value="<%=keywordDescription%>">
                                        <input type = "submit" class="keyword" onclick="if (!deleteConfirmation())
                                                    return false" value="<%=keywordDescription%>">
                                    </form>
                                </div> 
                                <% }
                                    } %>
                            </td>
                        </tr>
                        <tr>
                            <!--State ID-->
                            <td><p>State ID</p></td>
                            <td>
                                <!--Delete Keyword--> 
                                <%
                                    for (Keyword keyword : keywordList) {
                                        keywordDescription = keyword.getKeywordDesc();
                                        currentKeyword = keyword.getKeywordID();
                                        fieldsToMap = keyword.getFieldsToMap();

                                        if (fieldsToMap.equals("stateID")) {%>

                                <div class="floatdiv">
                                    <form action = "ProcessDeleteKeyword" method = "POST"> 
                                        <input type="hidden" name="currentKeyword" value="<%=currentKeyword%>">
                                        <input type="hidden" name="keywordDescription" value="<%=keywordDescription%>">
                                        <input type = "submit" class="keyword" onclick="if (!deleteConfirmation())
                                                    return false" value="<%=keywordDescription%>">
                                    </form>
                                </div> 
                                <% }
                                    } %>
                            </td>
                        </tr>
                        <tr>
                            <!--Allergy-->
                            <td><p>Allergy</p></td>
                            <td>
                                <!--Delete Keyword--> 
                                <%
                                    for (Keyword keyword : keywordList) {
                                        keywordDescription = keyword.getKeywordDesc();
                                        currentKeyword = keyword.getKeywordID();
                                        fieldsToMap = keyword.getFieldsToMap();

                                        if (fieldsToMap.equals("allergy")) {%>

                                <div class="floatdiv">
                                    <form action = "ProcessDeleteKeyword" method = "POST"> 
                                        <input type="hidden" name="currentKeyword" value="<%=currentKeyword%>">
                                        <input type="hidden" name="keywordDescription" value="<%=keywordDescription%>">
                                        <input type = "submit" class="keyword" onclick="if (!deleteConfirmation())
                                                    return false" value="<%=keywordDescription%>">
                                    </form>
                                </div> 
                                <% }
                                    } %>
                            </td>
                        </tr>
                    </table>  
                </div> 
                <% } %>
                <br/>
                <br/>
            </div>
        </div>
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

        <script type="text/javascript">
            function deleteConfirmation() {
                var deleteButton = confirm("Are you sure you want to remove the keyword?")
                if (deleteButton) {
                    return true;
                }
                else {
                    return false;
                }
            }

        </script>
        <style type="text/css">


            .floatdiv
            {
                display:inline-block;
            }
        </style>
    </body>
</html>
