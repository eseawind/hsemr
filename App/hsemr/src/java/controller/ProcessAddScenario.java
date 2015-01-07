/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

package controller;

import dao.*;
import java.io.IOException;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;
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
            throws ServletException, IOException {//Retrieve case information
            String scenarioName = request.getParameter("scenarioName");
            String scenarioDescription = request.getParameter("scenarioDescription");
            String admissionInfo = request.getParameter("admissionInfo");
            String scenarioID = "SC" + (ScenarioDAO.retrieveAll().size() + 1);

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
            double temperature0 = Double.parseDouble(temperatureString0);
            String RRString0 = request.getParameter("RR0");
            int RR0= Integer.parseInt(RRString0);
            String HRString0 = request.getParameter("HR0");
            int HR0= Integer.parseInt(HRString0);
            String BPSString0 = request.getParameter("BPS");
            int BPS0= Integer.parseInt(BPSString0);
            String BPDString0 = request.getParameter("BPD");
            int BPD0= Integer.parseInt(BPDString0);
            String SPOString0 = request.getParameter("SPO0");
            int SPO0= Integer.parseInt(SPOString0);
 
            String stateDescription0 = "default state"; //for the default state only
            
            //to generate the number of states to fill up
            String totalNumberOfStatesString = request.getParameter("totalNumberOfStates");
            //int totalNumberOfStates = Integer.parseInt(totalNumberOfStatesString);

            //getting ward information to add new patient to a new bed
            //Ward wardInfo = WardDAO.retrieve(wardID);
            //int newBed= wardInfo.getBedNumber()+1;
            
            int newBed = ScenarioDAO.retrieveAll().size()+1;
            
            //Adding Scenario, Patient, State, etc into the database, don't need to send them to the next page
            //*ORDER OF adding into db, THIS SEQ is important. don't shift it 
            PatientDAO.add(patientNRIC, firstName, lastName, gender, dobString);
            //WardDAO.add(wardID, newBed, 1); // 1 because bed is now occupied
            AllergyPatientDAO.add(patientNRIC, allergy);
            ScenarioDAO.add(scenarioID, scenarioName, scenarioDescription, 0, admissionInfo, newBed);
            StateDAO.add(stateID0, scenarioID, stateDescription0, 0, patientNRIC); //1 because default state status will be activate
            VitalDAO.add(scenarioID, temperature0, RR0, BPS0, BPD0, HR0, SPO0, "", "", "", "", "");
           //StateDAO.add(stateID0, scenarioID, RR0, BP0, HR0, SPO0, intake0, output0, temperature0, stateDescription0, patientNRIC);
           
            HttpSession session = request.getSession(false);
            
            session.setAttribute("totalNumberOfStates", totalNumberOfStatesString);
            session.setAttribute("scenarioID", scenarioID);
            session.setAttribute("patientNRIC", patientNRIC);
            //request.setAttribute("totalNumberOfStates", totalNumberOfStatesString);
            //request.setAttribute("scenarioID", scenarioID);
            session.setAttribute("success", "New scenario: " + scenarioID +  " has been created successfully!");
            //request.setAttribute("patientNRIC", patientNRIC);
            //RequestDispatcher rd = request.getRequestDispatcher("createState.jsp");
            //response.sendRedirect("createStateWithReports.jsp");
            RequestDispatcher rd = request.getRequestDispatcher("createState.jsp");
            rd.forward(request, response);
        
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
