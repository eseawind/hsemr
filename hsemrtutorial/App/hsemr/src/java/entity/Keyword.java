/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

package entity;

/**
 * 
 * @author Jocelyn Ng
 */
public class Keyword {
    
    private int keywordID;
    private String keywordDesc;
    private String fieldsToMap;
    private String entityToMap;

    public Keyword(int keywordID, String keywordDesc, String fieldsToMap, String entityToMap) {
        this.keywordID = keywordID;
        this.keywordDesc = keywordDesc;
        this.fieldsToMap = fieldsToMap;
        this.entityToMap = entityToMap;
    }
    
    public String getEntityToMap(){
        return entityToMap;
    }
    
    public void setEntityToMap(String entityToMap){
         this.entityToMap = entityToMap;
    }

    public int getKeywordID() {
        return keywordID;
    }

    public void setKeywordID(int keywordID) {
        this.keywordID = keywordID;
    }

    public String getKeywordDesc() {
        return keywordDesc;
    }

    public void setKeywordDesc(String keywordDesc) {
        this.keywordDesc = keywordDesc;
    }

    public String getFieldsToMap() {
        return fieldsToMap;
    }

    public void setFieldsToMap(String fieldsToMap) {
        this.fieldsToMap = fieldsToMap;
    }
    
    
}
