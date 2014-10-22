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
public class Note {
    
    private int noteID;
    private String multidisciplinaryNote;
    private String grpMemberNames;
    private Date noteDatetime;
    private String practicalGroupID;
    private String scenarioID;

    public Note(int noteID, String multidisciplinaryNote, String grpMemberNames, Date noteDatetime, String practicalGroupID, String scenarioID) {
        this.noteID = noteID;
        this.multidisciplinaryNote = multidisciplinaryNote;
        this.grpMemberNames = grpMemberNames;
        this.noteDatetime = noteDatetime;
        this.practicalGroupID = practicalGroupID;
        this.scenarioID = scenarioID;
    }

    public int getNoteID() {
        return noteID;
    }

    public void setNoteID(int noteID) {
        this.noteID = noteID;
    }

    public String getMultidisciplinaryNote() {
        return multidisciplinaryNote;
    }

    public void setMultidisciplinaryNote(String multidisciplinaryNote) {
        this.multidisciplinaryNote = multidisciplinaryNote;
    }

    public String getGrpMemberNames() {
        return grpMemberNames;
    }

    public void setGrpMemberNames(String grpMemberNames) {
        this.grpMemberNames = grpMemberNames;
    }

    public Date getNoteDatetime() {
        return noteDatetime;
    }

    public void setNoteDatetime(Date noteDatetime) {
        this.noteDatetime = noteDatetime;
    }

    public String getPracticalGroupID() {
        return practicalGroupID;
    }

    public void setPracticalGroupID(String practicalGroupID) {
        this.practicalGroupID = practicalGroupID;
    }

    public String getScenarioID() {
        return scenarioID;
    }

    public void setScenarioID(String scenarioID) {
        this.scenarioID = scenarioID;
    }

    
}
