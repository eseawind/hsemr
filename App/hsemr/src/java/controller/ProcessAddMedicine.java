/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

package controller;

import dao.MedicineDAO;
import dao.MedicinePrescriptionDAO;
import dao.PrescriptionDAO;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/**
 *
 * @author hpkhoo.2012
 */
@WebServlet(name = "ProcessAddMedicine", urlPatterns = {"/ProcessAddMedicine"})
public class ProcessAddMedicine extends HttpServlet {

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
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        PrintWriter out = response.getWriter();
        try {
            
            HttpSession session = request.getSession(false);
            String scenarioID = (String) session.getAttribute("scenarioID");
            String stateID = (String) session.getAttribute("stateID");
            String fullTextStateID= stateID.replace("ST", "State ");
            
            //retrieve values for Medicine table
            String medicineName = request.getParameter("medicineName");
            String medicineBarcode = request.getParameter("medicineBarcode");
            String route = request.getParameter("route");
            
            //retrieve values for Prescription table
            String doctorName= request.getParameter("doctorName");
            String doctorOrder = request.getParameter("doctorOrder");
            String freq = request.getParameter("frequency");
            
            //retrieve values for Frequency table
            String dosage= request.getParameter("dosage");
            
            //Testing purpose
            out.println("SC" + scenarioID + "stateID" + stateID + "full" + fullTextStateID);
            out.println("medicineName" + medicineName + "medicineBarcode" + medicineBarcode + "route" + route);
            out.println("doctorName" + doctorName + "doctorOrder" + doctorOrder + "freq" + freq + "dosage" + dosage);
            
            //for displaying medicine created message
            ArrayList<String> newlyAddedMedicine= new ArrayList<String>();
            String medicineState= medicineName + " for " + fullTextStateID;
            newlyAddedMedicine.add(medicineState);
            session.setAttribute("medicineStateDisplay", newlyAddedMedicine);
            
            //inserting into database
            
            PrescriptionDAO.insertPrescription(scenarioID,stateID,doctorName,doctorOrder,freq);
            MedicineDAO.insertMedicine(medicineBarcode, medicineName, route);
            MedicinePrescriptionDAO.insertMedicinePrescription(medicineBarcode,scenarioID,stateID,freq,dosage);
            
            response.sendRedirect("createState.jsp");

            
        } finally {
            out.close();
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
