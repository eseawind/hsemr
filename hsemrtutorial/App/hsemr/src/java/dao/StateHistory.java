/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

package dao;

import java.util.Date;

/**
 *
 * @author Administrator
 */
public class StateHistory {
    private String scenarioID; 
    private String stateID; 
    private Date timeActivated;
    private String lecturerID;

    public StateHistory(String scenarioID, String stateID, Date timeActivated, String lecturerID) {
        this.scenarioID = scenarioID;
        this.stateID = stateID;
        this.timeActivated = timeActivated;
        this.lecturerID= lecturerID;
    }
    
    public String getLecturerID() {
        return scenarioID;
    }

    public void setlecturerID(String lecturerID) {
        this.lecturerID = lecturerID;
    }

    public String getScenarioID() {
        return scenarioID;
    }

    public String getStateID() {
        return stateID;
    }

    public Date getTimeActivated() {
        return timeActivated;
    }

    public void setScenarioID(String scenarioID) {
        this.scenarioID = scenarioID;
    }

    public void setStateID(String stateID) {
        this.stateID = stateID;
    }

    public void setTimeActivated(Date timeActivated) {
        this.timeActivated = timeActivated;
    }

    
}
