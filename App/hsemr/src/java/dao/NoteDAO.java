/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

package dao;

import entity.Note;
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
 * @author hpkhoo.2012
 */
public class NoteDAO {
    
    public static Note retrieve(String noteID) {
        Connection conn = null;
        PreparedStatement stmt = null;
        ResultSet rs = null;
        Note note = null;

        try {
            conn = ConnectionManager.getConnection();
            stmt = conn.prepareStatement("select * from note where noteID = ?");
            stmt.setString(1, noteID);

            rs = stmt.executeQuery();
            while (rs.next()) {
                note = new Note(rs.getInt(1), rs.getString(2), rs.getString(3), rs.getTimestamp(4), rs.getString(5), rs.getString(6));
            }

        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            ConnectionManager.close(conn, stmt, rs);
        }
        return note;
    }
    
    public static List<Note> retrieveNotesByPraticalGrp(String practicalGrp, String scenarioID) {
        Connection conn = null;
        PreparedStatement stmt = null;
        ResultSet rs = null;
        List<Note> noteList = new ArrayList<Note>();

        try {
            conn = ConnectionManager.getConnection();
            stmt = conn.prepareStatement("SELECT * FROM note where practicalGroupID= ? and scenarioID= ?");
            stmt.setString(1, practicalGrp);
            stmt.setString(2, scenarioID);
            
            rs = stmt.executeQuery();
            while (rs.next()) {
                Note newNote = new Note(rs.getInt(1), rs.getString(2), rs.getString(3), rs.getTimestamp(4), rs.getString(5), rs.getString(6));
                noteList.add(newNote);
            }

        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            ConnectionManager.close(conn, stmt, rs);
        }
        return noteList;
    }
    
     public static List<Note> retrieveNotesByPraticalGrpDesc(String practicalGrp, String scenarioID) {
        Connection conn = null;
        PreparedStatement stmt = null;
        ResultSet rs = null;
        List<Note> noteList = new ArrayList<Note>();

        try {
            conn = ConnectionManager.getConnection();
            stmt = conn.prepareStatement("SELECT * FROM note where practicalGroupID= ? and scenarioID= ? order by noteDatetime desc");
            stmt.setString(1, practicalGrp);
            stmt.setString(2, scenarioID);
            
            rs = stmt.executeQuery();
            while (rs.next()) {
                Note newNote = new Note(rs.getInt(1), rs.getString(2), rs.getString(3), rs.getTimestamp(4), rs.getString(5), rs.getString(6));
                noteList.add(newNote);
            }

        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            ConnectionManager.close(conn, stmt, rs);
        }
        return noteList;
    }
    
    public static List<Note> retrieveAll() {
        Connection conn = null;
        PreparedStatement stmt = null;
        ResultSet rs = null;
        List<Note> noteList = new ArrayList<Note>();

        try {
            conn = ConnectionManager.getConnection();
            stmt = conn.prepareStatement("SELECT * FROM note");
            rs = stmt.executeQuery();

            while (rs.next()) {
                Note newNote = new Note(rs.getInt(1), rs.getString(2), rs.getString(3), rs.getTimestamp(4), rs.getString(5), rs.getString(6));
                noteList.add(newNote);
            }

        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            ConnectionManager.close(conn, stmt, rs);
        }
        return noteList;
    }
    
    public static void insertNote(String multidisciplinaryNote, String grpMemberNames, Date noteDatetime, String practicalGrpID, String scenarioID) {
        Connection conn = null;
        PreparedStatement stmt = null;
      
//        DateFormat dateFormatter;
        
        try {
            conn = ConnectionManager.getConnection();
            stmt = conn.prepareStatement("INSERT INTO note(multidisciplinaryNote,grpMemberNames,noteDatetime,practicalGroupID,scenarioID) VALUES (?,?,?,?,?)");
          
         
            DateFormat dateFormatter;
            dateFormatter = new SimpleDateFormat("yyyy-M-dd HH:mm:ss");
            dateFormatter.setTimeZone(TimeZone.getTimeZone("Singapore"));
            stmt.setString(1, multidisciplinaryNote);
            stmt.setString(2, grpMemberNames);
            stmt.setString(3, dateFormatter.format(noteDatetime));
            stmt.setString(4, practicalGrpID);
            stmt.setString(5, scenarioID);
            stmt.executeUpdate();
       
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            ConnectionManager.close(conn, stmt);
        }
    }
    
    public static void delete(String scenarioID) {
        Connection conn = null;
        PreparedStatement preparedStatement = null;
        String query = "DELETE FROM note WHERE scenarioID =?";

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
    
    public static void deleteNoteByPracticalGroup(String practicalGroupID) {
        Connection conn = null;
        PreparedStatement preparedStatement = null;
        String query = "DELETE FROM note WHERE practicalGroupID =?";

        try {
            conn = ConnectionManager.getConnection();

            preparedStatement = conn.prepareStatement(query);
            preparedStatement.setString(1, practicalGroupID);
            preparedStatement.executeUpdate();

        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            ConnectionManager.close(conn, preparedStatement, null);
        }
    }
    public static void deleteAll (){
        Connection conn = null;
        PreparedStatement preparedStatement = null;
        String query = "DELETE FROM note";
        
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
