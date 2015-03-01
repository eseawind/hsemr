<%-- 
    Document   : viewDocuments
    Created on : Mar 1, 2015, 8:05:34 PM
    Author     : Administrator
--%>

<%@page import="java.util.*"%>
<%@page import="dao.*"%>
<%@page import="entity.*"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
   <h4>Documents</h4><br/>

                            <%

                                List<Document> documents = DocumentDAO.retrieveDocumentsByScenario(scenarioID);

                                //List<Document> documentList = DocumentDAO.retrieveDocumentsByState(scenarioID, stateID);
                                if (documents != null && documents.size() != 0) {
                            %>

                            <table>
                                <tr>
                                    <td><b>Document name</b></td>
                                    <td><b>Action</b></td>
                                </tr>

                                <%
                                    // Create an instance of SimpleDateFormat used for formatting 
                                    // the string representation of date (month/day/year)
                                    DateFormat df = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
                                    //String firstObtain = (String) session.getAttribute("obtained");
                                    for (Document document : documents) {
                                        String consentName = document.getConsentName();
                                        String consentFile = document.getConsentFile();
                                        String consentResults = "";
                                        consentResults = "documents/" + consentFile;
                                %> 
                                <tr>
                                    <td><%=consentName%></td>
                                    <td>
                                        <!-- // results column (link) -->
                                        <a href="<%=consentResults%>" target="_blank">View Form</a>
                                    </td>
                                </tr>
                                <%
                                        }
                                    } else {
                                        out.println("No documents at the moment.");
                                    }
                                %>  </table>
                        </div>  
                        <!-- Reveal model for past doctor orders -->
                        <div id="pastDoctorOrder" class="reveal-modal large-10" data-reveal>
                            <h4>Past Doctor Orders</h4>

                            <%
                                LinkedHashMap<List<Prescription>, String> stateDoctorOrderHM = new LinkedHashMap<List<Prescription>, String>();
                                for (Map.Entry<String, String> entry : activatedStates.entrySet()) {

                                    String state = entry.getKey();
                                    List<Prescription> prescriptions = PrescriptionDAO.retrieveOnlyNA(scenarioID, state);
                                    String doctorOrderTime = entry.getValue();
                                    if (prescriptions != null && prescriptions.size() != 0) {
                                        stateDoctorOrderHM.put(prescriptions, doctorOrderTime);
                                    }
                                }
                                if (stateDoctorOrderHM != null && stateDoctorOrderHM.size() != 0) {
                            %>
                            <table>
                                <tr>
                                    <td><b>Doctor Name</b></td>
                                    <td><b>Doctor Order</b></td>
                                    <td><b>Ordered Time</b></td>
                                </tr>

                                <%
                                    for (Map.Entry<List<Prescription>, String> entry : stateDoctorOrderHM.entrySet()) {
                                        List<Prescription> prescriptions = entry.getKey();

                                        // if needed to display:
                                        String doctorOrderTime = entry.getValue();

                                        for (Prescription prescription : prescriptions) {
                                            String doctorName = prescription.getDoctorName();
                                            String doctorOrder = prescription.getDoctorOrder();
                                %>
                                <tr>
                                    <td><%=doctorName%></td>
                                    <td><%=doctorOrder%></td>
                                    <td><%=doctorOrderTime%></td>
                                </tr>
                                <%
                                        }
                                    }
                                %>

                            </table>

                            <%
                                }
                            %>    


                            <a class="close-reveal-modal">&#215;</a>
</html>
