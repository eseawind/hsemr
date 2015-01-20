/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

package controller;

import dao.*;
import entity.*;
import java.io.IOException;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/**
 *
 * @author Administrator
 */
@WebServlet(name = "ProcessAddScenario", urlPatterns = {"/ProcessAddScenario"})
public class ProcessAddScenario extends HttpServlet {

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException { //Retrieve case information
            String scenarioName = request.getParameter("scenarioName");
            String scenarioDescription = request.getParameter("scenarioDescription");
            String admissionInfo = request.getParameter("admissionInfo");
            

            
            //retrieve the biggest bed number so we know what scenario to auto increment
            int maxBed = ScenarioDAO.retrieveMaxBedNumber();
            String scenarioID = "SC" + (maxBed + 1);

            //Retrieve patient's information
            String patientNRIC = request.getParameter("patientNRIC");
            String firstName = request.getParameter("firstName");
            String lastName = request.getParameter("lastName");
            String gender = request.getParameter("gender");
            String dobString = request.getParameter("DOB");
            String allergy = request.getParameter("allergy");
           // String wardID= (String) request.getParameter("ward");

            //Retrieve patient's default state
            String stateID0 = "ST0";
            String temperatureString0 = request.getParameter("temperature0");
            String RRString0 = request.getParameter("RR0");
            String HRString0 = request.getParameter("HR0");
            String BPSString0 = request.getParameter("BPS");
            String BPDString0 = request.getParameter("BPD");
            String SPOString0 = request.getParameter("SPO0");
            
            double temperature0 = 0;
            int RR0 = 0; 
            int HR0 = 0; 
            int BPS0 = 0;
            int BPD0 = 0; 
            int SPO0 =0;

            try{
                temperature0 = Double.parseDouble(temperatureString0);
                RR0= Integer.parseInt(RRString0);
                HR0= Integer.parseInt(HRString0);
                BPS0= Integer.parseInt(BPSString0);
                BPD0= Integer.parseInt(BPDString0);
                SPO0= Integer.parseInt(SPOString0);
            }catch(NumberFormatException e){
                //do nothing
            }
            
            String stateDescription0 = "default state"; //for the default state only
          
            int newBed = ScenarioDAO.retrieveMaxBedNumber()+1;
            
            HttpSession session = request.getSession(false);
            
            Patient retrievedPatient = PatientDAO.retrieve(patientNRIC);
            
            if(retrievedPatient != null){ // patientNRIC exists
                session.setAttribute("error", "Patient NRIC: " + retrievedPatient.getPatientNRIC() +  " exists. Patient NRIC needs to be unique.");
                
                //for repopulating the fields in createScenario.jsp 
                request.setAttribute("scenarioName",scenarioName);
                request.setAttribute("scenarioDescription", scenarioDescription);
                request.setAttribute("admissionInfo", admissionInfo);
                request.setAttribute("patientNRIC", patientNRIC);
                request.setAttribute("firstName", firstName);
                request.setAttribute("lastName", lastName);
                request.setAttribute("gender", gender);
                request.setAttribute("dobString",dobString);
                request.setAttribute("allergy",allergy);
                request.setAttribute("temperature0",temperature0);
                request.setAttribute("RR0",RRString0);
                request.setAttribute("HR0",HR0);
                request.setAttribute("BPS",BPSString0);
                request.setAttribute("BPD",BPDString0);
                request.setAttribute("SPO0",SPOString0);
                
                RequestDispatcher rd = request.getRequestDispatcher("createScenario.jsp");
                rd.forward(request, response);
            }else{
                //Adding Scenario, Patient, State, etc into the database, don't need to send them to the next page
                //*ORDER OF adding into db, THIS SEQ is important. don't shift it 
                PatientDAO.add(patientNRIC, firstName, lastName, gender, dobString);
                AllergyPatientDAO.add(patientNRIC, allergy);
                ScenarioDAO.add(scenarioID, scenarioName, scenarioDescription, 0, admissionInfo, newBed);
                StateDAO.add(stateID0, scenarioID, stateDescription0, 0, patientNRIC); //1 because default state status will be activate
                VitalDAO.add(scenarioID, temperature0, RR0, BPS0, BPD0, HR0, SPO0, "", "", "", "", "", 1);
                
                session.setAttribute("scenarioID", scenarioID);
                session.setAttribute("patientNRIC", patientNRIC);
               // session.setAttribute("success", "New scenario: " + scenarioID +  " has been created successfully!");
                response.sendRedirect("createStateBC.jsp");
                
            }
            
            
            
    }

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
