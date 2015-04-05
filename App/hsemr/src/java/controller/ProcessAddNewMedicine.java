/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

package controller;

import dao.MedicineDAO;
import entity.Medicine;
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
@WebServlet(name = "ProcessAddNewMedicine", urlPatterns = {"/ProcessAddNewMedicine"})
public class ProcessAddNewMedicine extends HttpServlet {

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
        
            String newMedicineName = request.getParameter("newMedicineName");
            String newMedicineBarcode = request.getParameter("newMedicineBarcode").trim().toUpperCase();
            HttpSession session = request.getSession(false);
            
            Medicine existedMedicine = MedicineDAO.retrieve(newMedicineBarcode);
            
            MedicineDAO.insertMedicine(newMedicineBarcode, newMedicineName);
            
            String editMedicine = request.getParameter("editMedicine");
            String createMedicine = request.getParameter("createMedicine");
                
            if (existedMedicine != null) {
                session.setAttribute("error", "This medicine barcode (" + newMedicineBarcode + ") already exist. It has to be unique. Please enter a new medicine barcode.");
                request.setAttribute("medicineName", newMedicineName);
                request.setAttribute("medicineBarcode", newMedicineBarcode);
                if(createMedicine != null){
                    RequestDispatcher rd = request.getRequestDispatcher("createMedicine.jsp");
                    rd.forward(request, response);
                }
            } else {
                session.setAttribute("success", "Medicine: " + newMedicineName + " (Barcode: " + newMedicineBarcode + ") is successfully created.");
            }
            if(createMedicine != null){
                response.sendRedirect("viewMedicine.jsp");
            }else if(editMedicine != null){
                response.sendRedirect("editMedication.jsp");
            }else{
                response.sendRedirect("createMedicationBC.jsp");
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
