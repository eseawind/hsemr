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
public class Medicine {
    private String medicineBarCode;
    private String medicineName;
    private String medicineDosage;
    private String routeAbbr;

    public Medicine(String medicineBarCode, String medicineName, String medicineDosage, String routeAbbr) {
        this.medicineBarCode = medicineBarCode;
        this.medicineName = medicineName;
        this.medicineDosage = medicineDosage;
        this.routeAbbr = routeAbbr;
    }

    public String getMedicineBarCode() {
        return medicineBarCode;
    }

    public void setMedicineBarCode(String medicineBarCode) {
        this.medicineBarCode = medicineBarCode;
    }

    public String getMedicineName() {
        return medicineName;
    }

    public void setMedicineName(String medicineName) {
        this.medicineName = medicineName;
    }

    public String getMedicineDosage() {
        return medicineDosage;
    }

    public void setMedicineDosage(String medicineDosage) {
        this.medicineDosage = medicineDosage;
    }

    public String getRouteAbbr() {
        return routeAbbr;
    }

    public void setRouteAbbr(String routeAbbr) {
        this.routeAbbr = routeAbbr;
    }
    
    
}
