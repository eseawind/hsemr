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
public class State {
    private String stateID; 
    private String caseID; 
    private String RR; 
    private String BP; 
    private String HR; 
    private String SPO; 
    private String intake; 
    private String output; 
    private double temperature;
    private String stateDescription;
    private String patientNRIC; 

    public State(String stateID, String caseID, String RR, String BP, String HR, String SPO, String intake, String output, double temperature, String stateDescription, String patientNRIC) {
        this.stateID = stateID;
        this.caseID = caseID;
        this.RR = RR;
        this.BP = BP;
        this.HR = HR;
        this.SPO = SPO;
        this.intake = intake;
        this.output = output;
        this.temperature = temperature;
        this.stateDescription = stateDescription;
        this.patientNRIC = patientNRIC;
    }

    public String getStateID() {
        return stateID;
    }

    public String getCaseID() {
        return caseID;
    }

    public String getRR() {
        return RR;
    }

    public String getBP() {
        return BP;
    }

    public String getHR() {
        return HR;
    }

    public void setStateID(String stateID) {
        this.stateID = stateID;
    }

    public void setCaseID(String caseID) {
        this.caseID = caseID;
    }

    public void setRR(String RR) {
        this.RR = RR;
    }

    public void setBP(String BP) {
        this.BP = BP;
    }

    public void setHR(String HR) {
        this.HR = HR;
    }

    public void setSPO(String SPO) {
        this.SPO = SPO;
    }

    public void setIntake(String intake) {
        this.intake = intake;
    }

    public void setOutput(String output) {
        this.output = output;
    }

    public void setTemperature(double temperature) {
        this.temperature = temperature;
    }

    public void setStateDescription(String stateDescription) {
        this.stateDescription = stateDescription;
    }

    public void setPatientNRIC(String patientNRIC) {
        this.patientNRIC = patientNRIC;
    }

    public String getSPO() {
        return SPO;
    }

    public String getIntake() {
        return intake;
    }

    public String getOutput() {
        return output;
    }

    public double getTemperature() {
        return temperature;
    }

    public String getStateDescription() {
        return stateDescription;
    }

    public String getPatientNRIC() {
        return patientNRIC;
    }
    
    
    
}
