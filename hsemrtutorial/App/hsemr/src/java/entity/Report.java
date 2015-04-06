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
    private int reportID; 
    private Date reportDatetime;
    private String reportName;
    private String reportFile;
    private String scenarioID;
    private String stateID;
    private int initialReport;

    public Report(int reportID, Date reportDatetime, String reportName, String reportFile, String scenarioID, String stateID, int initialReport) {
        this.reportID = reportID; 
        this.reportDatetime = reportDatetime;
        this.reportName = reportName;
        this.reportFile = reportFile;
        this.scenarioID = scenarioID;
        this.stateID = stateID;
        this.initialReport = initialReport;
    }

    public int getReportID() {
        return reportID;
    }

    public void setReportID(int reportID) {
        this.reportID = reportID;
    }
    
    public Date getReportDatetime() {
        return reportDatetime;
    }

    public void setReportDatetime(Date reportDatetime) {
        this.reportDatetime = reportDatetime;
    }

    public void setInitialReport(int initialReport) {
        this.initialReport = initialReport;
    }

    public int getInitialReport() {
        return initialReport;
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