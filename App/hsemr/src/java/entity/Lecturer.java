/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

package entity;

/**
 * 
 * @author weiyi.ngow.2012
 */
public class Lecturer {
    private String lecturerID;
    private String lecturerPassword;

    public Lecturer(String lecturerID, String lecturerPassword) {
        this.lecturerID = lecturerID;
        this.lecturerPassword = lecturerPassword;
    }

    public String getLecturerID() {
        return lecturerID;
    }

    public void setLecturerID(String lecturerID) {
        this.lecturerID = lecturerID;
    }

    public String getLecturerPassword() {
        return lecturerPassword;
    }

    public void setLecturerPassword(String lecturerPassword) {
        this.lecturerPassword = lecturerPassword;
    }
}
