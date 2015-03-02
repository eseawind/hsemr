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
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.List;
import java.util.TimeZone;

/**
 *
 * @author Jocelyn Ng
 */
public class KeywordDAO {
    
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
                keyword = new Keyword(rs.getInt(1), rs.getString(2), rs.getString(3));
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
                Keyword newKey = new Keyword(rs.getInt(1), rs.getString(2), rs.getString(3));
                keywordList.add(newKey);
            }

        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            ConnectionManager.close(conn, stmt, rs);
        }
        return keywordList;
    }
    
    public static void insertKeyword(int keywordID, String keywordDesc, String fieldsToMap) {
        Connection conn = null;
        PreparedStatement stmt = null;
      
//        DateFormat dateFormatter;
        
        try {
            conn = ConnectionManager.getConnection();
            stmt = conn.prepareStatement("INSERT INTO note(keywordID,keywordDesc,fieldsToMap VALUES (?,?,?)");
          
         
            DateFormat dateFormatter;
            dateFormatter = new SimpleDateFormat("yyyy-M-dd HH:mm:ss");
            dateFormatter.setTimeZone(TimeZone.getTimeZone("Singapore"));
            stmt.setInt(1, keywordID);
            stmt.setString(2, keywordDesc);
            stmt.setString(3, fieldsToMap);
            stmt.executeUpdate();
       
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            ConnectionManager.close(conn, stmt);
        }
    }
    
    public static void delete(String keywordID) {
        Connection conn = null;
        PreparedStatement preparedStatement = null;
        String query = "DELETE FROM keyword WHERE keywordID =?";

        try {
            conn = ConnectionManager.getConnection();

            preparedStatement = conn.prepareStatement(query);
            preparedStatement.setString(1, keywordID);
            preparedStatement.executeUpdate();

        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            ConnectionManager.close(conn, preparedStatement, null);
        }
    }
    
}
