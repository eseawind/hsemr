/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.TimeZone;

/**
 *
 * @author Administrator
 */
public class VitalHistoryDAO {
    public static void add(String scenarioID, double temperature, int RR, int BPsystolic, int BPdiastolic, int HR, int SPO, String output, String oralType, String oralAmount, String intravenousType, String intravenousAmount, String practicalGroupID) {
        Connection conn = null;
        PreparedStatement preparedStatement = null;
        //String query = "UPDATE vital SET vitalDatetime = ?, patientNRIC =?, temperature = ?, RR = ?, BPsystolic = ?, BPdiastolic = ?,  HR = ?, SPO = ?, intake = ?, output = ?";
        String query = "INSERT INTO vital_history (vitalDatetime, scenarioID, temperature, RR, BPsystolic, BPdiastolic, HR, SPO, output, oralType, oralAmount, intravenousType, intravenousAmount, practicalGroupID) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";

        try {
            conn = ConnectionManager.getConnection();

            Date dateTime = new Date();
            
            DateFormat dateFormatter;
            dateFormatter = new SimpleDateFormat("yyyy-M-dd H:m:s");
            dateFormatter.setTimeZone(TimeZone.getTimeZone("Singapore"));
            preparedStatement = conn.prepareStatement(query);
            preparedStatement.setString(1, dateFormatter.format(dateTime));
            preparedStatement.setString(2, scenarioID);
            preparedStatement.setDouble(3, temperature);
            preparedStatement.setInt(4, RR);
            preparedStatement.setInt(5, BPsystolic);
            preparedStatement.setInt(6, BPdiastolic);
            preparedStatement.setInt(7, HR);
            preparedStatement.setInt(8, SPO);
            preparedStatement.setString(9, output);
            preparedStatement.setString(10, oralType);
            preparedStatement.setString(11, oralAmount);
            preparedStatement.setString(12, intravenousType);
            preparedStatement.setString(13, intravenousAmount);
            preparedStatement.setString(14, practicalGroupID);
            preparedStatement.executeUpdate();

        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            ConnectionManager.close(conn, preparedStatement, null);
        }
    }
    public static void deleteAll (){
        Connection conn = null;
        PreparedStatement preparedStatement = null;
        String query = "DELETE FROM vital_history";
        
        try {
            conn = ConnectionManager.getConnection();
            preparedStatement = conn.prepareStatement(query);
            preparedStatement.executeUpdate();

        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            ConnectionManager.close(conn, preparedStatement, null);
        }
    }
     
}
