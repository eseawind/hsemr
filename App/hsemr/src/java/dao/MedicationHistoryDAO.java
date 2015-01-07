/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

package dao;

import entity.MedicationHistory;
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
public class MedicationHistoryDAO {
    
    public static void add(String medicineBarcode, String practicalGroupID, String scenarioID) {
        Connection conn = null;
        PreparedStatement preparedStatement = null;
        String query = "INSERT INTO medication_history (medicineDatetime, medicineBarcode, practicalGroupID, scenarioID) VALUES (?, ?, ?, ?)";

        try {
            conn = ConnectionManager.getConnection();

            Date currentDateTime = new Date();
            
            DateFormat dateFormatter;
            dateFormatter = new SimpleDateFormat("yyyy-M-dd HH:mm:ss");
            dateFormatter.setTimeZone(TimeZone.getTimeZone("Singapore"));
            preparedStatement = conn.prepareStatement(query);
            preparedStatement.setString(1, dateFormatter.format(currentDateTime));
            preparedStatement.setString(2, medicineBarcode);
            preparedStatement.setString(3, practicalGroupID);
            preparedStatement.setString(4, scenarioID);
            preparedStatement.executeUpdate();

        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            ConnectionManager.close(conn, preparedStatement, null);
        }
    }
    
      public static List<MedicationHistory> retrieveAll(String scenarioID) {
        Connection conn = null;
        PreparedStatement stmt = null;
        ResultSet rs = null;
        List<MedicationHistory> medicationHistoryList = new ArrayList<MedicationHistory>();

        try {
            conn = ConnectionManager.getConnection();
            stmt = conn.prepareStatement("select * from medication_history where scenarioID = ? order by medicineDatetime asc");
            stmt.setString(1, scenarioID);

            rs = stmt.executeQuery();
            while (rs.next()) {
                MedicationHistory medicationHistory = new MedicationHistory(rs.getTimestamp(1), rs.getString(2), rs.getString(3), rs.getString(4));
                medicationHistoryList.add(medicationHistory);
            }

        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            ConnectionManager.close(conn, stmt, rs);
        }
        return medicationHistoryList;
    }
      
    public static void delete(String scenarioID) {
        Connection conn = null;
        PreparedStatement preparedStatement = null;
        String query = "DELETE FROM medication_history WHERE scenarioID =?";

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
    
}
