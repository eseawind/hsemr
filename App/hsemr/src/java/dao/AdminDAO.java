/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

package dao;
import entity.Admin;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Time;
import java.util.*;
/**
 *
 * @author jocelyn.ng.2012
 */
public class AdminDAO {
    public static Admin retrieve(String userid) {
        Connection conn = null;
        PreparedStatement stmt = null;
        ResultSet rs = null;
        Admin admin = null;
        
        try {
            conn = ConnectionManager.getConnection();
            stmt = conn.prepareStatement("select * from admin where adminID = ?");
            stmt.setString(1, userid);
            
            rs = stmt.executeQuery();
            while (rs.next()) {
                admin = new Admin(rs.getString(1), rs.getString(2));
            }

        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            ConnectionManager.close(conn, stmt, rs);
        }
        
        return admin;
    }
    
    public static List<Admin> retrieveAll(){
        List<Admin> list = new ArrayList<Admin>();
        Connection conn = null;
        PreparedStatement stmt = null;
        ResultSet rs = null;
        
        try {
            conn = ConnectionManager.getConnection();
            stmt = conn.prepareStatement("select * from admin");
            
            rs = stmt.executeQuery();
            while (rs.next()) {
                Admin admin = new Admin(rs.getString(1), rs.getString(2));
                list.add(admin);
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
        String query= "UPDATE admin SET adminPassword =? WHERE adminID =?";  
        
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
        String query= "DELETE FROM admin WHERE adminID =?";  
        
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
        String queryLine = "INSERT INTO admin VALUES ('"
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
