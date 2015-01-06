/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

package dao;

import entity.Vital;
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
 * @author weiyi.ngow.2012
 */
public class VitalDAO {
    
    public static List<Integer> retrieveBPDiastolic(String scenarioID) {
        Connection conn = null;
        PreparedStatement stmt = null;
        ResultSet rs = null;
        List<Integer> bpDiastolicList= new ArrayList<Integer>();

        try {
            conn = ConnectionManager.getConnection();
            stmt = conn.prepareStatement("select BPdiastolic from vital where scenarioID = ? AND BPdiastolic > 0 order by vitalDatetime desc");
            stmt.setString(1, scenarioID);

            rs = stmt.executeQuery();
            
            while (rs.next()) {
                int bpDiastolic= rs.getInt(1);
                bpDiastolicList.add(bpDiastolic);
            }
            
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            ConnectionManager.close(conn, stmt, rs);
        }
        return bpDiastolicList;
    }
    
    public static List<Integer> retrieveBPSystolic(String scenarioID) {
        Connection conn = null;
        PreparedStatement stmt = null;
        ResultSet rs = null;
        List<Integer> bpSystolicList= new ArrayList<Integer>();

        try {
            conn = ConnectionManager.getConnection();
            stmt = conn.prepareStatement("select BPsystolic from vital where scenarioID = ? AND BPsystolic > 0 order by vitalDatetime desc");
            stmt.setString(1, scenarioID);

            rs = stmt.executeQuery();
            
            while (rs.next()) {
                int bpSystolic= rs.getInt(1);
                bpSystolicList.add(bpSystolic);
            }
            
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            ConnectionManager.close(conn, stmt, rs);
        }
        return bpSystolicList;
    }
    
    public static List<Integer> retrieveSPO(String scenarioID) {
        Connection conn = null;
        PreparedStatement stmt = null;
        ResultSet rs = null;
        List<Integer> spoList= new ArrayList<Integer>();

        try {
            conn = ConnectionManager.getConnection();
            stmt = conn.prepareStatement("select SPO from vital where scenarioID = ? AND SPO > 0 order by vitalDatetime desc");
            stmt.setString(1, scenarioID);

            rs = stmt.executeQuery();
            
            while (rs.next()) {
                int spo= rs.getInt(1);
                spoList.add(spo);
            }
            
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            ConnectionManager.close(conn, stmt, rs);
        }
        return spoList;
    }
    
    public static List<Integer> retrieveHR(String scenarioID) {
        Connection conn = null;
        PreparedStatement stmt = null;
        ResultSet rs = null;
        List<Integer> hrList= new ArrayList<Integer>();

        try {
            conn = ConnectionManager.getConnection();
            stmt = conn.prepareStatement("select HR from vital where scenarioID = ? AND HR > 0 order by vitalDatetime asc");
            stmt.setString(1, scenarioID);

            rs = stmt.executeQuery();
            
            while (rs.next()) {
                int hr= rs.getInt(1);
                hrList.add(hr);
            }
            
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            ConnectionManager.close(conn, stmt, rs);
        }
        return hrList;
    }
    
    public static List<Integer> retrieveRR(String scenarioID) {
        Connection conn = null;
        PreparedStatement stmt = null;
        ResultSet rs = null;
        List<Integer> rrList= new ArrayList<Integer>();

        try {
            conn = ConnectionManager.getConnection();
            stmt = conn.prepareStatement("select RR from vital where scenarioID = ? AND RR > 0 order by vitalDatetime asc");
            stmt.setString(1, scenarioID);

            rs = stmt.executeQuery();
            
            while (rs.next()) {
                int rr= rs.getInt(1);
                rrList.add(rr);
                
            }
            
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            ConnectionManager.close(conn, stmt, rs);
        }
        return rrList;
    }
    
     public static List<Double> retrieveTemp(String scenarioID) {
        Connection conn = null;
        PreparedStatement stmt = null;
        ResultSet rs = null;
        List<Double> tempList= new ArrayList<Double>();

        try {
            conn = ConnectionManager.getConnection();
            stmt = conn.prepareStatement("select temperature from vital where scenarioID = ? AND temperature > 0 order by vitalDatetime asc");
            stmt.setString(1, scenarioID);

            rs = stmt.executeQuery();
            
            while (rs.next()) {
                double temp= rs.getDouble(1);
                tempList.add(temp);
                
            }
            
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            ConnectionManager.close(conn, stmt, rs);
        }
        return tempList;
    }
     
    public static List<Vital> retrieveAllVitalByScenarioID(String scenarioID) {
        Connection conn = null;
        PreparedStatement stmt = null;
        ResultSet rs = null;
        List<Vital> vitalsList = new ArrayList<Vital>();

        try {
            conn = ConnectionManager.getConnection();
            stmt = conn.prepareStatement("select * from vital where scenarioID = ? order by vitalDatetime asc");
            stmt.setString(1, scenarioID);

            rs = stmt.executeQuery();
            while (rs.next()) {
                Vital vital = new Vital(rs.getTimestamp(1), rs.getString(2), rs.getDouble(3), rs.getInt(4), rs.getInt(5), rs.getInt(6), rs.getInt(7), rs.getInt(8), rs.getString(9), rs.getString(10), rs.getString(11), rs.getString(12), rs.getString(13));
                vitalsList.add(vital);
            }

        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            ConnectionManager.close(conn, stmt, rs);
        }
        return vitalsList;
    }

    public static Vital retrieveLatestDateTime(String scenarioID) {
        Connection conn = null;
        PreparedStatement stmt = null;
        ResultSet rs = null;
        Vital vital = null;

        try {
            conn = ConnectionManager.getConnection();
            stmt = conn.prepareStatement("select * from vital where scenarioID = ? order by vitalDatetime desc limit 1");
            stmt.setString(1, scenarioID);

            rs = stmt.executeQuery();
            while (rs.next()) {
                vital = new Vital(rs.getDate(1), rs.getString(2), rs.getDouble(3), rs.getInt(4), rs.getInt(5), rs.getInt(6), rs.getInt(7), rs.getInt(8), rs.getString(9), rs.getString(10), rs.getString(11), rs.getString(12), rs.getString(13));
            }

        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            ConnectionManager.close(conn, stmt, rs);
        }
        return vital;
    }
    
    public static List<Date> retrieveVitalTime(List<Vital> vitalsList) {
        
        List<Date> returnVitalTimeList = new ArrayList<Date>();
        
        for (Vital vital : vitalsList) {
            Date vitalDate = vital.getVitalDatetime();
            returnVitalTimeList.add(vitalDate);
        }
     
        return returnVitalTimeList;
    }
    
    
      public static void add(String scenarioID, double temperature, int RR, int BPsystolic, int BPdiastolic, int HR, int SPO, String output, String oralType, String oralAmount, String intravenousType, String intravenousAmount) {
        Connection conn = null;
        PreparedStatement preparedStatement = null;
        //String query = "UPDATE vital SET vitalDatetime = ?, patientNRIC =?, temperature = ?, RR = ?, BPsystolic = ?, BPdiastolic = ?,  HR = ?, SPO = ?, intake = ?, output = ?";
        String query = "INSERT INTO vital (vitalDatetime, scenarioID, temperature, RR, BPsystolic, BPdiastolic, HR, SPO, output, oralType, oralAmount, intravenousType, intravenousAmount) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";

        try {
            conn = ConnectionManager.getConnection();

            Date dateTime = new Date();
            
            DateFormat dateFormatter;
            dateFormatter = new SimpleDateFormat("yyyy-M-dd H:m:s");
            dateFormatter.setTimeZone(TimeZone.getTimeZone("Singapore"));
            preparedStatement = conn.prepareStatement(query);
            preparedStatement.setString(1, dateFormatter.format(dateTime));
            preparedStatement.setString(2, scenarioID);
            preparedStatement.setDouble(3, temperature);
            preparedStatement.setInt(4, RR);
            preparedStatement.setInt(5, BPsystolic);
            preparedStatement.setInt(6, BPdiastolic);
            preparedStatement.setInt(7, HR);
            preparedStatement.setInt(8, SPO);
            preparedStatement.setString(9, output);
            preparedStatement.setString(10, oralType);
            preparedStatement.setString(11, oralAmount);
            preparedStatement.setString(12, intravenousType);
            preparedStatement.setString(13, intravenousAmount);
            preparedStatement.executeUpdate();

        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            ConnectionManager.close(conn, preparedStatement, null);
        }
    }
      
      
      // Retrieve individual vitals' dates
      // Temperature
      public static List<Vital> retrieveTempByScenarioID(String scenarioID) {
        Connection conn = null;
        PreparedStatement stmt = null;
        ResultSet rs = null;
        List<Vital> vitalsList = new ArrayList<Vital>();

        try {
            conn = ConnectionManager.getConnection();
            stmt = conn.prepareStatement("select * from vital where scenarioID = ? AND temperature > 0 order by vitalDatetime asc");
            stmt.setString(1, scenarioID);

            rs = stmt.executeQuery();
            while (rs.next()) {
                Vital vital = new Vital(rs.getTimestamp(1), rs.getString(2), rs.getDouble(3), rs.getInt(4), rs.getInt(5), rs.getInt(6), rs.getInt(7), rs.getInt(8), rs.getString(9), rs.getString(10), rs.getString(11), rs.getString(12), rs.getString(13));
                vitalsList.add(vital);
            }

        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            ConnectionManager.close(conn, stmt, rs);
        }
        return vitalsList;
    }
    
      // RR
    public static List<Vital> retrieveRRByScenarioID(String scenarioID) {
        Connection conn = null;
        PreparedStatement stmt = null;
        ResultSet rs = null;
        List<Vital> vitalsList = new ArrayList<Vital>();

        try {
            conn = ConnectionManager.getConnection();
            stmt = conn.prepareStatement("select * from vital where scenarioID = ? AND RR > 0 order by vitalDatetime asc");
            stmt.setString(1, scenarioID);

            rs = stmt.executeQuery();
            while (rs.next()) {
                Vital vital = new Vital(rs.getTimestamp(1), rs.getString(2), rs.getDouble(3), rs.getInt(4), rs.getInt(5), rs.getInt(6), rs.getInt(7), rs.getInt(8), rs.getString(9), rs.getString(10), rs.getString(11), rs.getString(12), rs.getString(13));
                vitalsList.add(vital);
            }

        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            ConnectionManager.close(conn, stmt, rs);
        }
        return vitalsList;
    }
    
    // HR
    public static List<Vital> retrieveHRByScenarioID(String scenarioID) {
        Connection conn = null;
        PreparedStatement stmt = null;
        ResultSet rs = null;
        List<Vital> vitalsList = new ArrayList<Vital>();

        try {
            conn = ConnectionManager.getConnection();
            stmt = conn.prepareStatement("select * from vital where scenarioID = ? AND HR > 0 order by vitalDatetime asc");
            stmt.setString(1, scenarioID);

            rs = stmt.executeQuery();
            while (rs.next()) {
                Vital vital = new Vital(rs.getTimestamp(1), rs.getString(2), rs.getDouble(3), rs.getInt(4), rs.getInt(5), rs.getInt(6), rs.getInt(7), rs.getInt(8), rs.getString(9), rs.getString(10), rs.getString(11), rs.getString(12), rs.getString(13));
                vitalsList.add(vital);
            }

        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            ConnectionManager.close(conn, stmt, rs);
        }
        return vitalsList;
    }
    
    // SPO
    public static List<Vital> retrieveSPOByScenarioID(String scenarioID) {
        Connection conn = null;
        PreparedStatement stmt = null;
        ResultSet rs = null;
        List<Vital> vitalsList = new ArrayList<Vital>();

        try {
            conn = ConnectionManager.getConnection();
            stmt = conn.prepareStatement("select * from vital where scenarioID = ? AND SPO > 0 order by vitalDatetime asc");
            stmt.setString(1, scenarioID);

            rs = stmt.executeQuery();
            while (rs.next()) {
                Vital vital = new Vital(rs.getTimestamp(1), rs.getString(2), rs.getDouble(3), rs.getInt(4), rs.getInt(5), rs.getInt(6), rs.getInt(7), rs.getInt(8), rs.getString(9), rs.getString(10), rs.getString(11), rs.getString(12), rs.getString(13));
                vitalsList.add(vital);
            }

        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            ConnectionManager.close(conn, stmt, rs);
        }
        return vitalsList;
    }
    
    // BPsystolic
    public static List<Vital> retrieveBPSystolicByScenarioID(String scenarioID) {
        Connection conn = null;
        PreparedStatement stmt = null;
        ResultSet rs = null;
        List<Vital> vitalsList = new ArrayList<Vital>();

        try {
            conn = ConnectionManager.getConnection();
            stmt = conn.prepareStatement("select * from vital where scenarioID = ? AND BPsystolic > 0 order by vitalDatetime asc");
            stmt.setString(1, scenarioID);

            rs = stmt.executeQuery();
            while (rs.next()) {
                Vital vital = new Vital(rs.getTimestamp(1), rs.getString(2), rs.getDouble(3), rs.getInt(4), rs.getInt(5), rs.getInt(6), rs.getInt(7), rs.getInt(8), rs.getString(9), rs.getString(10), rs.getString(11), rs.getString(12), rs.getString(13));
                vitalsList.add(vital);
            }

        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            ConnectionManager.close(conn, stmt, rs);
        }
        return vitalsList;
    }
    
    // BPdiastolic
    public static List<Vital> retrieveBPDiastolicByScenarioID(String scenarioID) {
        Connection conn = null;
        PreparedStatement stmt = null;
        ResultSet rs = null;
        List<Vital> vitalsList = new ArrayList<Vital>();

        try {
            conn = ConnectionManager.getConnection();
            stmt = conn.prepareStatement("select * from vital where scenarioID = ? AND BPdiastolic > 0 order by vitalDatetime asc");
            stmt.setString(1, scenarioID);

            rs = stmt.executeQuery();
            while (rs.next()) {
                Vital vital = new Vital(rs.getTimestamp(1), rs.getString(2), rs.getDouble(3), rs.getInt(4), rs.getInt(5), rs.getInt(6), rs.getInt(7), rs.getInt(8), rs.getString(9), rs.getString(10), rs.getString(11), rs.getString(12), rs.getString(13));
                vitalsList.add(vital);
            }

        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            ConnectionManager.close(conn, stmt, rs);
        }
        return vitalsList;
    }
    
    public static void delete(String scenarioID) {
        Connection conn = null;
        PreparedStatement preparedStatement = null;
        String query = "DELETE FROM vital WHERE scenarioID =?";

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
