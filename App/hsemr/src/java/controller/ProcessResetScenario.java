/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package controller;

import dao.*;
import entity.Scenario;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
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
 * @author gladyskhong.2012
 */
@WebServlet(name = "ProcessResetScenario", urlPatterns = {"/ProcessResetScenario"})
public class ProcessResetScenario extends HttpServlet {

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
        
            /* TODO output your page here. You may use following sample code. */

            String scenarioID = (String) request.getParameter("scenarioID");
            //to know which page it comes from then redirect to the correct page
            
            StateDAO.resetStateStatus(scenarioID);
            StateDAO.updateState("ST0", scenarioID, 1);
            StateHistoryDAO.reset(scenarioID);
            ReportDAO.resetStatus(scenarioID);
            //NoteDAO.reset(scenarioID);
            ReportDAO.resetToInitialValues(scenarioID);
            MedicationHistoryDAO.delete(scenarioID);
            VitalDAO.resetVital(scenarioID);
            
            response.getWriter().println(scenarioID);
            HttpSession session = request.getSession(false);
            session.setAttribute("success", "You have successfully reset the case: " + scenarioID + " !");
//                RequestDispatcher rd = request.getRequestDispatcher("/viewScenarioLecturer.jsp");
//                rd.forward(request, response);
           response.sendRedirect("resetCaseLecturer.jsp");
        
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
