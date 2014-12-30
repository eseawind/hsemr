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
    
   public static List<Document> retrieveAll() {
        Connection conn = null;
        PreparedStatement stmt = null;
        ResultSet rs = null;
        List<Document> documentList = new ArrayList<Document>();

        try {
            conn = ConnectionManager.getConnection();
            stmt = conn.prepareStatement("SELECT * FROM document");
            rs = stmt.executeQuery();

            while (rs.next()) {
                Document doc = new Document(rs.getString(1), rs.getString(2), rs.getDate(3), rs.getInt(4));
                documentList.add(doc);
            }

        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            ConnectionManager.close(conn, stmt, rs);
        }
        return documentList;
    }
}

