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
    private String status;
    private String admissionInfo;

    public Scenario(String scenarioID, String scenarioName, String scenarioDescription, String status, String admissionInfo) {
        this.scenarioID = scenarioID;
        this.scenarioName = scenarioName;
        this.scenarioDescription = scenarioDescription;
        this.status = status;
        this.admissionInfo = admissionInfo;
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

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    public String getAdmissionInfo() {
        return admissionInfo;
    }

    public void setAdmissionInfo(String admissionInfo) {
        this.admissionInfo = admissionInfo;
    }

  
    
    
         
}
