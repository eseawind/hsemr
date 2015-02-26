/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

package entity;

/**
 *
 * @author Administrator
 */
public class LecturerScenario {
    private String lectuerId; 
    private String scenarioId; 

    public LecturerScenario(String lectuerId, String scenarioId) {
        this.lectuerId = lectuerId;
        this.scenarioId = scenarioId;
    }

    public String getLectuerId() {
        return lectuerId;
    }

    public String getScenarioId() {
        return scenarioId;
    }

    public void setLectuerId(String lectuerId) {
        this.lectuerId = lectuerId;
    }

    public void setScenarioId(String scenarioId) {
        this.scenarioId = scenarioId;
    }
    
    
    
}
