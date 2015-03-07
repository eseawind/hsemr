/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package controller;

import dao.*;
import entity.PracticalGroup;
import java.io.IOException;
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

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
            /* TODO output your page here. You may use following sample code. */
           HttpSession session = request.getSession(false);
           
           String[] practicalGrpID = (String[]) request.getParameterValues("pgSelected");
           String scenarioID = (String) request.getParameter("scenarioID");
            //to know which page it comes from then redirect to the correct page
           String lecturerID = (String)session.getAttribute("lecturer");
           PracticalGroup pg= PracticalGroupDAO.retrieveByLecturer(lecturerID);
           
           if(practicalGrpID == null || practicalGrpID.length == 0){
               
                session.setAttribute("error", "You need to select at least one practical group.");
                response.sendRedirect("resetCaseLecturer.jsp");
           }else{
               
                for(String pgID : practicalGrpID){
                VitalDAO.resetVitalByPracticalGrp(scenarioID, pgID);
                StateHistoryDAO.reset(scenarioID);
                ReportDAO.resetStatus(scenarioID);
                ReportDAO.resetToInitialValues(scenarioID);
                MedicationHistoryDAO.delete(scenarioID, pgID);
                NoteDAO.reset(scenarioID,pgID);
            }
            
                response.getWriter().println(scenarioID);
                session.setAttribute("success", "You have successfully reset the case: " + scenarioID + " !");
                response.sendRedirect("resetCaseLecturer.jsp");

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
