/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

package dao;

import entity.Keyword;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

/**
 *
 * @author Jocelyn Ng
 */
public class KeywordDAO {
    
    public static List<Keyword> retrieveKeywordDesc() {
        Connection conn = null;
        PreparedStatement stmt = null;
        ResultSet rs = null;
        List<Keyword> keywordList= new ArrayList<Keyword>();
        Keyword keyword= null;

        try {
            conn = ConnectionManager.getConnection();
            stmt = conn.prepareStatement("select * from keyword");
         

            rs = stmt.executeQuery();
            while (rs.next()) {
                keyword = new Keyword(rs.getInt(1), rs.getString(2), rs.getString(3), rs.getString(4));
                keywordList.add(keyword);
            }

        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            ConnectionManager.close(conn, stmt, rs);
        }
        return keywordList;
    }
    
     public static String retrieveEntity(String fieldsToMap) {
        Connection conn = null;
        PreparedStatement stmt = null;
        ResultSet rs = null;
       // Keyword keyword = null;
        String entity= "";

        try {
            conn = ConnectionManager.getConnection();
            stmt = conn.prepareStatement("select entityToMap from keyword where fieldsToMap = ?");
            stmt.setString(1, fieldsToMap);

            rs = stmt.executeQuery();
            while (rs.next()) {
              //  keyword = new Keyword(rs.getInt(1), rs.getString(2), rs.getString(3), rs.getString(4));
                entity = rs.getString(1);
            }

        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            ConnectionManager.close(conn, stmt, rs);
        }
       // return keyword;
        return entity;
    }
         
    
    public static List<Keyword> retrieveKeywordsByFields(String fieldsToMap) {
        Connection conn = null;
        PreparedStatement stmt = null;
        ResultSet rs = null;
        List<Keyword> keywordList = new ArrayList<Keyword>();

        try {
            conn = ConnectionManager.getConnection();
            stmt = conn.prepareStatement("select * from keyword where fieldsToMap = ?");
            stmt.setString(1, fieldsToMap);
            rs = stmt.executeQuery();

            while (rs.next()) {
                Keyword newKey = new Keyword(rs.getInt(1), rs.getString(2), rs.getString(3), rs.getString(4));
                
                keywordList.add(newKey);
            }

        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            ConnectionManager.close(conn, stmt, rs);
        }
        return keywordList;
    }
    
    public static Keyword retrieve(String keywordID) {
        Connection conn = null;
        PreparedStatement stmt = null;
        ResultSet rs = null;
        Keyword keyword = null;

        try {
            conn = ConnectionManager.getConnection();
            stmt = conn.prepareStatement("select * from keyword where keywordID = ?");
            stmt.setString(1, keywordID);

            rs = stmt.executeQuery();
            while (rs.next()) {
                keyword = new Keyword(rs.getInt(1), rs.getString(2), rs.getString(3), rs.getString(4));
            }

        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            ConnectionManager.close(conn, stmt, rs);
        }
        return keyword;
    }
    
    public static List<Keyword> retrieveAll() {
        Connection conn = null;
        PreparedStatement stmt = null;
        ResultSet rs = null;
        List<Keyword> keywordList = new ArrayList<Keyword>();

        try {
            conn = ConnectionManager.getConnection();
            stmt = conn.prepareStatement("SELECT * FROM keyword");
            rs = stmt.executeQuery();

            while (rs.next()) {
                Keyword newKey = new Keyword(rs.getInt(1), rs.getString(2), rs.getString(3), rs.getString(4));
                keywordList.add(newKey);
            }

        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            ConnectionManager.close(conn, stmt, rs);
        }
        return keywordList;
    }
    
   public static void insertKeyword(int keywordID, String keywordDesc, String fieldsToMap, String entityToMap) {
        Connection conn = null;
        PreparedStatement preparedStatement = null;
        String query = "INSERT INTO keyword (keywordID, keywordDesc, fieldsToMap, entityToMap) VALUES (?, ?, ?, ?)";

        try {
            conn = ConnectionManager.getConnection();
            
            preparedStatement = conn.prepareStatement(query);
            preparedStatement.setInt(1, keywordID);
            preparedStatement.setString(2, keywordDesc);
            preparedStatement.setString(3, fieldsToMap);
            preparedStatement.setString(4, entityToMap);
            preparedStatement.executeUpdate();

        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            ConnectionManager.close(conn, preparedStatement, null);
        }
    }
      
    
    public static void delete(int keywordID) {
        Connection conn = null;
        PreparedStatement preparedStatement = null;
        String query = "DELETE FROM keyword WHERE keywordID =?";

        try {
            conn = ConnectionManager.getConnection();

            preparedStatement = conn.prepareStatement(query);
            preparedStatement.setInt(1, keywordID);
            preparedStatement.executeUpdate();

        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            ConnectionManager.close(conn, preparedStatement, null);
        }
    }
    
}
