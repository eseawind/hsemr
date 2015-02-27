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
    private String scenarioID; 
    private String stateDescription;
    
    private String patientNRIC; 

    public State(String stateID, String scenarioID, String stateDescription, String patientNRIC) {
        this.stateID = stateID;
        this.scenarioID = scenarioID;
        this.stateDescription = stateDescription;
        this.patientNRIC = patientNRIC;
    }

    public String getStateID() {
        return stateID;
    }

    public void setStateID(String stateID) {
        this.stateID = stateID;
    }

    public String getScenarioID() {
        return scenarioID;
    }

    public void setScenarioID(String scenarioID) {
        this.scenarioID = scenarioID;
    }

    public String getStateDescription() {
        return stateDescription;
    }

    public void setStateDescription(String stateDescription) {
        this.stateDescription = stateDescription;
    }


    public String getPatientNRIC() {
        return patientNRIC;
    }

    public void setPatientNRIC(String patientNRIC) {
        this.patientNRIC = patientNRIC;
    }

    
}
