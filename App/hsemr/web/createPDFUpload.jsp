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
            String keywordDesc = "";
            String fieldsToMap = "";

            List<Keyword> keywordList = KeywordDAO.retrieveAll();
            if (keywordList != null) {
                keywordID = Integer.toString(keywordList.size() + 1);
            }

            if (request.getParameter("keywordID") != null) {
                keywordID = request.getParameter("keywordID");
                session.setAttribute("keywordID", keywordID);
            }

            if (request.getParameter("keywordDesc") != null) {
                keywordID = request.getParameter("keywordDesc");
                session.setAttribute("keywordDesc", keywordDesc);
            }

            if (request.getParameter("fieldsToMap") != null) {
                keywordID = request.getParameter("fieldsToMap");
                session.setAttribute("fieldsToMap", fieldsToMap);
            }
        %>
        <div class="large-10 large-centered columns">  
            <div class="row" style="width:600px; padding-top: 50px">
                <h1>PDF Text Recognition Case Setup</h1> 
                <br/><br/>
                <center><h3>Step 1: Add Keywords (optional):</h3></center>

                <form action = "ProcessEditAccount" method = "post">
                    <br/>
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
                <%                    if (keywordList == null || keywordList.size() - 1 == 0 || keywordList.size() - 1 == -1) {
                        out.println("<center>" + "There are no keywords created yet." + "</center>");

                    } else {
                        out.print("<center><h3>Keyword(s) Created:</h3></center>");
                %>

                <div class="panelCase">
                    <%for (Keyword keyword : keywordList) {
                            String keywordDescription = keyword.getKeywordDesc();
                    %>

                    <input type = "submit" class="casecreationbutton tiny" value="<%=keywordDescription%>" disabled>
                    <%

                            }
                        }%>
                </div><br/>
                <hr><br/>
                <center><h3>Step 2: Select PDF File:</h3></center>
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
    </body>
</html>
