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
public class MedicineDAO {

    public static void insertMedicine(String medicineBarcode, String medicineName) {
        Connection conn = null;
        PreparedStatement stmt = null;

        try {
            conn = ConnectionManager.getConnection();
            stmt = conn.prepareStatement("INSERT INTO medicine(medicineBarcode,medicineName) VALUES (?,?)");

            stmt.setString(1, medicineBarcode);
            stmt.setString(2, medicineName);
         
            stmt.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            ConnectionManager.close(conn, stmt);
        }
    }

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
                medicine = new Medicine(rs.getString(1), rs.getString(2));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            ConnectionManager.close(conn, stmt, rs);
        }
        return medicine;
    }

    public static Medicine retrieveByMedicineName(String medicineName) {
        Connection conn = null;
        PreparedStatement stmt = null;
        ResultSet rs = null;
        Medicine medicine = null;

        try {
            conn = ConnectionManager.getConnection();
            stmt = conn.prepareStatement("select * from medicine WHERE medicineName = ?");
            stmt.setString(1, medicineName);

            rs = stmt.executeQuery();
            while (rs.next()) {
                medicine = new Medicine(rs.getString(1), rs.getString(2));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            ConnectionManager.close(conn, stmt, rs);
        }
        return medicine;
    }

    public static List<Medicine> retrieveAll() {
        List<Medicine> medicineList = new ArrayList<Medicine>();
        Connection conn = null;
        PreparedStatement stmt = null;
        ResultSet rs = null;

        try {
            conn = ConnectionManager.getConnection();
            stmt = conn.prepareStatement("select distinct * from medicine group by medicineName");

            rs = stmt.executeQuery();
            while (rs.next()) {
                Medicine medicine = new Medicine(rs.getString(1), rs.getString(2));
                medicineList.add(medicine);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            ConnectionManager.close(conn, stmt, rs);
        }
        return medicineList;
    }
/*
    public static void updateMed(String medicineBarcode, String medicineName, String route, String initialRoute) {
        Connection conn = null;
        PreparedStatement preparedStatement = null;
        String query = "UPDATE medicine SET routeAbbr=? WHERE medicineName=? AND medicineBarcode=? AND routeAbbr=?";

        try {
            conn = ConnectionManager.getConnection();

            preparedStatement = conn.prepareStatement(query);
            preparedStatement.setString(1, route);
            preparedStatement.setString(2, medicineName);
            preparedStatement.setString(3, medicineBarcode);
            preparedStatement.setString(4, initialRoute);
            preparedStatement.executeUpdate();

        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            ConnectionManager.close(conn, preparedStatement, null);
        }
    }
    */
}
