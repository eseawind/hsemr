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
public class Ward {
    private String wardID;
    private int bedNumber;
    private int availabilityStatus;

    public String getWardID() {
        return wardID;
    }

    public void setWardID(String wardID) {
        this.wardID = wardID;
    }

    public int getBedNumber() {
        return bedNumber;
    }

    public void setBedNumber(int bedNumber) {
        this.bedNumber = bedNumber;
    }

    public int getAvailabilityStatus() {
        return availabilityStatus;
    }

    public void setAvailabilityStatus(int availabilityStatus) {
        this.availabilityStatus = availabilityStatus;
    }

    public Ward(String wardID, int bedNumber, int availabilityStatus) {
        this.wardID = wardID;
        this.bedNumber = bedNumber;
        this.availabilityStatus = availabilityStatus;
    }

}
