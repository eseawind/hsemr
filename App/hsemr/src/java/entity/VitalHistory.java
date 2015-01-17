/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

package entity;

import java.util.Date;

/**
 *
 * @author Administrator
 */
public class VitalHistory {
    private Date vitalDatetime;
    private String scenarioID;
    private double temperature;
    private int rr;
    private int bpSystolic;
    private int bpDiastolic;
    private int hr;
    private int spo;
    private String output;
    private String oralType;
    private String oralAmount;
    private String intravenousType;
    private String intravenousAmount;
    private String practicalGroupID;



    public VitalHistory(Date vitalDatetime, String scenarioID, double temperature, int rr, int bpSystolic, int bpDiastolic, int hr, int spo, String output, String oralType, String oralAmount, String intravenousType, String intravenousAmount, String practicalGroupID) {
        this.vitalDatetime = vitalDatetime;
        this.scenarioID = scenarioID;
        this.temperature = temperature;
        this.rr = rr;
        this.bpSystolic = bpSystolic;
        this.bpDiastolic = bpDiastolic;
        this.hr = hr;
        this.spo = spo;
        this.output = output;
        this.oralType = oralType;
        this.oralAmount = oralAmount;
        this.intravenousType = intravenousType;
        this.intravenousAmount = intravenousAmount;
        this.practicalGroupID = practicalGroupID;
    }

    public Date getVitalDatetime() {
        return vitalDatetime;
    }
    
    public String getScenarioID() {
        return scenarioID;
    }

    public double getTemperature() {
        return temperature;
    }

    public void setVitalDatetime(Date vitalDatetime) {
        this.vitalDatetime = vitalDatetime;
    }

    public void setScenarioID(String scenarioID) {
        this.scenarioID = scenarioID;
    }

    public void setTemperature(double temperature) {
        this.temperature = temperature;
    }

    public void setRr(int rr) {
        this.rr = rr;
    }

    public void setBpSystolic(int bpSystolic) {
        this.bpSystolic = bpSystolic;
    }

    public void setBpDiastolic(int bpDiastolic) {
        this.bpDiastolic = bpDiastolic;
    }

    public void setHr(int hr) {
        this.hr = hr;
    }

    public void setSpo(int spo) {
        this.spo = spo;
    }

    public void setOutput(String output) {
        this.output = output;
    }

    public void setOralType(String oralType) {
        this.oralType = oralType;
    }

    public void setOralAmount(String oralAmount) {
        this.oralAmount = oralAmount;
    }

    public void setIntravenousType(String intravenousType) {
        this.intravenousType = intravenousType;
    }

    public void setIntravenousAmount(String intravenousAmount) {
        this.intravenousAmount = intravenousAmount;
    }

    public void setPracticalGroupID(String practicalGroupID) {
        this.practicalGroupID = practicalGroupID;
    }

    public int getRr() {
        return rr;
    }

    public int getBpSystolic() {
        return bpSystolic;
    }

    public int getBpDiastolic() {
        return bpDiastolic;
    }

    public int getHr() {
        return hr;
    }

    public int getSpo() {
        return spo;
    }

    public String getOutput() {
        return output;
    }

    public String getOralType() {
        return oralType;
    }

    public String getOralAmount() {
        return oralAmount;
    }

    public String getIntravenousType() {
        return intravenousType;
    }

    public String getIntravenousAmount() {
        return intravenousAmount;
    }

    public String getPracticalGroupID() {
        return practicalGroupID;
    }
    
    
    
}
