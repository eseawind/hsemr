/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

package dao;

import entity.PracticalGroupReport;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;



/**
 *
 * @author Administrator
 */
public class PracticalGroupReportDAO {
    
    public static PracticalGroupReport retrieve(int reportID, String scenarioID) {
        Connection conn = null;
        PreparedStatement stmt = null;
        ResultSet rs = null;
        PracticalGroupReport practicalGroupReport = null;

        try {
            conn = ConnectionManager.getConnection();
            stmt = conn.prepareStatement("select * from practicalgroup_report where reportID = ? and practicalGroupID = ?");
            stmt.setInt(1, reportID);
            stmt.setString(2, scenarioID);

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
    
    
}
