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
    private String medicineBarcode;
    private String medicineName;
    private String routeAbbr;

    public Medicine(String medicineBarcode, String medicineName, String routeAbbr) {
        this.medicineBarcode = medicineBarcode;
        this.medicineName = medicineName;
        this.routeAbbr = routeAbbr;
    }

    public String getMedicineBarcode() {
        return medicineBarcode;
    }

    public void setMedicineBarcode(String medicineBarcode) {
        this.medicineBarcode = medicineBarcode;
    }

    public String getMedicineName() {
        return medicineName;
    }

    public void setMedicineName(String medicineName) {
        this.medicineName = medicineName;
    }

    public String getRouteAbbr() {
        return routeAbbr;
    }

    public void setRouteAbbr(String routeAbbr) {
        this.routeAbbr = routeAbbr;
    }

    
}
