/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

package dao;

import entity.PracticalGroup;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

/**
 *
 * @author weiyi.ngow.2012
 */
public class PracticalGroupDAO {
    public static PracticalGroup retrieve(String practicalGroupID) {
        Connection conn = null;
        PreparedStatement stmt = null;
        ResultSet rs = null;
        PracticalGroup practicalGroup = null;
        
        try {
            conn = ConnectionManager.getConnection();
            stmt = conn.prepareStatement("select * from practicalgroup where practicalGroupID = ?");
            stmt.setString(1, practicalGroupID);
            
            rs = stmt.executeQuery();
            while (rs.next()) {
                practicalGroup = new PracticalGroup(rs.getString(1), rs.getString(2), rs.getString(3));
            }

        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            ConnectionManager.close(conn, stmt, rs);
        }
        
        return practicalGroup;
    }

    
    
    public static List<PracticalGroup> retrieveAll() {
        List<PracticalGroup> list = new ArrayList<PracticalGroup>();
        Connection conn = null;
        PreparedStatement stmt = null;
        ResultSet rs = null;

        try {
            conn = ConnectionManager.getConnection();
            stmt = conn.prepareStatement("select * from practicalgroup");

            rs = stmt.executeQuery();
            while (rs.next()) {
                PracticalGroup practicalGroup = new PracticalGroup(rs.getString(1), rs.getString(2), rs.getString(3));
                list.add(practicalGroup);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            ConnectionManager.close(conn, stmt, rs);
        }
        return list;
    }
    
    public static List<PracticalGroup> retrieveByLecturerID(String lecturerID) {
        List<PracticalGroup> list = new ArrayList<PracticalGroup>();
        Connection conn = null;
        PreparedStatement stmt = null;
        ResultSet rs = null;
        

        try {
           conn = ConnectionManager.getConnection();
            stmt = conn.prepareStatement("select * from practicalgroup where lecturerID = ?");
            stmt.setString(1, lecturerID);
            
            rs = stmt.executeQuery();
            while (rs.next()) {
                PracticalGroup practicalGroup = new PracticalGroup(rs.getString(1), rs.getString(2), rs.getString(3));
                list.add(practicalGroup);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            ConnectionManager.close(conn, stmt, rs);
        }
        return list;
    }
    
    
    public static PracticalGroup retrieveByLecturer(String lecturerID) {
        Connection conn = null;
        PreparedStatement stmt = null;
        ResultSet rs = null;
        PracticalGroup practicalGroup = null;
        
        try {
            conn = ConnectionManager.getConnection();
            stmt = conn.prepareStatement("select * from practicalgroup where lecturerID = ?");
            stmt.setString(1, lecturerID);
            
            rs = stmt.executeQuery();
            while (rs.next()) {
                practicalGroup = new PracticalGroup(rs.getString(1), rs.getString(2), rs.getString(3));
            }

        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            ConnectionManager.close(conn, stmt, rs);
        }
        
        return practicalGroup;
    }
    
    
    public static void update(String practicalGroupID, String practicalGroupPassword, String lecturerID) {
        Connection conn = null;
        PreparedStatement preparedStatement = null;
        String query= "UPDATE practicalgroup SET practicalGroupPassword =?, lecturerID = ? WHERE practicalGroupID =?";  
        
        try {
            conn = ConnectionManager.getConnection();

            preparedStatement = conn.prepareStatement(query);
            preparedStatement.setString(1,practicalGroupPassword);
            preparedStatement.setString(2,lecturerID);
            preparedStatement.setString(3,practicalGroupID);
            preparedStatement.executeUpdate();
            
        } catch(SQLException e) {
            e.printStackTrace();
        }finally {
            ConnectionManager.close(conn,preparedStatement,null);
        }        
    }
    
    public static void updateLecturer(String practicalGroupID, String lecturerID) {
        Connection conn = null;
        PreparedStatement preparedStatement = null;
        String query= "UPDATE practicalgroup SET lecturerID = ? WHERE practicalGroupID =?";  
        
        try {
            conn = ConnectionManager.getConnection();

            preparedStatement = conn.prepareStatement(query);
            preparedStatement.setString(1,lecturerID);
            preparedStatement.setString(2,practicalGroupID);
            preparedStatement.executeUpdate();
            
        } catch(SQLException e) {
            e.printStackTrace();
        }finally {
            ConnectionManager.close(conn,preparedStatement,null);
        }        
    }
    
    public static void delete(String practicalGroupID) {
         Connection conn = null;
        PreparedStatement preparedStatement = null;
        String query= "DELETE FROM practicalgroup WHERE practicalGroupID =?";  
        
        try {
            conn = ConnectionManager.getConnection();

            preparedStatement = conn.prepareStatement(query);
            preparedStatement.setString(1,practicalGroupID);
            preparedStatement.executeUpdate();
            
        } catch(SQLException e) {
            e.printStackTrace();
        }finally {
            ConnectionManager.close(conn,preparedStatement,null);
        }        
    }
   
    public static void add(String practicalGroupID, String practicalGroupPassword, String lecturerID) {
        Connection conn = null;
        PreparedStatement preparedStatement = null;
        String queryLine = "INSERT INTO practicalgroup VALUES ('"
                + practicalGroupID + "','" + practicalGroupPassword + "','" + lecturerID + "')";

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
