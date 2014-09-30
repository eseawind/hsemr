package dao;


import dao.AdminDAO;
import dao.LecturerDAO;
import dao.NurseDAO;
import entity.Admin;
import entity.Lecturer;
import entity.Nurse;
import java.util.List;

/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

/**
 *
 * @author weiyi.ngow.2012
 */
public class InputValidation {
    
    
    public static boolean validateUser(String type, String userID){
        
        if (type.equals("admin")) {
            List<Admin> admins = AdminDAO.retrieveAll();
            for(Admin admin: admins) { 
                if (admin.getAdminID().equals(userID)) {
                   return false; 
                }
            }
        } else if (type.equals("lecturer")) {
            List<Lecturer> lecturers = LecturerDAO.retrieveAll();
            for(Lecturer lecturer: lecturers) { 
                if (lecturer.getLecturerID().equals(userID)) {
                   return false; 
                }
            }
        } else {
            List<Nurse> nurses = NurseDAO.retrieveAll();
            for(Nurse nurse: nurses) { 
                if (nurse.getNurseID().equals(userID)) {
                   return false; 
                }
            }
        }
        return true;
    }
}
