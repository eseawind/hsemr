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
import java.util.*;

/**
 *
 * @author hpkhoo.2012
 */
public class FrequencyDAO {
    
    public static List<Frequency> retrieveAll() {
        List<Frequency> freqlist = new ArrayList<Frequency>();
        Connection conn = null;
        PreparedStatement stmt = null;
        ResultSet rs = null;
        Frequency freq = null;

        try {
            conn = ConnectionManager.getConnection();
            stmt = conn.prepareStatement("select * from frequency");
         
            rs = stmt.executeQuery();
            while (rs.next()) {
                freq = new Frequency(rs.getString(1), rs.getString(2));
                freqlist.add(freq);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            ConnectionManager.close(conn, stmt, rs);
        }
        return freqlist;
    }
    
}
