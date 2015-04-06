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
                patient = new Patient(rs.getString(1), rs.getString(2), rs.getString(3), rs.getString(4), rs.getString(5));
            }

        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            ConnectionManager.close(conn, stmt, rs);
        }
        return patient;
    }

    public static void add(String patientNRIC, String firstName, String lastName, String gender, String DOB) {
        Connection conn = null;
        PreparedStatement preparedStatement = null;
        String query = "INSERT INTO patient (patientNRIC, firstName, lastName, gender, DOB) VALUES (?,?,?,?,?)";

        try {
            conn = ConnectionManager.getConnection();
            preparedStatement = conn.prepareStatement(query);

            preparedStatement.setString(1, patientNRIC);
            preparedStatement.setString(2, firstName);
            preparedStatement.setString(3, lastName);
            preparedStatement.setString(4, gender);
            preparedStatement.setString(5, DOB);
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

    public static void delete(String patientNric) {
        Connection conn = null;
        PreparedStatement preparedStatement = null;
        String query = "DELETE FROM patient WHERE patientNRIC =?";

        try {
            conn = ConnectionManager.getConnection();

            preparedStatement = conn.prepareStatement(query);
            preparedStatement.setString(1, patientNric);
            preparedStatement.executeUpdate();

        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            ConnectionManager.close(conn, preparedStatement, null);
        }
    }

    public static void update(String patientNRIC, String firstName, String lastName, String gender, String DOB, String retrieveNRIC) {
        Connection conn = null;
        PreparedStatement preparedStatement = null;
        String query = "UPDATE patient SET patientNRIC=?, firstName=?, lastName=?, gender=?, DOB=? WHERE patientNRIC =?";

        try {
            conn = ConnectionManager.getConnection();
            preparedStatement = conn.prepareStatement(query);

            preparedStatement.setString(1, patientNRIC);
            preparedStatement.setString(2, firstName);
            preparedStatement.setString(3, lastName);
            preparedStatement.setString(4, gender);
            preparedStatement.setString(5, DOB);
            preparedStatement.setString(6, retrieveNRIC);

            preparedStatement.executeUpdate();

        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            ConnectionManager.close(conn, preparedStatement, null);
        }
    }
}
