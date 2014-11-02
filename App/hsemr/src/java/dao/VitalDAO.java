/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

package dao;

import entity.Vital;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;
import java.util.TimeZone;

/**
 *
 * @author weiyi.ngow.2012
 */
public class VitalDAO {
    
    public static List<Vital> retrieveAllByPatient(String patientNRIC) {
        Connection conn = null;
        PreparedStatement stmt = null;
        ResultSet rs = null;
        List<Vital> vitals = null;

        try {
            conn = ConnectionManager.getConnection();
            stmt = conn.prepareStatement("select * from vital where patientNRIC = ?");
            stmt.setString(1, patientNRIC);

            rs = stmt.executeQuery();
            while (rs.next()) {
                Vital vital = new Vital(rs.getDate(1), rs.getString(2), rs.getDouble(3), rs.getInt(4), rs.getInt(5), rs.getInt(6), rs.getInt(7), rs.getInt(8), rs.getString(9), rs.getString(10), rs.getString(11), rs.getString(12), rs.getString(13));
                vitals.add(vital);
            }

        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            ConnectionManager.close(conn, stmt, rs);
        }
        return vitals;
    }

    public static Vital retrieveLatestDateTime(String patientNRIC) {
        Connection conn = null;
        PreparedStatement stmt = null;
        ResultSet rs = null;
        Vital vital = null;

        try {
            conn = ConnectionManager.getConnection();
            stmt = conn.prepareStatement("select * from vital where patientNRIC = ? order by vitalDateTime desc limit 1");
            stmt.setString(1, patientNRIC);

            rs = stmt.executeQuery();
            while (rs.next()) {
                vital = new Vital(rs.getDate(1), rs.getString(2), rs.getDouble(3), rs.getInt(4), rs.getInt(5), rs.getInt(6), rs.getInt(7), rs.getInt(8), rs.getString(9), rs.getString(10), rs.getString(11), rs.getString(12), rs.getString(13));
            }

        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            ConnectionManager.close(conn, stmt, rs);
        }
        return vital;
    }
    
    
      public static void add(String patientNRIC, double temperature, int RR, int BPsystolic, int BPdiastolic, int HR, int SPO, String output, String oralType, String oralAmount, String intravenousType, String intravenousAmount) {
        Connection conn = null;
        PreparedStatement preparedStatement = null;
        //String query = "UPDATE vital SET vitalDatetime = ?, patientNRIC =?, temperature = ?, RR = ?, BPsystolic = ?, BPdiastolic = ?,  HR = ?, SPO = ?, intake = ?, output = ?";
        String query = "INSERT INTO vital (vitalDatetime, patientNRIC, temperature, RR, BPsystolic, BPdiastolic, HR, SPO, output, oralType, oralAmount, intravenousType, intravenousAmount) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";

        try {
            conn = ConnectionManager.getConnection();

            Date dateTime = new Date();
            
            DateFormat dateFormatter;
            dateFormatter = new SimpleDateFormat("yyyy-M-dd H:m:s");
            dateFormatter.setTimeZone(TimeZone.getTimeZone("Singapore"));
            preparedStatement = conn.prepareStatement(query);
            preparedStatement.setString(1, dateFormatter.format(dateTime));
            preparedStatement.setString(2, patientNRIC);
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
            preparedStatement.executeUpdate();

        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            ConnectionManager.close(conn, preparedStatement, null);
        }
    }
}
