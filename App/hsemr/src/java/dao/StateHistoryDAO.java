/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

package dao;

import entity.Prescription;
import entity.State;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.TimeZone;

/**
 *
 * @author weiyi.ngow.2012
 */
public class StateHistoryDAO {
    
    public static LinkedHashMap<String,String> retrieveAll() {
        Connection conn = null;
        PreparedStatement stmt = null;
        ResultSet rs = null;
        LinkedHashMap<String,String> stateHashMap = new LinkedHashMap<String,String>();

        try {
            conn = ConnectionManager.getConnection();
            stmt = conn.prepareStatement("SELECT * FROM state_history order by timeActivated DESC");
            rs = stmt.executeQuery();

            while (rs.next()) {
                String stateID = rs.getString(2);
                DateFormat df = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
                String stateDate = df.format(rs.getTimestamp(3));
                stateHashMap.put(stateID,stateDate);
            }

        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            ConnectionManager.close(conn, stmt, rs);
        }
        return stateHashMap;
    }
    
    public static ArrayList<StateHistory> retrieveStateHistory() {   
        ArrayList<StateHistory> list = new ArrayList<StateHistory>();
        Connection conn = null;
        PreparedStatement stmt = null;
        ResultSet rs = null;

        try {
            conn = ConnectionManager.getConnection();
            stmt = conn.prepareStatement("select * from state_history");

            rs = stmt.executeQuery();
            while (rs.next()) {
                StateHistory stateHistory = new StateHistory(rs.getString(1), rs.getString(2), rs.getTimestamp(3));
                list.add(stateHistory);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            ConnectionManager.close(conn, stmt, rs);
        }
        return list;
    }
    
    //delete all StateHistory in scenario
    public static void reset(String scenarioID) {
        Connection conn = null;
        PreparedStatement preparedStatement = null;
        String query = "DELETE FROM `state_history` WHERE scenarioID = ?";

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
    
      public static void reset() {
        Connection conn = null;
        PreparedStatement preparedStatement = null;
        String query = "DELETE FROM `state_history` WHERE 1";

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
    
    
    
    public static void addStateHistory(String scenarioID, String stateID) {
        Connection conn = null;
        PreparedStatement preparedStatement = null;
        String query = "INSERT INTO state_history(scenarioID, stateID, timeActivated) VALUES (?, ?, ?)";

        try {
            conn = ConnectionManager.getConnection();

            Date currentDateTime = new Date();
            
            DateFormat dateFormatter;
            dateFormatter = new SimpleDateFormat("yyyy-M-dd HH:mm:ss");
            dateFormatter.setTimeZone(TimeZone.getTimeZone("Singapore"));
            preparedStatement = conn.prepareStatement(query);
            preparedStatement.setString(1, scenarioID);
            preparedStatement.setString(2, stateID);
            preparedStatement.setString(3, dateFormatter.format(currentDateTime));
            preparedStatement.executeUpdate();
            
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            ConnectionManager.close(conn, preparedStatement, null);
        }
    }
    
    public static void clearAllHistory() {
        Connection conn = null;
        PreparedStatement preparedStatement = null;
        String query = "DELETE FROM state_history";

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
