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
   private String medicineBarcode;
   private String discontinueState; 
   private String dosage;
   private String routeAbbr;
   

    public Prescription(String scenarioID, String stateID, String doctorName, String doctorOrder, String freqAbbr, String medicineBarcode, String discontinueState, String dosage, String routeAbbr) {
        this.scenarioID = scenarioID;
        this.stateID = stateID;
        this.doctorName = doctorName;
        this.doctorOrder = doctorOrder;
        this.freqAbbr = freqAbbr;
        this.medicineBarcode = medicineBarcode;
        this.discontinueState = discontinueState;
        this.dosage= dosage;
        this.routeAbbr= routeAbbr;
              
    }
    
    public String getRouteAbbr() {
        return routeAbbr;
    }

    public void setRouteAbbr(String routeAbbr) {
       this.routeAbbr= routeAbbr;
    }
    
    public String getDosage() {
        return dosage;
    }

    public void setDosage(String dosage) {
       this.dosage= dosage;
    }

    public String getDiscontinueState() {
        return discontinueState;
    }

    public void setDiscontinueState(String discontinueState) {
        this.discontinueState = discontinueState;
    }

    public String getScenarioID() {
        return scenarioID;
    }
    
    public String getMedicineBarcode() {
        return medicineBarcode;
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
    
    public void setMedicineBarcode(String medicineBarcode) {
        this.medicineBarcode = medicineBarcode;
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
