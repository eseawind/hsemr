package utility;

import dao.AdminDAO;
import dao.LecturerDAO;
import dao.PracticalGroupDAO;
import entity.Admin;
import entity.Lecturer;
import entity.PracticalGroup;
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
            List<PracticalGroup> practicalGroups = PracticalGroupDAO.retrieveAll();
            for(PracticalGroup practicalGroup: practicalGroups) { 
                if (practicalGroup.getPracticalGroupID().equals(userID)) {
                   return false; 
                }
            }
        }
        return true;
    }
}
