/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

package dao;

import entity.Nurse;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

/**
 *
 * @author jocelyn.ng.2012
 */
public class NurseDAO {
        public static Nurse retrieve(String userid){
        Connection conn = null;
        PreparedStatement stmt = null;
        ResultSet rs = null;
        Nurse nurse = null; 
        
        try {
            conn = ConnectionManager.getConnection();
            stmt = conn.prepareStatement("select * from nurse where nurseID = ?");
            stmt.setString(1, userid);
            
            rs = stmt.executeQuery();
            while (rs.next()) {
               nurse = new Nurse(rs.getString(1), rs.getString(2));
            }

        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            ConnectionManager.close(conn, stmt, rs);
        }
        return nurse;
    }
    
    public static List<Nurse> retrieveAll() {
        List<Nurse> list = new ArrayList<Nurse>();
        Connection conn = null;
        PreparedStatement stmt = null;
        ResultSet rs = null;

        try {
            conn = ConnectionManager.getConnection();
            stmt = conn.prepareStatement("select * from nurse");

            rs = stmt.executeQuery();
            while (rs.next()) {
                Nurse nurse = new Nurse(rs.getString(1), rs.getString(2));
                list.add(nurse);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            ConnectionManager.close(conn, stmt, rs);
        }
        return list;
    }
    public static void update(String userID, String password) {
        Connection conn = null;
        PreparedStatement preparedStatement = null;
        String query= "UPDATE nurse SET nursePassword =? WHERE nurseID =?";  
        
        try {
            conn = ConnectionManager.getConnection();

            preparedStatement = conn.prepareStatement(query);
            preparedStatement.setString(1,password);
            preparedStatement.setString(2,userID);
            preparedStatement.executeUpdate();
            
        } catch(SQLException e) {
            e.printStackTrace();
        }finally {
            ConnectionManager.close(conn,preparedStatement,null);
        }        
    }
    
    public static void delete(String userID) {
         Connection conn = null;
        PreparedStatement preparedStatement = null;
        String query= "DELETE FROM nurse WHERE nurseID =?";  
        
        try {
            conn = ConnectionManager.getConnection();

            preparedStatement = conn.prepareStatement(query);
            preparedStatement.setString(1,userID);
            preparedStatement.executeUpdate();
            
        } catch(SQLException e) {
            e.printStackTrace();
        }finally {
            ConnectionManager.close(conn,preparedStatement,null);
        }        
    }
   
    public static void add(String userID, String password) {
        Connection conn = null;
        PreparedStatement preparedStatement = null;
        String queryLine = "INSERT INTO nurse VALUES ('"
                + userID + "','" + password + "')";

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
}
