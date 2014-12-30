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
import java.util.ArrayList;
import java.util.List;

/**
 *
 * @author Jocelyn
 */
public class DocumentDAO {
    
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
}

