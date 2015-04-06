/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package entity;

import java.util.Date;

/**
 *
 * @author Jocelyn
 */
public class Document {

    private String consentName;
    private String consentFile;
    private Date consentDatetime;
    private int consentStatus;
    private String scenarioID;
    private String stateID;

    public Document(Date consentDatetime, String consentName, String consentFile, int consentStatus, String scenarioID, String stateID) {
        this.consentName = consentName;
        this.consentFile = consentFile;
        this.consentDatetime = consentDatetime;
        this.consentStatus = consentStatus;
        this.scenarioID = scenarioID;
        this.stateID = stateID;
    }

    public String getScenarioID() {
        return scenarioID;
    }

    public void setScenarioID(String scenarioID) {
        this.scenarioID = scenarioID;
    }

    public String getStateID() {
        return stateID;
    }

    public void setStateID(String stateID) {
        this.stateID = stateID;
    }

    public String getConsentName() {
        return consentName;
    }

    public void setConsentName(String consentName) {
        this.consentName = consentName;
    }

    public String getConsentFile() {
        return consentFile;
    }

    public void setConsentFile(String consentFile) {
        this.consentFile = consentFile;
    }

    public Date getConsentDatetime() {
        return consentDatetime;
    }

    public void setConsentDatetime(Date consentDatetime) {
        this.consentDatetime = consentDatetime;
    }

    public int getConsentStatus() {
        return consentStatus;
    }

    public void setConsentStatus(int consentStatus) {
        this.consentStatus = consentStatus;
    }

}
