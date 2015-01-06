/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

package dao;

import entity.Scenario;
import entity.Ward;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

/**
 *
 * @author hpkhoo.2012
 */
public class WardDAO {
    
    
     public static void add(String wardID, int bedNum, int availabilityStatus) {
        Connection conn = null;
        PreparedStatement preparedStatement = null;
        String queryLine = "INSERT INTO ward VALUES ('"
                + wardID + "','" + bedNum + "','" + availabilityStatus + "')";

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
    
     public static Ward retrieve(String wardID) {
        Connection conn = null;
        PreparedStatement stmt = null;
        ResultSet rs = null;
        Ward ward= null;

        try {
            conn = ConnectionManager.getConnection();
            stmt = conn.prepareStatement("select * from ward where wardID = ?");
            stmt.setString(1, wardID);

            rs = stmt.executeQuery();
            while (rs.next()) {
                ward = new Ward(rs.getString(1), rs.getInt(2), rs.getInt(3));
            }

        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            ConnectionManager.close(conn, stmt, rs);
        }
        return ward;
    }
    
    public static List<Ward> retrieveAll() {
        Connection conn = null;
        PreparedStatement stmt = null;
        ResultSet rs = null;
        List<Ward> wardList = new ArrayList<Ward>();

        try {
            conn = ConnectionManager.getConnection();
            stmt = conn.prepareStatement("SELECT * FROM Ward");
            rs = stmt.executeQuery();

            while (rs.next()) {
                Ward newWard = new Ward(rs.getString(1), rs.getInt(2), rs.getInt(3));
                wardList.add(newWard);
            }

        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            ConnectionManager.close(conn, stmt, rs);
        }
        return wardList;
    }

    
}
