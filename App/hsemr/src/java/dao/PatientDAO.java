/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package dao;

import entity.Patient;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

/**
 *
 * @author Administrator
 */
public class PatientDAO {

    public static Patient retrieve(String patientNRIC) {
        Connection conn = null;
        PreparedStatement stmt = null;
        ResultSet rs = null;
        Patient patient = null;

        try {
            conn = ConnectionManager.getConnection();
            stmt = conn.prepareStatement("select * from patient where patientNRIC = ?");
            stmt.setString(1, patientNRIC);

            rs = stmt.executeQuery();
            while (rs.next()) {
                patient = new Patient(rs.getString(1), rs.getString(2), rs.getString(3), rs.getString(4), rs.getString(5), rs.getString(6), rs.getInt(7));
            }

        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            ConnectionManager.close(conn, stmt, rs);
        }
        return patient;
    }

    public static void add(String patientNRIC, String firstName, String lastName, String gender, String dob, String wardID, int bedNumber) {
        Connection conn = null;
        PreparedStatement preparedStatement = null;
        String queryLine = "INSERT INTO patient VALUES ('"
                + patientNRIC + "','" + firstName + "','" + lastName + "','" + gender + "','" + dob + "','" + wardID+ "','" + bedNumber + "')";

        try {
            conn = ConnectionManager.getConnection();
            preparedStatement = conn.prepareStatement(queryLine);
            preparedStatement.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            ConnectionManager.close(conn, preparedStatement, null);
        }
    }
    
    public static String retrieveAllergy(String patientNRIC) {
        Connection conn = null;
        PreparedStatement stmt = null;
        ResultSet rs = null;
        String allergy = null;

        try {
            conn = ConnectionManager.getConnection();
            stmt = conn.prepareStatement("select allergy from allergy_patient where patientNRIC = ?");
            stmt.setString(1, patientNRIC);

            rs = stmt.executeQuery();
            while (rs.next()) {
                allergy = new String(rs.getString(1));
            }

        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            ConnectionManager.close(conn, stmt, rs);
        }
        return allergy;

    }

}
