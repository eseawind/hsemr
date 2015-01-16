/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

package dao;

import entity.Document;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.TimeZone;

/**
 *
 * @author Jocelyn
 */
public class DocumentDAO {
    
    public static List<Document> retrieveDocumentsByScenario(String scenarioID) {
        Connection conn = null;
        PreparedStatement stmt = null;
        ResultSet rs = null;
        List<Document> docList = new ArrayList<Document>();

        try {
            conn = ConnectionManager.getConnection();
            stmt = conn.prepareStatement("select * from document where scenarioID = ? order by consentName");
            stmt.setString(1, scenarioID);
            rs = stmt.executeQuery();
            while (rs.next()) {
                Document doc = new Document(rs.getTimestamp(1), rs.getString(2), rs.getString(3), rs.getInt(4), rs.getString(5), rs.getString(6));
                docList.add(doc);
                
            }

        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            ConnectionManager.close(conn, stmt, rs);
        }
        return docList;
    }
    
     public static void add(String consentName, String consentFile, int consentStatus, String scenarioID, String stateID) {
        Connection conn = null;
        PreparedStatement preparedStatement = null;
        String query = "INSERT INTO document (consentDatetime, consentName, consentFile, consentStatus, scenarioID, stateID) VALUES (?, ?, ?, ?, ? ,?)";

        try {
            conn = ConnectionManager.getConnection();

            Date currentDateTime = new Date();
            
            DateFormat dateFormatter;
            dateFormatter = new SimpleDateFormat("yyyy-M-dd HH:mm:ss");
            dateFormatter.setTimeZone(TimeZone.getTimeZone("Singapore"));
            preparedStatement = conn.prepareStatement(query);
            preparedStatement.setString(1, dateFormatter.format(currentDateTime));
            preparedStatement.setString(2, consentName);
            preparedStatement.setString(3, consentFile);
            preparedStatement.setInt(4, consentStatus); //default despatched - 1
            preparedStatement.setString(5, scenarioID);
            preparedStatement.setString(6, stateID);
      
            preparedStatement.executeUpdate();

        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            ConnectionManager.close(conn, preparedStatement, null);
        }
    }
    
      public static List<Document> retrieveDocumentsByState(String scenarioID, String stateID) {
        Connection conn = null;
        PreparedStatement stmt = null;
        ResultSet rs = null;
        List<Document> docList = new ArrayList<Document>();

        try {
            conn = ConnectionManager.getConnection();
            stmt = conn.prepareStatement("select * from document where scenarioID = ? and stateID = ? order by consentName");
            stmt.setString(1, scenarioID);
            stmt.setString(2, stateID);

            rs = stmt.executeQuery();
            while (rs.next()) {
                Document doc = new Document(rs.getTimestamp(1), rs.getString(2), rs.getString(3), rs.getInt(4), rs.getString(5), rs.getString(6));
                docList.add(doc);
                
            }

        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            ConnectionManager.close(conn, stmt, rs);
        }
        return docList;
    }
    public static void updateStatus(Date consentDatetime, String consentName, int consentStatus, String scenarioID, String stateID) {
        Connection conn = null;
        PreparedStatement preparedStatement = null;
        String query = "UPDATE document SET  consentStatus=?, consentDatetime=?  WHERE consentName = ? and scenarioID = ? and stateID = ? ";

        try {
            conn = ConnectionManager.getConnection();
            DateFormat dateFormatter;
            dateFormatter = new SimpleDateFormat("yyyy-M-dd HH:mm:ss");
            dateFormatter.setTimeZone(TimeZone.getTimeZone("Singapore"));
            preparedStatement = conn.prepareStatement(query);
            preparedStatement.setInt(1, consentStatus);
            preparedStatement.setString(2, dateFormatter.format(consentDatetime));
            preparedStatement.setString(3, consentName);
            preparedStatement.setString(4, scenarioID);
            preparedStatement.setString(5, stateID);
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
        String query = "DELETE FROM document WHERE scenarioID =?";

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

