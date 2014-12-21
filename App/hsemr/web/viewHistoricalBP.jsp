<%-- 
    Document   : viewHistoricalTemp
    Created on : Dec 19, 2014, 3:27:19 PM
    Author     : weiyi.ngow.2012
--%>

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
        <div id="chart"></div>
 
            <script type="text/javascript">
            var chart = c3.generate({
                 bindto: '#chart',
                data: {
                columns: [
                    ['data1', 30, 20, 50, 40, 60, 50],
                    ['data2', 200, 130, 90, 240, 130, 220],
                    ['data3', 300, 200, 160, 400, 250, 250],
                    ['data4', 200, 130, 90, 240, 130, 220],
                    ['data5', 130, 120, 150, 140, 160, 150],
                    ['data6', 90, 70, 20, 50, 60, 120],
                ],
                type: 'bar',
                types: {
                    data3: 'spline',
                    data4: 'line',
                    data6: 'area',
                },
                groups: [
                    ['data1','data2']
                ]
            }
        });
//        chart.load({
//            columns: [
//            ['data1', 300, 100, 250, 150, 300, 150, 500],
//            ['data2', 100, 200, 150, 50, 100, 250]
//            ]
//        });
        </script>  
    </body>
</html>
