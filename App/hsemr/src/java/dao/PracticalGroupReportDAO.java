/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

package dao;

import entity.PracticalGroupReport;
import entity.Report;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.TimeZone;



/**
 *
 * @author Administrator
 */
public class PracticalGroupReportDAO {
    
    public static PracticalGroupReport retrieve(int reportID, String practicalGroupID) {
        Connection conn = null;
        PreparedStatement stmt = null;
        ResultSet rs = null;
        PracticalGroupReport practicalGroupReport = null;

        try {
            conn = ConnectionManager.getConnection();
            stmt = conn.prepareStatement("select * from practicalgroup_report where reportID = ? and practicalGroupID = ?");
            stmt.setInt(1, reportID);
            stmt.setString(2, practicalGroupID);

            rs = stmt.executeQuery();
            while (rs.next()) {
                practicalGroupReport = new PracticalGroupReport(rs.getInt(1), rs.getString(2));
            }

        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            ConnectionManager.close(conn, stmt, rs);
        }
        return practicalGroupReport;
    }
    
    public static List<PracticalGroupReport> retrieveAllByPracticalGroup(String practicalGroupID) {
        Connection conn = null;
        PreparedStatement stmt = null;
        ResultSet rs = null;
        List<PracticalGroupReport> practicalGroupReports = new ArrayList<PracticalGroupReport>();

        try {
            conn = ConnectionManager.getConnection();
            stmt = conn.prepareStatement("select * from practicalgroup_report where practicalGroupID = ?");
            stmt.setString(1, practicalGroupID);
            

            rs = stmt.executeQuery();
            while (rs.next()) {
                PracticalGroupReport report = new PracticalGroupReport(rs.getInt(1), rs.getString(2));
                practicalGroupReports.add(report);
                
            }

        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            ConnectionManager.close(conn, stmt, rs);
        }
        return practicalGroupReports;
    }
    
    public static void add(int reportID, String practicalGroupID) {
        Connection conn = null;
        PreparedStatement preparedStatement = null;
        String query = "INSERT INTO practicalgroup_report (reportID, practicalGroupID) VALUES (?, ?)";

        try {
            conn = ConnectionManager.getConnection();

            preparedStatement = conn.prepareStatement(query);
            preparedStatement.setInt(1, reportID);
            preparedStatement.setString(2, practicalGroupID);
            preparedStatement.executeUpdate();

        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            ConnectionManager.close(conn, preparedStatement, null);
        }
    }
}
