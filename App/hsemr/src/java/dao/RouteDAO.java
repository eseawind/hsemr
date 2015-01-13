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
public class RouteDAO {
    public static List<Route> retrieveAll() {
        List<Route> routelist = new ArrayList<Route>();
        Connection conn = null;
        PreparedStatement stmt = null;
        ResultSet rs = null;
        Route route = null;

        try {
            conn = ConnectionManager.getConnection();
            stmt = conn.prepareStatement("select * from Route");
         
            rs = stmt.executeQuery();
            while (rs.next()) {
                route = new Route(rs.getString(1), rs.getString(2));
                routelist.add(route);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            ConnectionManager.close(conn, stmt, rs);
        }
        return routelist;
    }
}
