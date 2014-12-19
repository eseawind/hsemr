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
public class Prescription {
   private String scenarioID;
   private String stateID;
   private String doctorName;
   private String doctorOrder;
   private String freqAbbr;

    public Prescription(String scenarioID, String stateID, String doctorName, String doctorOrder, String freqAbbr) {
        this.scenarioID = scenarioID;
        this.stateID = stateID;
        this.doctorName = doctorName;
        this.doctorOrder = doctorOrder;
        this.freqAbbr = freqAbbr;
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

    public String getDoctorName() {
        return doctorName;
    }

    public void setDoctorName(String doctorName) {
        this.doctorName = doctorName;
    }

    public String getDoctorOrder() {
        return doctorOrder;
    }

    public void setDoctorOrder(String doctorOrder) {
        this.doctorOrder = doctorOrder;
    }

    public String getFreqAbbr() {
        return freqAbbr;
    }

    public void setFreqAbbr(String freqAbbr) {
        this.freqAbbr = freqAbbr;
    }

   
}
