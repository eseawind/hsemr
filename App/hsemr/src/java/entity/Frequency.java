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
public class Frequency {
    private String freqAbbr;
    private String freqDescription;

    public Frequency(String freqAbbr, String freqDescription) {
        this.freqAbbr = freqAbbr;
        this.freqDescription = freqDescription;
    }

    public String getFreqAbbr() {
        return freqAbbr;
    }

    public void setFreqAbbr(String freqAbbr) {
        this.freqAbbr = freqAbbr;
    }

    public String getFreqDescription() {
        return freqDescription;
    }

    public void setFreqDescription(String freqDescription) {
        this.freqDescription = freqDescription;
    }
}
