<%-- 
    Document   : viewMultidisciplinaryNotes
    Created on : Mar 1, 2015, 7:10:35 PM
    Author     : Administrator
--%>
<head>
     <script type="text/javascript">
            var auto_refresh = setInterval(
            function ()
            {
            $('#load_notes').load('viewMultidisciplinaryNotes.jsp').fadeIn("slow");
            }, 10000); 
        </script>
    
</head>
<!DOCTYPE html>
<html>
 <input data-reveal-id="pastDoctorOrder" type="submit" value="View Doctor's Order" class="button tiny">  

    <form action="ProcessAddNote" method="POST">
        <%
            String grpNames = (String) session.getAttribute("grpNames");
            String notes = (String) session.getAttribute("notes");

        %> 

        <h4>Enter New Multidisciplinary Notes</h4><br>
        <div id="newNotes" class="content">
            <div class="large-centered large-6 columns">

                <label style="text-align:left">Nurses in-charge</label>
                <input type ="hidden" name="scenarioID" value="<%=scenarioID%>"/>
                <input type ="text" id= "grpNames" name="grpNames" value="<% if (grpNames == null || grpNames == "") {
                        out.print("");
                    } else {
                        out.print(grpNames);
                    }%>" >

                <label style="text-align:left">Multidisciplinary Notes</label>
                <textarea name="notes" id="notes" rows="7" cols="10" ><% if (notes == null || notes == "") {
                        out.print("");
                    } else {
                        out.print(notes);
                    }%></textarea>
            </div>
            <br>
            <input type="submit" name="buttonChoosen" value="Save" class="button tiny"> 
            <input type="submit" name="buttonChoosen" value="Submit" class="button tiny"> 

        </div>  
    </form>

    <div class="large-centered large-12 columns">
        <hr>
    </div><br><br/>
    <h4>Multidisciplinary Notes History</h4><br> 
    <%
        if (notesListRetrieved == null || notesListRetrieved.size() == 0) {%>
    <label for="right-label" class="right inline"><h5><center>No past notes yet.</center></h5></label>
    <% } else { %> <br/>
    <!--TABLE-->
    <table class="responsive" id="cssTable">
        <col width="20%">
        <col width="30%">
        <col width="15%">
        <thead>
            <tr>
                <th>Nurses In-Charge</th>
                <th>Multidisciplinary Notes</th>
                <th>Time Submitted</th>
            </tr>
        </thead>
        <%
                DateFormat df = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
                //String reportDatetime = df.format(notesRetrieve.getNoteDatetime());
                for (int i = notesListRetrieved.size() - 1; i >= 0; i--) {
                    Note notesRetrieve = notesListRetrieved.get(i);
                    // out.print("<b>Practical Group: </b>" + notes.getPracticalGroupID() + "<br>");
                    out.println("<tr>");
                    out.print("<td>" + notesRetrieve.getGrpMemberNames() + "</td>");
                    out.print("<td>" + notesRetrieve.getMultidisciplinaryNote() + "</td>");
                    out.print("<td>" + df.format(notesRetrieve.getNoteDatetime()) + "</td>");
                    out.println("</tr>");
                }

            }//end of else %>

    </table>
</html>
