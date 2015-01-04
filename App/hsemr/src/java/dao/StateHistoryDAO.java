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
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.TimeZone;

/**
 *
 * @author weiyi.ngow.2012
 */
public class StateHistoryDAO {
    
    public static HashMap<String,String> retrieveAll() {
        Connection conn = null;
        PreparedStatement stmt = null;
        ResultSet rs = null;
        HashMap<String,String> stateHashMap = new HashMap<String,String>();

        try {
            conn = ConnectionManager.getConnection();
            stmt = conn.prepareStatement("SELECT * FROM stateHistory");
            rs = stmt.executeQuery();

            while (rs.next()) {
                String stateID = rs.getString(1);
                DateFormat df = new SimpleDateFormat("yyyy-M-dd HH:mm:ss");
                String stateDate = df.format(rs.getTimestamp(2));
                stateHashMap.put(stateID,stateDate);
            }

        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            ConnectionManager.close(conn, stmt, rs);
        }
        return stateHashMap;
    }
    
    public static void addStateHistory(String stateID) {
        Connection conn = null;
        PreparedStatement preparedStatement = null;
        String query = "INSERT INTO statehistory(stateID, timeActivated) VALUES (?, ?)";

        try {
            conn = ConnectionManager.getConnection();

            Date currentDateTime = new Date();
            
            DateFormat dateFormatter;
            dateFormatter = new SimpleDateFormat("yyyy-M-dd HH:mm:ss");
            dateFormatter.setTimeZone(TimeZone.getTimeZone("Singapore"));
            preparedStatement = conn.prepareStatement(query);
            preparedStatement.setString(1, stateID);
            preparedStatement.setString(2, dateFormatter.format(currentDateTime));
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
        String query = "DELETE FROM stateHistory";

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
