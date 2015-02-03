/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package dao;

import entity.MedicinePrescription;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

/**
 *
 * @author Administrator
 */
public class MedicinePrescriptionDAO {
    
    public static void add(String medicineBarcode, String scenarioID, String stateID, String freqAbbr, String dosage) {
        Connection conn = null;
        PreparedStatement stmt = null;
      
        try {
            conn = ConnectionManager.getConnection();
            stmt = conn.prepareStatement("INSERT INTO medicine_prescription(medicineBarcode,scenarioID,stateID,freqAbbr,dosage) VALUES (?,?,?,?,?)");
          
            stmt.setString(1, medicineBarcode);
            stmt.setString(2, scenarioID);
            stmt.setString(3, stateID);
            stmt.setString(4, freqAbbr);
            stmt.setString(5, dosage);
            stmt.executeUpdate();
           
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            ConnectionManager.close(conn, stmt);
        }
    }

    public static ArrayList<MedicinePrescription> retrieve(String scenarioID, String stateID) {
        ArrayList<MedicinePrescription> list = new ArrayList<MedicinePrescription>();
        Connection conn = null;
        PreparedStatement stmt = null;
        ResultSet rs = null;

        try {
            conn = ConnectionManager.getConnection();
            stmt = conn.prepareStatement("select * from medicine_prescription WHERE scenarioID = ? and stateID = ?");
            stmt.setString(1, scenarioID);
            stmt.setString(2, stateID);

            rs = stmt.executeQuery();
            while (rs.next()) {
                MedicinePrescription medicinePrescription = new MedicinePrescription(rs.getString(1), rs.getString(2), rs.getString(3), rs.getString(4), rs.getString(5));
                list.add(medicinePrescription);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            ConnectionManager.close(conn, stmt, rs);
        }
        return list;
    }
    
      public static MedicinePrescription retrieve(String medicineBarcode) {
        
        Connection conn = null;
        PreparedStatement stmt = null;
        ResultSet rs = null;
        MedicinePrescription medicinePrescription = null;

        try {
            conn = ConnectionManager.getConnection();
            stmt = conn.prepareStatement("select * from medicine_prescription WHERE medicineBarcode = ?");
            stmt.setString(1, medicineBarcode);

            rs = stmt.executeQuery();
            while (rs.next()) {
                medicinePrescription = new MedicinePrescription(rs.getString(1), rs.getString(2), rs.getString(3), rs.getString(4), rs.getString(5));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            ConnectionManager.close(conn, stmt, rs);
        }
        return medicinePrescription;
    }
    
    public static ArrayList<MedicinePrescription> retrieveFromScenario(String scenarioID) {
        ArrayList<MedicinePrescription> list = new ArrayList<MedicinePrescription>();
        Connection conn = null;
        PreparedStatement stmt = null;
        ResultSet rs = null;

        try {
            conn = ConnectionManager.getConnection();
            stmt = conn.prepareStatement("select * from medicine_prescription WHERE scenarioID = ?");
            stmt.setString(1, scenarioID);

            rs = stmt.executeQuery();
            while (rs.next()) {
                MedicinePrescription medicinePrescription = new MedicinePrescription(rs.getString(1), rs.getString(2), rs.getString(3), rs.getString(4), rs.getString(5));
                list.add(medicinePrescription);
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
        String query = "DELETE FROM medicine_prescription WHERE scenarioID =?";

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
