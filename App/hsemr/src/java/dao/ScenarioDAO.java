/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package dao;

import entity.Scenario;
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
public class ScenarioDAO {

    public static Scenario retrieve(String scenarioID) {
        Connection conn = null;
        PreparedStatement stmt = null;
        ResultSet rs = null;
        Scenario scenario = null;

        try {
            conn = ConnectionManager.getConnection();
            stmt = conn.prepareStatement("select * from scenario where scenarioID = ?");
            stmt.setString(1, scenarioID);

            rs = stmt.executeQuery();
            while (rs.next()) {
                scenario = new Scenario(rs.getString(1), rs.getString(2), rs.getString(3), rs.getInt(4), rs.getString(5), rs.getInt(6));
            }

        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            ConnectionManager.close(conn, stmt, rs);
        }
        return scenario;
    }

    public static Scenario retrieveActivatedScenario() {
        Connection conn = null;
        PreparedStatement stmt = null;
        ResultSet rs = null;
        Scenario scenario = null;

        try {
            conn = ConnectionManager.getConnection();
            stmt = conn.prepareStatement("select * from scenario where scenarioStatus = ?");
            stmt.setInt(1, 1);

            rs = stmt.executeQuery();
            while (rs.next()) {
                scenario = new Scenario(rs.getString(1), rs.getString(2), rs.getString(3), rs.getInt(4), rs.getString(5), rs.getInt(6));
            }

        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            ConnectionManager.close(conn, stmt, rs);
        }
        return scenario;
    }

    public static void add(String scenarioID, String scenarioName, String scenarioDescription, int scenarioStatus, String admissionNote, int bedNumber) {
        Connection conn = null;
        PreparedStatement preparedStatement = null;
        String query = "INSERT INTO scenario (scenarioID, scenarioName, scenarioDescription, scenarioStatus, admissionNote, bedNumber) VALUES (?,?,?,?,?,?)";

        try {
            conn = ConnectionManager.getConnection();
            preparedStatement = conn.prepareStatement(query);
            
            preparedStatement.setString(1, scenarioID);
            preparedStatement.setString(2, scenarioName);
            preparedStatement.setString(3, scenarioDescription);
            preparedStatement.setInt(4, scenarioStatus);
            preparedStatement.setString(5, admissionNote);
            preparedStatement.setInt(6, bedNumber);
            preparedStatement.executeUpdate();

        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            ConnectionManager.close(conn, preparedStatement, null);
        }
    }
    
       public static Integer retrieveMaxBedNumber() {
        Connection conn = null;
        PreparedStatement stmt = null;
        ResultSet rs = null;
        int maxBed = 0;

        try {
            conn = ConnectionManager.getConnection();
            stmt = conn.prepareStatement("select max(bedNumber) as maxBed from scenario");

            rs = stmt.executeQuery();
            while (rs.next()) {
                maxBed = rs.getInt("maxBed");
            }

        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            ConnectionManager.close(conn, stmt, rs);
        }
        return maxBed;
    }
    
    
    public static List<Scenario> retrieveAll() {
        Connection conn = null;
        PreparedStatement stmt = null;
        ResultSet rs = null;
        List<Scenario> scenarioList = new ArrayList<Scenario>();

        try {
            conn = ConnectionManager.getConnection();
            stmt = conn.prepareStatement("SELECT * FROM scenario");
            rs = stmt.executeQuery();

            while (rs.next()) {
                Scenario newScenario = new Scenario(rs.getString(1), rs.getString(2), rs.getString(3), rs.getInt(4), rs.getString(5), rs.getInt(6));
                scenarioList.add(newScenario);
            }

        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            ConnectionManager.close(conn, stmt, rs);
        }
        return scenarioList;
    }

    public static void updateScenarioStatus(String scenarioID, int scenarioStatus) {
        Connection conn = null;
        PreparedStatement stmt = null;

        try {
            conn = ConnectionManager.getConnection();
            stmt = conn.prepareStatement("UPDATE scenario SET scenarioStatus = ? WHERE  scenarioID = ?");
            stmt.setInt(1, scenarioStatus);
            stmt.setString(2, scenarioID);

            stmt.executeUpdate();

        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            ConnectionManager.close(conn, stmt);
        }

    }

    public static void update(String scenarioID, String scenarioName, String scenarioDescription, int scenarioStatus, String admissionNote) {
        Connection conn = null;
        PreparedStatement preparedStatement = null;
        String query = "UPDATE scenario SET  scenarioName=?, scenarioDescription=?, scenarioStatus =?, admissionNote =?  WHERE scenarioID =?";

        try {
            conn = ConnectionManager.getConnection();

            preparedStatement = conn.prepareStatement(query);
            preparedStatement.setString(1, scenarioName);
            preparedStatement.setString(2, scenarioDescription);
            preparedStatement.setInt(3, scenarioStatus);
            preparedStatement.setString(4, admissionNote);
            preparedStatement.setString(5, scenarioID);
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
        String query = "DELETE FROM scenario WHERE scenarioID =?;";

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
    public static List<Scenario> retrieveAndSortByBedNum() {
        Connection conn = null;
        PreparedStatement stmt = null;
        ResultSet rs = null;
        List<Scenario> scenarioList = new ArrayList<Scenario>();

        try {
            conn = ConnectionManager.getConnection();
            stmt = conn.prepareStatement("SELECT * FROM scenario ORDER BY bedNumber ASC");
            rs = stmt.executeQuery();

            while (rs.next()) {
                Scenario newScenario = new Scenario(rs.getString(1), rs.getString(2), rs.getString(3), rs.getInt(4), rs.getString(5), rs.getInt(6));
                scenarioList.add(newScenario);
            }

        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            ConnectionManager.close(conn, stmt, rs);
        }
        return scenarioList;
    }
    public static void resetScenario() {
        Connection conn = null;
        PreparedStatement preparedStatement = null;
        String query = "UPDATE scenario SET scenarioStatus =0";

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

}
