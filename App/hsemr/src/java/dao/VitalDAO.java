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
            stmt = conn.prepareStatement("select BPdiastolic from vital where scenarioID = ? AND BPdiastolic > 0 order by vitalDatetime asc");
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
            stmt = conn.prepareStatement("select BPsystolic from vital where scenarioID = ? AND BPsystolic > 0 order by vitalDatetime asc");
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
            stmt = conn.prepareStatement("select SPO from vital where scenarioID = ? AND SPO > 0 order by vitalDatetime asc");
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
                Vital vital = new Vital(rs.getTimestamp(1), rs.getString(2), rs.getDouble(3), rs.getInt(4), rs.getInt(5), rs.getInt(6), rs.getInt(7), rs.getInt(8), rs.getString(9), rs.getString(10), rs.getString(11), rs.getString(12), rs.getString(13), rs.getInt(14), rs.getString(15));
                vitalsList.add(vital);
            }

        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            ConnectionManager.close(conn, stmt, rs);
        }
        return vitalsList;
    }
    
 
    
    
    

    public static List<Date> retrieveLatestDateTime(String scenarioID) {
        Connection conn = null;
        PreparedStatement stmt = null;
        ResultSet rs = null;
        List<Date> returnVitalTimeList = new ArrayList<Date>();
        
     
        try {
            conn = ConnectionManager.getConnection();
            stmt = conn.prepareStatement("select vitalDatetime from vital where scenarioID = ? order by vitalDatetime asc");
            stmt.setString(1, scenarioID);

            rs = stmt.executeQuery();
            while (rs.next()) {
                Date vitalDate= rs.getTimestamp(1);
                returnVitalTimeList.add(vitalDate);
            }

        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            ConnectionManager.close(conn, stmt, rs);
        }
        return returnVitalTimeList;
    }
    
    public static List<Date> retrieveVitalTime(List<Vital> vitalsList) {
        
        List<Date> returnVitalTimeList = new ArrayList<Date>();
        
        for (Vital vital : vitalsList) {
            Date vitalDate = vital.getVitalDatetime();
            returnVitalTimeList.add(vitalDate);
        }
     
        return returnVitalTimeList;
    }
    
    
      public static void add(String scenarioID, double temperature, int RR, int BPsystolic, int BPdiastolic, int HR, int SPO, String output, String oralType, String oralAmount, String intravenousType, String intravenousAmount, int initialVital, String practicalGroupID) {
        Connection conn = null;
        PreparedStatement preparedStatement = null;
        //String query = "UPDATE vital SET vitalDatetime = ?, patientNRIC =?, temperature = ?, RR = ?, BPsystolic = ?, BPdiastolic = ?,  HR = ?, SPO = ?, intake = ?, output = ?";
        String query = "INSERT INTO vital (vitalDatetime, scenarioID, temperature, RR, BPsystolic, BPdiastolic, HR, SPO, output, oralType, oralAmount, intravenousType, intravenousAmount, initialVital, practicalGroupID) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";

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
            preparedStatement.setInt(14, initialVital);
            preparedStatement.setString(15, practicalGroupID);
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
                Vital vital = new Vital(rs.getTimestamp(1), rs.getString(2), rs.getDouble(3), rs.getInt(4), rs.getInt(5), rs.getInt(6), rs.getInt(7), rs.getInt(8), rs.getString(9), rs.getString(10), rs.getString(11), rs.getString(12), rs.getString(13), rs.getInt(14), rs.getString(15));
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
                Vital vital = new Vital(rs.getTimestamp(1), rs.getString(2), rs.getDouble(3), rs.getInt(4), rs.getInt(5), rs.getInt(6), rs.getInt(7), rs.getInt(8), rs.getString(9), rs.getString(10), rs.getString(11), rs.getString(12), rs.getString(13), rs.getInt(14), rs.getString(15));
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
                Vital vital = new Vital(rs.getTimestamp(1), rs.getString(2), rs.getDouble(3), rs.getInt(4), rs.getInt(5), rs.getInt(6), rs.getInt(7), rs.getInt(8), rs.getString(9), rs.getString(10), rs.getString(11), rs.getString(12), rs.getString(13), rs.getInt(14), rs.getString(15));
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
                Vital vital = new Vital(rs.getTimestamp(1), rs.getString(2), rs.getDouble(3), rs.getInt(4), rs.getInt(5), rs.getInt(6), rs.getInt(7), rs.getInt(8), rs.getString(9), rs.getString(10), rs.getString(11), rs.getString(12), rs.getString(13), rs.getInt(14), rs.getString(15));
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
                Vital vital = new Vital(rs.getTimestamp(1), rs.getString(2), rs.getDouble(3), rs.getInt(4), rs.getInt(5), rs.getInt(6), rs.getInt(7), rs.getInt(8), rs.getString(9), rs.getString(10), rs.getString(11), rs.getString(12), rs.getString(13), rs.getInt(14), rs.getString(15));
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
                Vital vital = new Vital(rs.getTimestamp(1), rs.getString(2), rs.getDouble(3), rs.getInt(4), rs.getInt(5), rs.getInt(6), rs.getInt(7), rs.getInt(8), rs.getString(9), rs.getString(10), rs.getString(11), rs.getString(12), rs.getString(13), rs.getInt(14), rs.getString(15));
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
    
       public static void resetVitalByPracticalGrp(String scenarioID, String practicalGroupID) {
        Connection conn = null;
        PreparedStatement preparedStatement = null;
        String query = "DELETE FROM vital WHERE scenarioID =? AND initialVital =0 AND practicalGroupID=?";

        try {
            conn = ConnectionManager.getConnection();

            preparedStatement = conn.prepareStatement(query);
            preparedStatement.setString(1, scenarioID);
            preparedStatement.setString(2, practicalGroupID);
            preparedStatement.executeUpdate();

        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            ConnectionManager.close(conn, preparedStatement, null);
        }
    }
       /*
        public static void resetVital(String scenarioID) {
        Connection conn = null;
        PreparedStatement preparedStatement = null;
        String query = "DELETE FROM vital WHERE scenarioID =? AND initialVital =0";

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
    }*/
        
    //Retrieve intake and output based on scenario     
    public static List<Vital> retrieveIntakeOutputHistoryByScenarioID(String scenarioID) {
        Connection conn = null;
        PreparedStatement stmt = null;
        ResultSet rs = null;
        List<Vital> intakeOralList = new ArrayList<Vital>();

        try {
            conn = ConnectionManager.getConnection();
            stmt = conn.prepareStatement("select * from vital where scenarioID = ? AND ((oralType <> '-' AND oralAmount <> '-') OR (intravenousType <> '-' AND intravenousAmount <> '-') OR (output <> '-')) order by vitalDatetime desc");
            stmt.setString(1, scenarioID);

            rs = stmt.executeQuery();
            while (rs.next()) {
                Vital vital = new Vital(rs.getTimestamp(1), rs.getString(2), rs.getDouble(3), rs.getInt(4), rs.getInt(5), rs.getInt(6), rs.getInt(7), rs.getInt(8), rs.getString(9), rs.getString(10), rs.getString(11), rs.getString(12), rs.getString(13), rs.getInt(14), rs.getString(15));
                intakeOralList.add(vital);
            }

        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            ConnectionManager.close(conn, stmt, rs);
        }
        return intakeOralList;
    }
    
    public static List<Vital> retrieveIntakeOutputHistoryByScenarioIDAndPracticalGroup(String scenarioID, String practicalGroup) {
        Connection conn = null;
        PreparedStatement stmt = null;
        ResultSet rs = null;
        List<Vital> intakeOralList = new ArrayList<Vital>();

        try {
            conn = ConnectionManager.getConnection();
            stmt = conn.prepareStatement("select * from vital where scenarioID = ? and practicalGroupID = ? AND ((oralType <> '-' AND oralAmount <> '-') OR (intravenousType <> '-' AND intravenousAmount <> '-') OR (output <> '-')) order by vitalDatetime desc");
            stmt.setString(1, scenarioID);
            stmt.setString(2, practicalGroup);

            rs = stmt.executeQuery();
            while (rs.next()) {
                Vital vital = new Vital(rs.getTimestamp(1), rs.getString(2), rs.getDouble(3), rs.getInt(4), rs.getInt(5), rs.getInt(6), rs.getInt(7), rs.getInt(8), rs.getString(9), rs.getString(10), rs.getString(11), rs.getString(12), rs.getString(13), rs.getInt(14), rs.getString(15));
                intakeOralList.add(vital);
            }

        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            ConnectionManager.close(conn, stmt, rs);
        }
        return intakeOralList;
    }
    
    
    // IntakeOral
    public static List<Vital> retrieveIntakeOralByScenarioID(String scenarioID) {
        Connection conn = null;
        PreparedStatement stmt = null;
        ResultSet rs = null;
        List<Vital> intakeOralList = new ArrayList<Vital>();

        try {
            conn = ConnectionManager.getConnection();
            stmt = conn.prepareStatement("select * from vital where scenarioID = ? AND oralType <> '' AND oralType <> '-' AND oralAmount <> '-' AND oralAmount <> '' order by vitalDatetime asc");
            stmt.setString(1, scenarioID);

            rs = stmt.executeQuery();
            while (rs.next()) {
                Vital vital = new Vital(rs.getTimestamp(1), rs.getString(2), rs.getDouble(3), rs.getInt(4), rs.getInt(5), rs.getInt(6), rs.getInt(7), rs.getInt(8), rs.getString(9), rs.getString(10), rs.getString(11), rs.getString(12), rs.getString(13), rs.getInt(14), rs.getString(15));
                intakeOralList.add(vital);
            }

        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            ConnectionManager.close(conn, stmt, rs);
        }
        return intakeOralList;
    }
    
       
    // IntakeIntra
    public static List<Vital> retrieveIntakeIntraByScenarioID(String scenarioID) {
        Connection conn = null;
        PreparedStatement stmt = null;
        ResultSet rs = null;
        List<Vital> intakeOralList = new ArrayList<Vital>();

        try {
            conn = ConnectionManager.getConnection();
            stmt = conn.prepareStatement("select * from vital where scenarioID = ? AND intravenousType <> '' AND intravenousType <> '-' AND intravenousAmount <> '-' AND intravenousAmount <> '' order by vitalDatetime asc");
            stmt.setString(1, scenarioID);

            rs = stmt.executeQuery();
            while (rs.next()) {
                Vital vital = new Vital(rs.getTimestamp(1), rs.getString(2), rs.getDouble(3), rs.getInt(4), rs.getInt(5), rs.getInt(6), rs.getInt(7), rs.getInt(8), rs.getString(9), rs.getString(10), rs.getString(11), rs.getString(12), rs.getString(13), rs.getInt(14), rs.getString(15));
                intakeOralList.add(vital);
            }

        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            ConnectionManager.close(conn, stmt, rs);
        }
        return intakeOralList;
    }
    
    
    // Output
    public static List<Vital> retrieveOutputByScenarioID(String scenarioID) {
        Connection conn = null;
        PreparedStatement stmt = null;
        ResultSet rs = null;
        List<Vital> intakeOralList = new ArrayList<Vital>();

        try {
            conn = ConnectionManager.getConnection();
            stmt = conn.prepareStatement("select * from vital where scenarioID = ? AND output <> '' AND output <> '-' order by vitalDatetime asc");
            stmt.setString(1, scenarioID);

            rs = stmt.executeQuery();
            while (rs.next()) {
                Vital vital = new Vital(rs.getTimestamp(1), rs.getString(2), rs.getDouble(3), rs.getInt(4), rs.getInt(5), rs.getInt(6), rs.getInt(7), rs.getInt(8), rs.getString(9), rs.getString(10), rs.getString(11), rs.getString(12), rs.getString(13), rs.getInt(14), rs.getString(15));
                intakeOralList.add(vital);
            }

        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            ConnectionManager.close(conn, stmt, rs);
        }
        return intakeOralList;
    }
    
        
    
    
    public static void resetToDefault() {
        Connection conn = null;
        PreparedStatement preparedStatement = null;
        String query = "DELETE FROM vital WHERE initialVital =0";

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
    
    public static void update(double temp, int rr, int hr, int bps, int bpd, int spo, String output, String intragastricType, String intragastricAmount, String intravenousType, String intravenousAmount, String scenarioID) {
        Connection conn = null;
        PreparedStatement preparedStatement = null;
        String query = "UPDATE vital SET temperature =?, RR = ?, HR=?, BPsystolic=?, BPdiastolic=?, SPO=?, output=?, oralType=?, oralAmount=?, intravenousType=?, intravenousAmount=?, practicalGroupID=? WHERE scenarioID =? AND initialVital=?";

        try {
            conn = ConnectionManager.getConnection();

            preparedStatement = conn.prepareStatement(query);
            preparedStatement.setDouble(1, temp);
            preparedStatement.setInt(2, rr);
            preparedStatement.setInt(3, hr);
            preparedStatement.setInt(4, bps);
            preparedStatement.setInt(5, bpd);
            preparedStatement.setInt(6, spo);
            preparedStatement.setString(7, output);
            preparedStatement.setString(8, intragastricType);
            preparedStatement.setString(9, intragastricAmount);
            preparedStatement.setString(10, intravenousType);
            preparedStatement.setString(11, intravenousAmount);
            preparedStatement.setString(12, "NA");
            preparedStatement.setString(13, scenarioID);
            preparedStatement.setInt(14, 1);
            preparedStatement.executeUpdate();

        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            ConnectionManager.close(conn, preparedStatement, null);
        }
    }
    
}
