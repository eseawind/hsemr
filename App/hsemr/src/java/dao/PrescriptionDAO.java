/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package dao;

import entity.MedicinePrescription;
import entity.Prescription;
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
 * @author Administrator
 */
public class PrescriptionDAO {
    
    public static void add(String scenarioID, String stateID, String doctorName, String doctorOrder, String freqAbbr, String medicineBarcode, String discontinueStateID) {
        Connection conn = null;
        PreparedStatement stmt = null;
      
        try {
            conn = ConnectionManager.getConnection();
            stmt = conn.prepareStatement("INSERT INTO prescription(scenarioID,stateID,doctorName,doctorOrder,freqAbbr, medicineBarcode, discontinueState, discontinueStatus) VALUES (?,?,?,?,?,?,?,0)");
          
            stmt.setString(1, scenarioID);
            stmt.setString(2, stateID);
            stmt.setString(3, doctorName);
            stmt.setString(4, doctorOrder);
            stmt.setString(5, freqAbbr);
            stmt.setString(6, medicineBarcode);
            stmt.setString(7, discontinueStateID);
             stmt.executeUpdate();
             
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            ConnectionManager.close(conn, stmt);
        }
    }
    
    
    
    public static List<Prescription> retrieveAll() {
        List<Prescription> prescriptionlist = new ArrayList<Prescription>();
        Connection conn = null;
        PreparedStatement stmt = null;
        ResultSet rs = null;
        Prescription prescription = null;

        try {
            conn = ConnectionManager.getConnection();
            stmt = conn.prepareStatement("select * from prescription");
         
            rs = stmt.executeQuery();
            while (rs.next()) {
                prescription = new Prescription(rs.getString(1), rs.getString(2),rs.getString(3),rs.getString(4),rs.getString(5), rs.getString(6), rs.getString(7), rs.getInt(8));
                prescriptionlist.add(prescription);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            ConnectionManager.close(conn, stmt, rs);
        }
        return prescriptionlist;
    }
    
    
    public static ArrayList<Prescription> retrieve(String scenarioID, String stateID) {
        ArrayList<Prescription> list = new ArrayList<Prescription>();
        Connection conn = null;
        PreparedStatement stmt = null;
        ResultSet rs = null;

        try {
            conn = ConnectionManager.getConnection();
            stmt = conn.prepareStatement("select * from prescription WHERE scenarioID = ? and stateID = ?");
            stmt.setString(1, scenarioID);
            stmt.setString(2, stateID);

            rs = stmt.executeQuery();
            while (rs.next()) {
                Prescription prescription = new Prescription(rs.getString(1), rs.getString(2),rs.getString(3),rs.getString(4),rs.getString(5), rs.getString(6), rs.getString(7), rs.getInt(8));
                list.add(prescription);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            ConnectionManager.close(conn, stmt, rs);
        }
        return list;
    }
    
    public static Prescription retrieve(String scenarioID, String stateID, String medicineBarcode) {
        Prescription prescription = null;
        Connection conn = null;
        PreparedStatement stmt = null;
        ResultSet rs = null;

        try {
            conn = ConnectionManager.getConnection();
            stmt = conn.prepareStatement("select * from prescription WHERE scenarioID = ? and stateID = ? and medicineBarcode = ?");
            stmt.setString(1, scenarioID);
            stmt.setString(2, stateID);
            stmt.setString(3, medicineBarcode);

            rs = stmt.executeQuery();
            while (rs.next()) {
                prescription = new Prescription(rs.getString(1), rs.getString(2),rs.getString(3),rs.getString(4),rs.getString(5), rs.getString(6),rs.getString(7), rs.getInt(8));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            ConnectionManager.close(conn, stmt, rs);
        }
        return prescription;
    }
    
    public static ArrayList<Prescription> retrieve(String scenarioID) {
        ArrayList<Prescription> list = new ArrayList<Prescription>();
        Connection conn = null;
        PreparedStatement stmt = null;
        ResultSet rs = null;

        try {
            conn = ConnectionManager.getConnection();
            stmt = conn.prepareStatement("select * from prescription WHERE scenarioID = ?");
            stmt.setString(1, scenarioID);

            rs = stmt.executeQuery();
            while (rs.next()) {
                Prescription prescription = new Prescription(rs.getString(1), rs.getString(2),rs.getString(3),rs.getString(4),rs.getString(5), rs.getString(6),rs.getString(7), rs.getInt(8));
                list.add(prescription);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            ConnectionManager.close(conn, stmt, rs);
        }
        return list;
    }
    
//    public static void updateDiscontinueStatus(String scenarioID, String stateID, String doctorOrder, int discontinueStatus) {
//        Connection conn = null;
//        PreparedStatement preparedStatement = null;
//        String query = "UPDATE prescription SET  discontinueStatus = ?  WHERE scenarioID = ? and stateID = ? and doctorOrder = ? ";
//
//        try {
//            conn = ConnectionManager.getConnection();
//            DateFormat dateFormatter;
//            dateFormatter = new SimpleDateFormat("yyyy-M-dd HH:mm:ss");
//            dateFormatter.setTimeZone(TimeZone.getTimeZone("Singapore"));
//            preparedStatement = conn.prepareStatement(query);
//            preparedStatement.setInt(1, discontinueStatus);
//            preparedStatement.setString(2, scenarioID);
//            preparedStatement.setString(3, stateID);
//            preparedStatement.setString(4, doctorOrder);
//            preparedStatement.executeUpdate();
//
//        } catch (SQLException e) {
//            e.printStackTrace();
//        } finally {
//            ConnectionManager.close(conn, preparedStatement, null);
//        }
//    }
//    
//    public static ArrayList<Prescription> retrieveBasedOnDiscontinueState(String scenarioID, String discontinueState) {
//        ArrayList<Prescription> list = new ArrayList<Prescription>();
//        Connection conn = null;
//        PreparedStatement stmt = null;
//        ResultSet rs = null;
//
//        try {
//            conn = ConnectionManager.getConnection();
//            stmt = conn.prepareStatement("select * from prescription WHERE scenarioID = ? and discontinueState = ?");
//            stmt.setString(1, scenarioID);
//            stmt.setString(2, discontinueState);
//
//            rs = stmt.executeQuery();
//            while (rs.next()) {
//                Prescription prescription = new Prescription(rs.getString(1), rs.getString(2),rs.getString(3),rs.getString(4),rs.getString(5), rs.getString(6),rs.getString(7), rs.getInt(8));
//                list.add(prescription);
//            }
//        } catch (SQLException e) {
//            e.printStackTrace();
//        } finally {
//            ConnectionManager.close(conn, stmt, rs);
//        }
//        return list;
//    }
    
    
    public static void delete(String scenarioID) {
        Connection conn = null;
        PreparedStatement preparedStatement = null;
        String query = "DELETE FROM prescription WHERE scenarioID =?";

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
    public static ArrayList<Prescription> retrieveOnlyNA(String scenarioID, String stateID) {
        ArrayList<Prescription> list = new ArrayList<Prescription>();
        Connection conn = null;
        PreparedStatement stmt = null;
        ResultSet rs = null;

        try {
            conn = ConnectionManager.getConnection();
            stmt = conn.prepareStatement("select * from prescription WHERE scenarioID = ? and stateID = ? and medicineBarcode = 'NA'");
            stmt.setString(1, scenarioID);
            stmt.setString(2, stateID);

            rs = stmt.executeQuery();
            while (rs.next()) {
                Prescription prescription = new Prescription(rs.getString(1), rs.getString(2),rs.getString(3),rs.getString(4),rs.getString(5), rs.getString(6), rs.getString(7), rs.getInt(8));
                list.add(prescription);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            ConnectionManager.close(conn, stmt, rs);
        }
        return list;
    }

    public static void updatePres(String doctorName, String doctorOrder, String freqAbbr, String scenarioID, String stateID, String medicineBarcode) {
        Connection conn = null;
        PreparedStatement preparedStatement = null;
        String query = "UPDATE prescription SET doctorName=? , doctorOrder=?, freqAbbr=? WHERE scenarioID=? AND stateID=? AND medicineBarcode=?";

        try {
            conn = ConnectionManager.getConnection();

            preparedStatement = conn.prepareStatement(query);
            preparedStatement.setString(1, doctorName);
            preparedStatement.setString(2, doctorOrder);
            preparedStatement.setString(3, freqAbbr);
            preparedStatement.setString(4, scenarioID);
            preparedStatement.setString(5, stateID);
            preparedStatement.setString(6, medicineBarcode);
            preparedStatement.executeUpdate();

        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            ConnectionManager.close(conn, preparedStatement, null);
        }
    }
   
    public static void deletePrescriptionNA (String scenarioID, String stateID) {
        Connection conn = null;
        PreparedStatement preparedStatement = null;
        String query = "DELETE FROM prescription WHERE scenarioID =? AND stateID =? AND medicineBarcode =?";

        try {
            conn = ConnectionManager.getConnection();

            preparedStatement = conn.prepareStatement(query);
            preparedStatement.setString(1, scenarioID);
            preparedStatement.setString(2, stateID);
            preparedStatement.setString(3, "NA");
            preparedStatement.executeUpdate();

        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            ConnectionManager.close(conn, preparedStatement, null);
        }
    }
}
