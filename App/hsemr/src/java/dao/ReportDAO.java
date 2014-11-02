/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

package dao;

import entity.Report;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import java.util.Date;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.TimeZone;

/**
 * 
 * @author weiyi.ngow.2012
 */
public class ReportDAO {
        
    public static List<Report> retrieveReportsByState(String scenarioID, String stateID) {
        Connection conn = null;
        PreparedStatement stmt = null;
        ResultSet rs = null;
        List<Report> reports = new ArrayList<Report>();

        try {
            conn = ConnectionManager.getConnection();
            stmt = conn.prepareStatement("select * from report where scenarioID = ? and stateID = ? order by reportName");
            stmt.setString(1, scenarioID);
            stmt.setString(2, stateID);

            rs = stmt.executeQuery();
            while (rs.next()) {
                Report report = new Report(rs.getTimestamp(1), rs.getString(2), rs.getString(3), rs.getInt(4), rs.getString(5), rs.getString(6));
                reports.add(report);
                
            }

        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            ConnectionManager.close(conn, stmt, rs);
        }
        return reports;
    }

    public static void updateStatus(Date reportDateTime, String reportName, int dispatchStatus, String scenarioID, String stateID) {
        Connection conn = null;
        PreparedStatement preparedStatement = null;
        String query = "UPDATE report SET  dispatchStatus=?, reportDateTime=?  WHERE reportName = ? and scenarioID = ? and stateID = ? ";

        try {
            conn = ConnectionManager.getConnection();
            DateFormat dateFormatter;
            dateFormatter = new SimpleDateFormat("yyyy-M-dd HH:mm:ss");
            dateFormatter.setTimeZone(TimeZone.getTimeZone("Singapore"));
            preparedStatement = conn.prepareStatement(query);
            preparedStatement.setInt(1, dispatchStatus);
            preparedStatement.setString(2, dateFormatter.format(reportDateTime));
            preparedStatement.setString(3, reportName);
            preparedStatement.setString(4, scenarioID);
            preparedStatement.setString(5, stateID);
            preparedStatement.executeUpdate();

        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            ConnectionManager.close(conn, preparedStatement, null);
        }

    }
}
