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
    
    public static List<Report> retrieveReportsByScenario(String scenarioID) {
        Connection conn = null;
        PreparedStatement stmt = null;
        ResultSet rs = null;
        List<Report> reports = new ArrayList<Report>();

        try {
            conn = ConnectionManager.getConnection();
            stmt = conn.prepareStatement("select * from report where scenarioID = ? order by reportName");
            stmt.setString(1, scenarioID);
            

            rs = stmt.executeQuery();
            while (rs.next()) {
                Report report = new Report(rs.getInt(1), rs.getTimestamp(2), rs.getString(3), rs.getString(4), rs.getString(5), rs.getString(6), rs.getInt(7));
                reports.add(report);
                
            }

        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            ConnectionManager.close(conn, stmt, rs);
        }
        return reports;
    }
    
    public static Report retrieveReportByReportFile(String reportFile, String scenarioID) {
        Connection conn = null;
        PreparedStatement stmt = null;
        ResultSet rs = null;
        Report report = null;

        try {
            conn = ConnectionManager.getConnection();
            stmt = conn.prepareStatement("select * from report where reportFile = ? and scenarioID = ?");
            stmt.setString(1, reportFile);
            stmt.setString(2, scenarioID);
            

            rs = stmt.executeQuery();
            while (rs.next()) {
                report = new Report(rs.getInt(1), rs.getTimestamp(2), rs.getString(3), rs.getString(4), rs.getString(5), rs.getString(6), rs.getInt(7));
    
            }

        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            ConnectionManager.close(conn, stmt, rs);
        }
        return report;
    }
    
    
    public static List<Report> retrieveReportsByState(String scenarioID, String stateID) {
        Connection conn = null;
        PreparedStatement stmt = null;
        ResultSet rs = null;
        List<Report> reports = new ArrayList<Report>();

        try {
            conn = ConnectionManager.getConnection();
            stmt = conn.prepareStatement("select * from report where scenarioID = ? and stateID = ? order by reportID");
            stmt.setString(1, scenarioID);
            stmt.setString(2, stateID);

            rs = stmt.executeQuery();
            while (rs.next()) {
                Report report = new Report(rs.getInt(1), rs.getTimestamp(2), rs.getString(3), rs.getString(4), rs.getString(5), rs.getString(6), rs.getInt(7));
                reports.add(report);
                
            }

        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            ConnectionManager.close(conn, stmt, rs);
        }
        return reports;
    }
    
    public static List<Report> retrieveDespatchedReports(String scenarioID, String practicalGroupID) {
        Connection conn = null;
        PreparedStatement stmt = null;
        ResultSet rs = null;
        List<Report> reports = new ArrayList<Report>();
        List<PracticalGroupReport> practicalGroupReports = PracticalGroupReportDAO.retrieveAllByPracticalGroup(practicalGroupID);
        try {
            
            conn = ConnectionManager.getConnection();
            stmt = conn.prepareStatement("select * from report where scenarioID = ? order by reportName ASC");
            stmt.setString(1, scenarioID);
            
            rs = stmt.executeQuery();
            while (rs.next()) {
                int reportID = rs.getInt(1);
                for (PracticalGroupReport reportDespatched: practicalGroupReports) {
                    if(reportDespatched.getReportID() == reportID) {
                        Report report = new Report(rs.getInt(1), rs.getTimestamp(2), rs.getString(3), rs.getString(4), rs.getString(5), rs.getString(6), rs.getInt(7));
                        reports.add(report);
                    }
                }
            }

        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            ConnectionManager.close(conn, stmt, rs);
        }
        return reports;
    }
    
    public static Integer retrieveMaxReportNumber() {
        Connection conn = null;
        PreparedStatement stmt = null;
        ResultSet rs = null;
        int maxBed = 0;

        try {
            conn = ConnectionManager.getConnection();
            stmt = conn.prepareStatement("select max(reportID) as maxReportID from report");

            rs = stmt.executeQuery();
            while (rs.next()) {
                maxBed = rs.getInt("maxReportID");
            }

        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            ConnectionManager.close(conn, stmt, rs);
        }
        return maxBed;
    }
        
    public static void add(String reportName, String reportFile, String scenarioID, String stateID, int initialReport) {
        Connection conn = null;
        PreparedStatement preparedStatement = null;
        String query = "INSERT INTO report (reportID, reportDatetime, reportName, reportFile, scenarioID, stateID, initialReport) VALUES (?, ?, ?, ?, ? ,?,?)";

        try {
            conn = ConnectionManager.getConnection();

            Date currentDateTime = new Date();
            
            DateFormat dateFormatter;
            dateFormatter = new SimpleDateFormat("yyyy-M-dd HH:mm:ss");
            dateFormatter.setTimeZone(TimeZone.getTimeZone("Singapore"));
            preparedStatement = conn.prepareStatement(query);
            preparedStatement.setInt(1, ReportDAO.retrieveMaxReportNumber() + 1);
            preparedStatement.setString(2, dateFormatter.format(currentDateTime));
            preparedStatement.setString(3, reportName);
            preparedStatement.setString(4, reportFile);
            preparedStatement.setString(5, scenarioID); 
            preparedStatement.setString(6, stateID);
            preparedStatement.setInt(7, 1);
            preparedStatement.executeUpdate();

        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            ConnectionManager.close(conn, preparedStatement, null);
        }
    }

    public static void delete(String scenarioID) {
        Connection conn = null;
        PreparedStatement preparedStatement = null;
        String query = "DELETE FROM report WHERE scenarioID = ?";

        try {
            conn = ConnectionManager.getConnection();

            preparedStatement = conn.prepareStatement(query);
            preparedStatement.setString(1, scenarioID);
            preparedStatement.executeUpdate();

        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            ConnectionManager.close(conn, preparedStatement, null);
        }
        
    }
    
    public static void deleteReport(String reportFile) {
        Connection conn = null;
        PreparedStatement preparedStatement = null;
        String query = "DELETE FROM report WHERE reportFile = ?";

        try {
            conn = ConnectionManager.getConnection();

            preparedStatement = conn.prepareStatement(query);
            preparedStatement.setString(1, reportFile);
            preparedStatement.executeUpdate();

        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            ConnectionManager.close(conn, preparedStatement, null);
        }
        
    }
}
