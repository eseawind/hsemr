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
import java.util.ArrayList;
import java.util.List;

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
                state = new State(rs.getString(1), rs.getString(2), rs.getString(3), rs.getInt(4), rs.getString(5));
            }

        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            ConnectionManager.close(conn, stmt, rs);
        }
        return state;
    }
    
     public static List<State> retrieveAll(String scenarioID) {
        Connection conn = null;
        PreparedStatement stmt = null;
        ResultSet rs = null;
        List<State> stateList = new ArrayList<State>();

        try {
            conn = ConnectionManager.getConnection();
            stmt = conn.prepareStatement("SELECT * FROM state where scenarioID = ?");
            stmt.setString(1, scenarioID);
            rs = stmt.executeQuery();

            while (rs.next()) {
                State state = new State(rs.getString(1), rs.getString(2), rs.getString(3), rs.getInt(4), rs.getString(5));
                stateList.add(state);
            }

        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            ConnectionManager.close(conn, stmt, rs);
        }
        return stateList;
    }
     
    public static State retrieveActivateState(String scenarioID) {
        Connection conn = null;
        PreparedStatement stmt = null;
        ResultSet rs = null;
        State state = null;

        try {
            conn = ConnectionManager.getConnection();
            stmt = conn.prepareStatement("select * from state where scenarioID =? and stateStatus = ?");
            stmt.setString(1, scenarioID);
            stmt.setInt(2, 1);

            rs = stmt.executeQuery();
            while (rs.next()) {
                state = new State(rs.getString(1), rs.getString(2), rs.getString(3), rs.getInt(4), rs.getString(5));
            }

        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            ConnectionManager.close(conn, stmt, rs);
        }
        return state;
    }
    
    

    public static void updateState(String stateID, String scenarioID, int stateStatus) {
        Connection conn = null;
        PreparedStatement preparedStatement = null;
        String query = "UPDATE state SET stateStatus =? WHERE stateID =? and scenarioID = ?";

        try {
            conn = ConnectionManager.getConnection();

            preparedStatement = conn.prepareStatement(query);
            preparedStatement.setInt(1, stateStatus);
            preparedStatement.setString(2, stateID);
            preparedStatement.setString(3, scenarioID);
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
