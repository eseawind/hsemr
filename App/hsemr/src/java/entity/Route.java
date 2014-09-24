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
public class Route {
    private String routeAbbr;
    private String routeDescription;

    public Route(String routeAbbr, String routeDescription) {
        this.routeAbbr = routeAbbr;
        this.routeDescription = routeDescription;
    }

    public String getRouteAbbr() {
        return routeAbbr;
    }

    public void setRouteAbbr(String routeAbbr) {
        this.routeAbbr = routeAbbr;
    }

    public String getRouteDescription() {
        return routeDescription;
    }

    public void setRouteDescription(String routeDescription) {
        this.routeDescription = routeDescription;
    }    
}
