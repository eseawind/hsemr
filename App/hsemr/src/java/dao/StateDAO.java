/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package dao;

import entity.State;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

/**
 *
 * @author Administrator
 */
public class StateDAO {

    public static State retrieve(String stateID, String scenarioID) {
        Connection conn = null;
        PreparedStatement stmt = null;
        ResultSet rs = null;
        State state = null;

        try {
            conn = ConnectionManager.getConnection();
            stmt = conn.prepareStatement("select * from state where stateID = ? and scenarioID =?");
            stmt.setString(1, stateID);
            stmt.setString(2, scenarioID);

            rs = stmt.executeQuery();
            while (rs.next()) {
                state = new State(rs.getString(1), rs.getString(2), rs.getString(3), rs.getString(4), rs.getString(5), rs.getString(6), rs.getString(7), rs.getString(8), rs.getDouble(9), rs.getString(10), rs.getString(11));
            }

        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            ConnectionManager.close(conn, stmt, rs);
        }
        return state;
    }
    
    public static State retrieveActivateScenarioPatient(String scenarioID) {
        Connection conn = null;
        PreparedStatement stmt = null;
        ResultSet rs = null;
        State state = null;

        try {
            conn = ConnectionManager.getConnection();
            stmt = conn.prepareStatement("select * from state where scenarioID =?");
            stmt.setString(1, scenarioID);

            rs = stmt.executeQuery();
            while (rs.next()) {
                state = new State(rs.getString(1), rs.getString(2), rs.getString(3), rs.getString(4), rs.getString(5), rs.getString(6), rs.getString(7), rs.getString(8), rs.getDouble(9), rs.getString(10), rs.getString(11));
            }

        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            ConnectionManager.close(conn, stmt, rs);
        }
        return state;
    }
    
    public static void add(String stateID, String scenarioID, String RR, String BP, String HR, String SPO, String intake, String output, double temperature, String stateDescription, String patientNRIC) {
        Connection conn = null;
        PreparedStatement preparedStatement = null;
        String queryLine = "INSERT INTO state VALUES ('"
                + stateID + "','" + scenarioID + "','" + RR + "','" + BP+ "','" + HR+ "','" + SPO+ "','" + intake + "','" + output + "','" + temperature + "','" + stateDescription + "','" + patientNRIC +  "')";

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

    public static void updateState(String stateID, String scenarioID, String RR, String BP, String HR, String SPO, String intake, String output, double temperature) {
        Connection conn = null;
        PreparedStatement preparedStatement = null;
        String query = "UPDATE state SET RR = ?, BP = ?, HR = ?, SPO = ?, intake = ?, output = ?, temperature =? WHERE stateID =? and scenarioID = ?";

        try {
            conn = ConnectionManager.getConnection();

            preparedStatement = conn.prepareStatement(query);
            preparedStatement.setString(1, RR);
            preparedStatement.setString(2, BP);
            preparedStatement.setString(3, HR);
            preparedStatement.setString(4, SPO);
            preparedStatement.setString(5, intake);
            preparedStatement.setString(6, output);
            preparedStatement.setDouble(7, temperature);
            preparedStatement.setString(8, stateID);
            preparedStatement.setString(9, scenarioID);
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
        String query = "DELETE FROM state WHERE scenarioID =?";

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
