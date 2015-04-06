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
public class Patient {
    private String patientNRIC; 
    private String firstName; 
    private String lastName;
    private String gender; 
    private String dob;

    public Patient(String patientNRIC, String firstName, String lastName, String gender, String dob) {
        this.patientNRIC = patientNRIC;
        this.firstName = firstName;
        this.lastName = lastName;
        this.gender = gender;
        this.dob = dob;
    }

    public String getPatientNRIC() {
        return patientNRIC;
    }

    public void setPatientNRIC(String patientNRIC) {
        this.patientNRIC = patientNRIC;
    }

    public String getFirstName() {
        return firstName;
    }

    public void setFirstName(String firstName) {
        this.firstName = firstName;
    }

    public String getLastName() {
        return lastName;
    }

    public void setLastName(String lastName) {
        this.lastName = lastName;
    }

    public String getGender() {
        return gender;
    }

    public void setGender(String gender) {
        this.gender = gender;
    }

    public String getDob() {
        return dob;
    }

    public void setDob(String dob) {
        this.dob = dob;
    }
}
