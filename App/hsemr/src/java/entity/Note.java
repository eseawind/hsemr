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
public class Note {
    
    private int noteID;
    private String multidisciplinaryNote;
    private String tutorialGroup;
    private String grpMemberName;
    private String noteDate;

    public Note(int noteID, String multidisciplinaryNote, String tutorialGroup, String grpMemberName, String noteDate) {
        this.noteID = noteID;
        this.multidisciplinaryNote = multidisciplinaryNote;
        this.tutorialGroup = tutorialGroup;
        this.grpMemberName = grpMemberName;
        this.noteDate = noteDate;
    }

    public int getNoteID() {
        return noteID;
    }

    public void setNoteID(int noteID) {
        this.noteID = noteID;
    }

    public String getTutorialGroup() {
        return tutorialGroup;
    }

    public void setTutorialGroup(String tutorialGroup) {
        this.tutorialGroup = tutorialGroup;
    }

    public String getGrpMemberName() {
        return grpMemberName;
    }

    public void setGrpMemberName(String grpMemberName) {
        this.grpMemberName = grpMemberName;
    }

    public String getNoteDate() {
        return noteDate;
    }

    public void setNoteDate(String noteDate) {
        this.noteDate = noteDate;
    }
   
    
    
}
