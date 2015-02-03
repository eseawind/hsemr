/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

package controller;

import dao.MedicationHistoryDAO;
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
 * @author Administrator
 */
@WebServlet(name = "ProcessAdministerMedicine", urlPatterns = {"/ProcessAdministerMedicine"})
public class ProcessAdministerMedicine extends HttpServlet {

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
        
        ArrayList<String> medicineVerifiedList = (ArrayList<String>)session.getAttribute("medicineVerifiedListReturned");
        
        if(medicineVerifiedList == null || medicineVerifiedList.size() == 0){
            session.setAttribute("error",  "Please scan patient barcode first.");
            session.setAttribute("active", "medication");
            response.sendRedirect("viewPatientInformation.jsp");
        }else if (medicineVerifiedList != null){
            String scenarioID = (String) session.getAttribute("scenarioID");

            //loop the list and add it to MedicationHistory
            for(String medicine: medicineVerifiedList){       
                MedicationHistoryDAO.add(medicine, practicalGroupID, scenarioID);
            }
            session.setAttribute("success",  "Medication has been added to historial records. ");
            session.setAttribute("active", "medication");

            ArrayList<String> emptyArrayList = new ArrayList<String>();
         
            session.setAttribute("medicineVerifiedListReturned",emptyArrayList);
            session.setAttribute("medicineVerifiedList",emptyArrayList);
            session.removeAttribute("isMedicationVerified");
            session.removeAttribute("isPatientVerified");
            response.getWriter().println(medicineVerifiedList);
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
