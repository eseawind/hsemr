/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

package entity;

import java.util.Date;

/**
 * 
 * @author Jocelyn
 */
public class Document {
    
    private String consentName;
    private String consentFile;    
    private Date consentDatetime;
    private int consentStatus;

    public Document(String consentName, String consentFile, Date consentDatetime, int consentStatus) {
        this.consentName = consentName;
        this.consentFile = consentFile;
        this.consentDatetime = consentDatetime;
        this.consentStatus = consentStatus;
    }

    public String getConsentName() {
        return consentName;
    }

    public void setConsentName(String consentName) {
        this.consentName = consentName;
    }

    public String getConsentFile() {
        return consentFile;
    }

    public void setConsentFile(String consentFile) {
        this.consentFile = consentFile;
    }

    public Date getConsentDatetime() {
        return consentDatetime;
    }

    public void setConsentDatetime(Date consentDatetime) {
        this.consentDatetime = consentDatetime;
    }

    public int getConsentStatus() {
        return consentStatus;
    }

    public void setConsentStatus(int consentStatus) {
        this.consentStatus = consentStatus;
    }
    
}