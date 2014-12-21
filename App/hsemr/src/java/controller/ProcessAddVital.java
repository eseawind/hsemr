/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

package controller;

import dao.PracticalGroupDAO;
import dao.VitalDAO;
import java.io.IOException;
import java.io.PrintWriter;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.TimeZone;
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
@WebServlet(name = "ProcessAddVital", urlPatterns = {"/ProcessAddVital"})
public class ProcessAddVital extends HttpServlet {

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
            String scenarioID = (String) request.getParameter("scenarioID");
            String oralType = (String) (request.getParameter("oralType"));
            String oralAmount = (String) (request.getParameter("oralAmount"));
            String intravenousType = (String) (request.getParameter("intravenousType"));
            String intravenousAmount = (String) (request.getParameter("intravenousAmount"));
            String output = (String) (request.getParameter("output"));
            Date dateTime= new Date();
            
            DateFormat dateFormatter;
            dateFormatter = new SimpleDateFormat("yyyy-M-dd H:m:s");
            dateFormatter.setTimeZone(TimeZone.getTimeZone("Singapore"));

            if (oralType == null || oralType.equals(" ")) {
                oralType = "-";
            }
            if (oralAmount == null || oralAmount.equals(" ")) {
                oralAmount = "-";
            }
            if (intravenousType == null || intravenousType.equals(" ")) {
                intravenousType = "-";
            }
            if (intravenousAmount == null || intravenousAmount.equals(" ")) {
                intravenousAmount = "-";
            }
            if (output == null || output.equals(" ")) {
                output = "-";
            }

            double temperature = 0.0;
            int RR = 0;
            int BPsystolic = 0;
            int BPdiastolic = 0;
            int HR = 0;
            int SPO = 0;

            try {
                temperature = Double.parseDouble(request.getParameter("temperature"));
            } catch (NumberFormatException e) {
                
            }

            try {
                RR = Integer.parseInt(request.getParameter("RR"));
            } catch (NumberFormatException e) {
                e.printStackTrace();
            }

            try {
                BPsystolic = Integer.parseInt(request.getParameter("BPsystolic"));
            } catch (NumberFormatException e) {
                e.printStackTrace();
            }
            
            try {
                BPdiastolic = Integer.parseInt(request.getParameter("BPdiastolic"));
            } catch (NumberFormatException e) {
                e.printStackTrace();
            }
            
            try {
                HR = Integer.parseInt(request.getParameter("HR"));
            } catch (NumberFormatException e) {
                e.printStackTrace();
            }
            
            try {
                SPO = Integer.parseInt(request.getParameter("SPO"));
            } catch (NumberFormatException e) {
                e.printStackTrace();
            }

            VitalDAO.add(scenarioID, temperature, RR, BPsystolic, BPdiastolic, HR, SPO, output, oralType, oralAmount, intravenousType, intravenousAmount);
            HttpSession session = request.getSession();
            session.setAttribute("active", "vital");
            session.setAttribute("success", "Vital signs have been updated!");
            response.sendRedirect("./viewPatientInformation.jsp");
            
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
