/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package controller;

import dao.*;
import java.io.IOException;
import java.io.PrintWriter;
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
@WebServlet(name = "ProcessMedicineBarcode", urlPatterns = {"/ProcessMedicineBarcode"})
public class ProcessMedicineBarcode extends HttpServlet {

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
        HttpSession session = request.getSession(false);
        String practicalGroupID = (String) request.getSession().getAttribute("nurse");
        
        String medicineBarcode = (String) request.getParameter("medicineBarcode");
        String medicineBarcodeInput = (String) request.getParameter("medicineBarcodeInput");
        String scenarioID = (String) session.getAttribute("scenarioID");

        if (medicineBarcode.equals(medicineBarcodeInput)) {//correct combination
            MedicationHistoryDAO.add(medicineBarcode, practicalGroupID, scenarioID);
            session.setAttribute("success", medicineBarcodeInput + " barcode verified, you can proceed to administer. Medication has been added to historial records.");
            
            session.setAttribute("isMedicationVerified", "true");
            session.setAttribute("isPatientVerified", "true");
            session.setAttribute("active", "medication");
            response.sendRedirect("viewPatientInformation.jsp");
        } else {
            session.setAttribute("active", "medication");
            session.setAttribute("error", "Wrong medicine! Please verify and rescan.");
            session.setAttribute("isPatientVerified", "true");
            response.sendRedirect("viewPatientInformation.jsp");
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
