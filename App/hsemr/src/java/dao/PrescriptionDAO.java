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
import java.util.ArrayList;
import java.util.List;


/**
 *
 * @author Administrator
 */
public class PrescriptionDAO {
    
    public static void add(String scenarioID, String stateID, String doctorName, String doctorOrder, String freqAbbr, String medicineBarcode) {
        Connection conn = null;
        PreparedStatement stmt = null;
      
        try {
            conn = ConnectionManager.getConnection();
            stmt = conn.prepareStatement("INSERT INTO prescription(scenarioID,stateID,doctorName,doctorOrder,freqAbbr, medicineBarcode) VALUES (?,?,?,?,?,?)");
          
            stmt.setString(1, scenarioID);
            stmt.setString(2, stateID);
            stmt.setString(3, doctorName);
            stmt.setString(4, doctorOrder);
            stmt.setString(5, freqAbbr);
            stmt.setString(6, medicineBarcode);
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
                prescription = new Prescription(rs.getString(1), rs.getString(2),rs.getString(3),rs.getString(4),rs.getString(5));
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
                Prescription prescription = new Prescription(rs.getString(1), rs.getString(2),rs.getString(3),rs.getString(4),rs.getString(5));
                list.add(prescription);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            ConnectionManager.close(conn, stmt, rs);
        }
        return list;
    }
    
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
}
