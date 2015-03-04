/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

package entity;

import java.util.Date;

/**
 *
 * @author weiyi.ngow.2012
 */
public class Vital {
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
    private int initialVital;
    private String practicalGrpID;

    public Vital(Date vitalDatetime, String scenarioID, double temperature, int rr, int bpSystolic, int bpDiastolic, int hr, int spo, String output, String oralType, String oralAmount, String intravenousType, String intravenousAmount, int initialVital, String practicalGrpID) {
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
        this.initialVital = initialVital;
        this.practicalGrpID= practicalGrpID;
    }
    
    public String getPracticalGrpID() {
        return practicalGrpID;
    }

    public void setPracticalGrpID(String practicalGrpID) {
        this.practicalGrpID = practicalGrpID;
    }

    public Date getVitalDatetime() {
        return vitalDatetime;
    }

    public void setVitalDatetime(Date vitalDatetime) {
        this.vitalDatetime = vitalDatetime;
    }

    public String getScenarioID() {
        return scenarioID;
    }

    public void setScenarioID(String patientNRIC) {
        this.scenarioID = patientNRIC;
    }

    public double getTemperature() {
        return temperature;
    }

    public void setTemperature(double temperature) {
        this.temperature = temperature;
    }

    public int getRr() {
        return rr;
    }

    public void setInitialVital(int initialVital) {
        this.initialVital = initialVital;
    }

    public void setRr(int rr) {
        this.rr = rr;
    }

    public int getInitialVital() {
        return initialVital;
    }

    public int getBpSystolic() {
        return bpSystolic;
    }

    public void setBpSystolic(int bpSystolic) {
        this.bpSystolic = bpSystolic;
    }

    public int getBpDiastolic() {
        return bpDiastolic;
    }

    public void setBpDiastolic(int bpDiastolic) {
        this.bpDiastolic = bpDiastolic;
    }

    public int getHr() {
        return hr;
    }

    public void setHr(int hr) {
        this.hr = hr;
    }

    public int getSpo() {
        return spo;
    }

    public void setSpo(int spo) {
        this.spo = spo;
    }

    public String getOutput() {
        return output;
    }

    public void setOutput(String output) {
        this.output = output;
    }

    public String getOralType() {
        return oralType;
    }

    public void setOralType(String oralType) {
        this.oralType = oralType;
    }

    public String getOralAmount() {
        return oralAmount;
    }

    public void setOralAmount(String oralAmount) {
        this.oralAmount = oralAmount;
    }

    public String getIntravenousType() {
        return intravenousType;
    }

    public void setIntravenousType(String intravenousType) {
        this.intravenousType = intravenousType;
    }

    public String getIntravenousAmount() {
        return intravenousAmount;
    }

    public void setIntravenousAmount(String intravenousAmount) {
        this.intravenousAmount = intravenousAmount;
    }


}
