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
public class Scenario {
    
    private String scenarioID;
    private String scenarioName;
    private String scenarioDescription;
    private int scenarioStatus;
    private String admissionNote;
    private int bedNumber;

    public Scenario(String scenarioID, String scenarioName, String scenarioDescription, int scenarioStatus, String admissionNote, int bedNumber) {
        this.scenarioID = scenarioID;
        this.scenarioName = scenarioName;
        this.scenarioDescription = scenarioDescription;
        this.scenarioStatus = scenarioStatus;
        this.admissionNote = admissionNote;
        this.bedNumber = bedNumber;
    }

    public void setBedNumber(int bedNumber) {
        this.bedNumber = bedNumber;
    }

    public int getBedNumber() {
        return bedNumber;
    }

    public String getScenarioID() {
        return scenarioID;
    }

    public void setScenarioID(String scenarioID) {
        this.scenarioID = scenarioID;
    }

    public String getScenarioName() {
        return scenarioName;
    }

    public void setScenarioName(String scenarioName) {
        this.scenarioName = scenarioName;
    }

    public String getScenarioDescription() {
        return scenarioDescription;
    }

    public void setScenarioDescription(String scenarioDescription) {
        this.scenarioDescription = scenarioDescription;
    }

    public int getScenarioStatus() {
        return scenarioStatus;
    }

    public void setScenarioStatus(int scenarioStatus) {
        this.scenarioStatus = scenarioStatus;
    }

    public String getAdmissionNote() {
        return admissionNote;
    }

    public void setAdmissionNote(String admissionNote) {
        this.admissionNote = admissionNote;
    }
         
}
