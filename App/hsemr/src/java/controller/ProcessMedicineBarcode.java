/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package controller;

import java.io.IOException;
import java.util.ArrayList;
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
      
        String isPatientVerified = (String)session.getAttribute("isPatientVerified");
        if(isPatientVerified == null || !isPatientVerified.equals("true")){
            session.setAttribute("active", "medication");
            session.setAttribute("error", "Please scan patient barcode first.");
            response.sendRedirect("viewPatientInformation.jsp");
            
        }else{
        
            String medicineBarcode = (String) request.getParameter("medicineBarcode");
            String medicineBarcodeInput = (String) request.getParameter("medicineBarcodeInput").trim();
            ArrayList<String> medicineVerifiedListReturned = (ArrayList<String>)session.getAttribute("medicineVerifiedList");


            if (medicineBarcode.equals(medicineBarcodeInput)) {//correct combination
                //MedicationHistoryDAO.add(medicineBarcode, practicalGroupID, scenarioID);

                //add new medicine to arraylist and pass back to previous page

                if(!medicineVerifiedListReturned.contains(medicineBarcode)){
                    medicineVerifiedListReturned.add(medicineBarcode);
                }

                session.setAttribute("medicineVerifiedListReturned",medicineVerifiedListReturned);

                session.setAttribute("isMedicationVerified", "true");
                session.setAttribute("isPatientVerified", "true");
                session.setAttribute("active", "medication");
                session.setAttribute("success", "Medication verified successfully!");
                String patientBarcodeInput = (String)session.getAttribute("patientBarcodeInput");
                session.setAttribute("patientBarcodeInput", patientBarcodeInput);

                response.sendRedirect("viewPatientInformation.jsp");
            } else {
                session.setAttribute("active", "medication");
                session.setAttribute("error", "Wrong medicine! Please verify and rescan.");
                session.setAttribute("isPatientVerified", "true");
                response.sendRedirect("viewPatientInformation.jsp");
            }
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
