/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

package dao;

import entity.*;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

/**
 *
 * @author Administrator
 */
public class MedicineDAO {
    
     public static Medicine retrieve(String medicineBarcode) {
        Connection conn = null;
        PreparedStatement stmt = null;
        ResultSet rs = null;
        Medicine medicine = null;

        try {
            conn = ConnectionManager.getConnection();
            stmt = conn.prepareStatement("select * from medicine WHERE medicineBarcode = ?");
            stmt.setString(1, medicineBarcode);

            rs = stmt.executeQuery();
            while (rs.next()) {
                medicine = new Medicine(rs.getString(1), rs.getString(2),rs.getString(3),rs.getString(4),rs.getString(5));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            ConnectionManager.close(conn, stmt, rs);
        }
        return medicine;
    }
    
}
