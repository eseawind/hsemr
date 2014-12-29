<%-- 
    Document   : viewHistoricalTemp
    Created on : Dec 19, 2014, 3:27:19 PM
    Author     : weiyi.ngow.2012
--%>

<%@page import="java.text.DateFormat"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.text.DateFormat"%>
<%@page import="entity.Vital"%>
<%@page import="entity.Vital"%>
<%@page import="java.util.Date"%>
<%@page import="dao.VitalDAO"%>
<%@page import="dao.VitalDAO"%>
<%@page import="java.util.List"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <!-- Load c3.css -->
        <link href="css/c3.css" rel="stylesheet" type="text/css">

        <!-- Load d3.js and c3.js -->
        <script src="js/d3.min.js" charset="utf-8"></script>
        <script src="js/c3/c3.min.js"></script>
    </head>
    <body>
        <% 
           //retrieve list of blood pressure rate based on scenario
           String scenarioID= (String) session.getAttribute("scenarioID");
           List<Integer> bpSystolicList= VitalDAO.retrieveBPSystolic(scenarioID); 
           List<Integer> bpDiastolicList= VitalDAO.retrieveBPDiastolic(scenarioID); 
           
           //retrieve vitals related to current case
           List<Vital> vitals = VitalDAO.retrieveBPDiastolicByScenarioID(scenarioID);
           
           //get dates of all vitals
           List<Date> vitalsDateTime = VitalDAO.retrieveVitalTime(vitals);           
           
           //format date to be printed in string format
           DateFormat df = new SimpleDateFormat("yyyy-M-dd HH:mm:ss");
           //a string to store all dates in format to be used in javascript 
           //e.g. new Date ('2012-01-02T22:25:15'), new Date ('2012-02-02T22:25:17'), new Date ('2012-02-02T22:25:20'),new Date ('2012-02-02T22:25:23') 
           String vitalsDate = ""; 
           if (vitalsDateTime.size() > 0) { 
                for (int i = 0; i < vitalsDateTime.size(); i++ ) {
                    String dateTimeVital = df.format(vitalsDateTime.get(i));
                   //dateTimeVital = dateTimeVital.replace(" ", "T");
                    if (i != vitalsDateTime.size()-1) {
                        //vitalsDate += "new Date ('" + dateTimeVital + "'), ";
                        vitalsDate += "'" + dateTimeVital + "', ";
                    } else { 
                        //vitalsDate += "new Date ('" + dateTimeVital + "')";
                        vitalsDate += "'" +  dateTimeVital + "'";
                    }
                }
           }

                    
           //converting bpSystolicList to string for mainpulation
           String bpSystolicStringArr= bpSystolicList.toString();
           String withoutbracketBPsystolic = bpSystolicStringArr.replace("[", ""); 
           String dataOfBPsystolic= withoutbracketBPsystolic.replace("]", "") ;
           
           //converting bpDiastolicList to string for mainpulation
           String bpDiastolicStringArr= bpDiastolicList.toString();
           String withoutbracketBPdiastolic = bpDiastolicStringArr.replace("[", ""); 
           String dataOfBPdiastolic= withoutbracketBPdiastolic.replace("]", "") ;
           
        %>
       <h3>Blood Pressure Chart</h3>    
       
        <div id="chart"></div>
            
             
        <%
           if (bpSystolicList == null ||  bpDiastolicList== null || bpSystolicList.size() == 0 || bpDiastolicList.size() == 0) {
               out.println("<h5>There is no historial data at the moment.</h5>");
           } else { 
          %>
            <script type="text/javascript">
                
            var chart = c3.generate({
                bindto: '#chart',
                padding: {
                    left: 60, //at least 60 for y axis to be seen
                    right: 100 // add 10px for some spacing
                },
                data: {
                    //x: 'x',
                    columns: [
                       
                        ['BPsystolic',  <% out.println(dataOfBPsystolic); %>],
                        ['BPdiastolic', <% out.println(dataOfBPdiastolic); %>]
                      ],

                    labels: true,
                    type: 'line',
                   
                },
    
                axis: { 
                    x: { 
//                       type: 'timeseries',
//                       localtime: false,  
                        type: 'category',
                        categories: [<% out.println(vitalsDate);%>],
                       label: { // ADD
                            text: 'Time',
                            position: 'outer-right'
//                        }, 
//                        tick: { 
//                           format: '%Y-%m-%d %H:%M:%S', 
//                            rotate: 45,
//                            multiline: false
                       },
                       height: 100,
                       
                   },
                    y: {
                        
                        label: { // ADD
                            text: 'Blood Pressure (mm/Hg)',
                            position: 'outer-middle'
                        }
                        
                    }

                },
                grid: {
                    x: {
                        show: true
                    },
                    y: {
                        show: true
                    }
                }

            });
            chart.resize({height:300, width:700});

//        chart.load({
//            columns: [
//            ['data1', 300, 100, 250, 150, 300, 150, 500],
//            ['data2', 100, 200, 150, 50, 100, 250]
//            ]
//        });
        </script>  
        <% } %>
    </body>
</html>
