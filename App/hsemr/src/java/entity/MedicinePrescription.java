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
public class MedicinePrescription {
    String medicineBarcode;
    String scenarioID; 
    String stateID; 
    String freqAbbr; 
    String dosage;

    public MedicinePrescription(String medicineBarcode, String scenarioID, String stateID, String freqAbbr, String dosage) {
        this.medicineBarcode = medicineBarcode;
        this.scenarioID = scenarioID;
        this.stateID = stateID;
        this.freqAbbr = freqAbbr;
        this.dosage = dosage;
    }

    public String getMedicineBarcode() {
        return medicineBarcode;
    }

    public String getScenarioID() {
        return scenarioID;
    }

    public String getStateID() {
        return stateID;
    }

    public String getFreqAbbr() {
        return freqAbbr;
    }

    public String getDosage() {
        return dosage;
    }

    public void setMedicineBarcode(String medicineBarcode) {
        this.medicineBarcode = medicineBarcode;
    }

    public void setScenarioID(String scenarioID) {
        this.scenarioID = scenarioID;
    }

    public void setStateID(String stateID) {
        this.stateID = stateID;
    }

    public void setFreqAbbr(String freqAbbr) {
        this.freqAbbr = freqAbbr;
    }

    public void setDosage(String dosage) {
        this.dosage = dosage;
    }
    
    
    
}
