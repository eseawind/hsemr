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
public class PracticalGroupReport {
    private int reportID; 
    private String practicalGroupID; 

    public PracticalGroupReport(int reportID, String practicalGroupID) {
        this.reportID = reportID;
        this.practicalGroupID = practicalGroupID;
    }

    public int getReportID() {
        return reportID;
    }

    public String getPracticalGroupID() {
        return practicalGroupID;
    }

    public void setReportID(int reportID) {
        this.reportID = reportID;
    }

    public void setPracticalGroupID(String practicalGroupID) {
        this.practicalGroupID = practicalGroupID;
    }
    
    
    
}
