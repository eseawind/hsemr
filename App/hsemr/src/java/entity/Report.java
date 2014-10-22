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
public class Report {
    private Date reportDatetime;
    private String reportName;
    private String reportFile;
    private int dispatchStatus; 
    private String scenarioID;
    private String stateID;

    public Report(Date reportDatetime, String reportName, String reportFile, int dispatchStatus, String scenarioID, String stateID) {
        this.reportDatetime = reportDatetime;
        this.reportName = reportName;
        this.reportFile = reportFile;
        this.dispatchStatus = dispatchStatus;
        this.scenarioID = scenarioID;
        this.stateID = stateID;
    }

    public Date getReportDatetime() {
        return reportDatetime;
    }

    public void setReportDatetime(Date reportDatetime) {
        this.reportDatetime = reportDatetime;
    }

    public String getReportName() {
        return reportName;
    }

    public void setReportName(String reportName) {
        this.reportName = reportName;
    }

    public String getReportFile() {
        return reportFile;
    }

    public void setReportFile(String reportFile) {
        this.reportFile = reportFile;
    }

    public int getDispatchStatus() {
        return dispatchStatus;
    }

    public void setDispatchStatus(int dispatchStatus) {
        this.dispatchStatus = dispatchStatus;
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

}