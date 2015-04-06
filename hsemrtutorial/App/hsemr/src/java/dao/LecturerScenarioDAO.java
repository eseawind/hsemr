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
import java.util.List;

/**
 *
 * @author Administrator
 */
public class LecturerScenarioDAO {
    
    public static String retrieveScenario(String lecturerID) {
        Connection conn = null;
        PreparedStatement stmt = null;
        ResultSet rs = null;
        String scenarioID = null;

        try {
            conn = ConnectionManager.getConnection();
            stmt = conn.prepareStatement("select scenarioID from lecturer_scenario where lecturerID = ?");
            stmt.setString(1, lecturerID);

            rs = stmt.executeQuery();
            while (rs.next()) {
                scenarioID = rs.getString(1);
            }

        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            ConnectionManager.close(conn, stmt, rs);
        }
        return scenarioID;
    }
    
        
    public static LecturerScenario retrieveLecturer(String lecturerID) {
        Connection conn = null;
        PreparedStatement stmt = null;
        ResultSet rs = null;
        LecturerScenario lecturerScenario = null;

        try {
            conn = ConnectionManager.getConnection();
            stmt = conn.prepareStatement("select * from lecturer_scenario where lecturerID = ?");
            stmt.setString(1, lecturerID);

            rs = stmt.executeQuery();
            while (rs.next()) {
                lecturerScenario = new LecturerScenario(rs.getString(1), rs.getString(2));
            }

        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            ConnectionManager.close(conn, stmt, rs);
        }
        return lecturerScenario;
    }

    
    public static void deleteAll (){
        Connection conn = null;
        PreparedStatement preparedStatement = null;
        String query = "DELETE FROM lecturer_scenario";
        
        try {
            conn = ConnectionManager.getConnection();
            preparedStatement = conn.prepareStatement(query);
            preparedStatement.executeUpdate();

        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            ConnectionManager.close(conn, preparedStatement, null);
        }
    
    }

    
    public static void deactivateScenarioForLecturer(String lecturerID) {
        Connection conn = null;
        PreparedStatement stmt = null;
        ResultSet rs = null;
        LecturerScenario lecturerScenario = null;

        try {
            conn = ConnectionManager.getConnection();
            stmt = conn.prepareStatement("DELETE FROM lecturer_scenario where lecturerID = ?");
            stmt.setString(1, lecturerID);

            rs = stmt.executeQuery();
            while (rs.next()) {
                lecturerScenario = new LecturerScenario(rs.getString(1), rs.getString(2));
            }

        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            ConnectionManager.close(conn, stmt, rs);
        }
    }
     
    
    public static LecturerScenario retrieve(String lecturerID, String scenarioID) {
        Connection conn = null;
        PreparedStatement stmt = null;
        ResultSet rs = null;
        LecturerScenario lecturerScenario = null;

        try {
            conn = ConnectionManager.getConnection();
            stmt = conn.prepareStatement("select * from lecturer_scenario where lecturerID = ? and scenarioID = ?");
            stmt.setString(1, lecturerID);
            stmt.setString(2, scenarioID);

            rs = stmt.executeQuery();
            while (rs.next()) {
                lecturerScenario = new LecturerScenario(rs.getString(1), rs.getString(2));
            }

        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            ConnectionManager.close(conn, stmt, rs);
        }
        return lecturerScenario;
    }
    
    public static LecturerScenario retrieve(String scenarioID) {
        Connection conn = null;
        PreparedStatement stmt = null;
        ResultSet rs = null;
        LecturerScenario lecturerScenario = null;

        try {
            conn = ConnectionManager.getConnection();
            stmt = conn.prepareStatement("select * from lecturer_scenario where scenarioID = ?");
            stmt.setString(1, scenarioID);

            rs = stmt.executeQuery();
            while (rs.next()) {
                lecturerScenario = new LecturerScenario(rs.getString(1), rs.getString(2));
            }

        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            ConnectionManager.close(conn, stmt, rs);
        }
        return lecturerScenario;
    }
    
    public static List<String> retrieveDistinctScenarioActivated() {
        Connection conn = null;
        PreparedStatement stmt = null;
        ResultSet rs = null;
        List<String> scenarioActivatedList = new ArrayList<String>();

        try {
            conn = ConnectionManager.getConnection();
            stmt = conn.prepareStatement("SELECT DISTINCT scenarioID FROM lecturer_scenario");
            rs = stmt.executeQuery();

            while (rs.next()) {
                scenarioActivatedList.add(rs.getString(1));
            }

        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            ConnectionManager.close(conn, stmt, rs);
        }
        return scenarioActivatedList;
    }
    
    
    public static List<String> retrieveLecturerActivatedScenario(String scenarioID) {
        Connection conn = null;
        PreparedStatement stmt = null;
        ResultSet rs = null;
        List<String> scenarioActivatedList = new ArrayList<String>();

        try {
            conn = ConnectionManager.getConnection();
            stmt = conn.prepareStatement("select lecturerID from lecturer_scenario where scenarioID = ?");
            stmt.setString(1, scenarioID);
            rs = stmt.executeQuery();

            while (rs.next()) {
                scenarioActivatedList.add(rs.getString(1));
            }

        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            ConnectionManager.close(conn, stmt, rs);
        }
        return scenarioActivatedList;
    }
    
    public static List<String> retrieveDistinctLecturersWhoDidNotActivateAnyCase() {
        Connection conn = null;
        PreparedStatement stmt = null;
        ResultSet rs = null;
        List<String> scenarioActivatedList = new ArrayList<String>();

        try {
            conn = ConnectionManager.getConnection();
            stmt = conn.prepareStatement("SELECT lecturerID from lecturer where lecturerID not in (SELECT DISTINCT lecturerID FROM lecturer_scenario)");
            rs = stmt.executeQuery();

            while (rs.next()) {
                scenarioActivatedList.add(rs.getString(1));
            }

        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            ConnectionManager.close(conn, stmt, rs);
        }
        return scenarioActivatedList;
    }
    
    public static List<String> retrieveDistinctActivatedLecturers() {
        Connection conn = null;
        PreparedStatement stmt = null;
        ResultSet rs = null;
        List<String> scenarioActivatedList = new ArrayList<String>();

        try {
            conn = ConnectionManager.getConnection();
            stmt = conn.prepareStatement("SELECT lecturerID from lecturer_scenario");
            rs = stmt.executeQuery();

            while (rs.next()) {
                scenarioActivatedList.add(rs.getString(1));
            }

        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            ConnectionManager.close(conn, stmt, rs);
        }
        return scenarioActivatedList;
    }
    
    public static List<String> retrieveDistinctLecturers(String scenarioID) {
        Connection conn = null;
        PreparedStatement stmt = null;
        ResultSet rs = null;
        List<String> scenarioActivatedList = new ArrayList<String>();

        try {
            conn = ConnectionManager.getConnection();
            stmt = conn.prepareStatement("SELECT DISTINCT lecturerID FROM lecturer_scenario where scenarioID = ?");
            stmt.setString(1, scenarioID);
            rs = stmt.executeQuery();

            while (rs.next()) {
                scenarioActivatedList.add(rs.getString(1));
            }

        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            ConnectionManager.close(conn, stmt, rs);
        }
        return scenarioActivatedList;
    }
    
    public static List<String> retrieveDistinctLecturersDidNotActivate(String scenarioID) {
        Connection conn = null;
        PreparedStatement stmt = null;
        ResultSet rs = null;
        List<String> scenarioActivatedList = new ArrayList<String>();

        try {
            conn = ConnectionManager.getConnection();
            stmt = conn.prepareStatement("select * from lecturer where lecturerID not in (SELECT DISTINCT lecturerID FROM lecturer_scenario where scenarioID = ?)");
            stmt.setString(1, scenarioID);
            rs = stmt.executeQuery();

            while (rs.next()) {
                scenarioActivatedList.add(rs.getString(1));
            }

        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            ConnectionManager.close(conn, stmt, rs);
        }
        return scenarioActivatedList;
    }
    
    public static List<String> retrieveScenarioActivated() {
        Connection conn = null;
        PreparedStatement stmt = null;
        ResultSet rs = null;
        List<String> scenarioActivatedList = new ArrayList<String>();

        try {
            conn = ConnectionManager.getConnection();
            stmt = conn.prepareStatement("SELECT scenarioID FROM lecturer_scenario");
            rs = stmt.executeQuery();

            while (rs.next()) {
                scenarioActivatedList.add(rs.getString(1));
            }

        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            ConnectionManager.close(conn, stmt, rs);
        }
        return scenarioActivatedList;
    }
    
    public static void activateScenario(String lecturerID, String scenarioID) {
        Connection conn = null;
        PreparedStatement stmt = null;

        try {
            conn = ConnectionManager.getConnection();
            stmt = conn.prepareStatement("INSERT INTO lecturer_scenario(lecturerID, scenarioID) VALUES (?,?)");
            stmt.setString(1, lecturerID);
            stmt.setString(2, scenarioID);
            stmt.executeUpdate();

        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            ConnectionManager.close(conn, stmt);
        }

    }
    
    public static void deactivateScenario(String lecturerID, String scenarioID) {
        Connection conn = null;
        PreparedStatement stmt = null;

        try {
            conn = ConnectionManager.getConnection();
            stmt = conn.prepareStatement("DELETE FROM lecturer_scenario WHERE lecturerID = ? and scenarioID = ?");
            stmt.setString(1, lecturerID);
            stmt.setString(2, scenarioID);
            stmt.executeUpdate();

        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            ConnectionManager.close(conn, stmt);
        }

    }
    
    public static void deactivateScenario(String lecturerID) {
        Connection conn = null;
        PreparedStatement stmt = null;

        try {
            conn = ConnectionManager.getConnection();
            stmt = conn.prepareStatement("DELETE FROM lecturer_scenario WHERE lecturerID = ?");
            stmt.setString(1, lecturerID);
            stmt.executeUpdate();

        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            ConnectionManager.close(conn, stmt);
        }

    }

    
}
