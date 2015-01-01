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
public class MedicationHistory {
    
    private Date medicineDatetime;
    private String medicineBarcode;

    public MedicationHistory(Date medicineDatetime, String medicineBarcode, String practicalGroupID, String scenarioID) {
        this.medicineDatetime = medicineDatetime;
        this.medicineBarcode = medicineBarcode;
        this.practicalGroupID = practicalGroupID;
        this.scenarioID = scenarioID;
    }
    private String practicalGroupID;
    private String scenarioID;

    public Date getMedicineDatetime() {
        return medicineDatetime;
    }

    public String getMedicineBarcode() {
        return medicineBarcode;
    }

    public String getPracticalGroupID() {
        return practicalGroupID;
    }

    public String getScenarioID() {
        return scenarioID;
    }

    public void setMedicineDatetime(Date medicineDatetime) {
        this.medicineDatetime = medicineDatetime;
    }

    public void setMedicineBarcode(String medicineBarcode) {
        this.medicineBarcode = medicineBarcode;
    }

    public void setPracticalGroupID(String practicalGroupID) {
        this.practicalGroupID = practicalGroupID;
    }

    public void setScenarioID(String scenarioID) {
        this.scenarioID = scenarioID;
    }
}
