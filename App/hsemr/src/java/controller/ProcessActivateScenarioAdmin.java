/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package controller;

import dao.LecturerScenarioDAO;
import dao.ScenarioDAO;
import dao.StateDAO;
import dao.StateHistoryDAO;
import entity.LecturerScenario;
import entity.Scenario;
import java.io.IOException;
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
@WebServlet(name = "ProcessActivateScenarioAdmin", urlPatterns = {"/ProcessActivateScenarioAdmin"})
public class ProcessActivateScenarioAdmin extends HttpServlet {

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
        //To retrieve the selected id to activate or deactive
        HttpSession session = request.getSession(false);
        
        String lecturerToActivateCase = (String) request.getParameter("lecturerToActivateCase");
        
        String lecturerID = (String) session.getAttribute("lecturer");
        String status = (String) request.getParameter("status");
        String scenarioID = (String) request.getParameter("scenarioID");
        
        LecturerScenario lecScenario = LecturerScenarioDAO.retrieve(lecturerToActivateCase, scenarioID);
        
        response.getWriter().println(lecturerToActivateCase);
        response.getWriter().println(lecScenario);
        response.getWriter().println(scenarioID);
        
        if(lecScenario != null){ //it is activated
            session.setAttribute("error", "This case has been activated by: " + lecturerToActivateCase + ". Please choose another lecturer.");
            response.sendRedirect("activateScenarioAdmin.jsp");
        }else{ //not activated now, activate it
            LecturerScenarioDAO.activateScenario(lecturerToActivateCase, scenarioID);
            StateHistoryDAO.addStateHistory(scenarioID, "ST0", lecturerToActivateCase);
            session.setAttribute("success", "You have successfully activated the case: " + scenarioID + " for " + lecturerToActivateCase);
            response.sendRedirect("viewScenarioAdmin.jsp");
        }
        
        //make sure no other case are activated before activating a new case
        //prevents having more than 1 case activated 
//        if (lecScenario != null) { // deactivated
//            LecturerScenarioDAO.deactivateScenario(lecturerID, scenarioID);
//            StateHistoryDAO.clearAllHistoryByLecturer(lecturerID);
//            session.setAttribute("success", "You have successfully deactivated the case: " + scenarioID + "!");
//
//            // response.sendRedirect("viewScenarioAdmin.jsp");
//        } else {
//            Scenario activatedScenario = ScenarioDAO.retrieveScenarioActivatedByLecturer(lecturerID);
//            if (activatedScenario != null) {
//                if (!activatedScenario.getScenarioID().equals(scenarioID)) {
//                    LecturerScenarioDAO.deactivateScenario(lecturerID, scenarioID);
//                    StateHistoryDAO.clearAllHistoryByLecturer(lecturerID);
//                 
//                }
//            }
//            
//            LecturerScenarioDAO.activateScenario(lecturerID, scenarioID);
//
//            
//            StateHistoryDAO.clearAllHistoryByLecturer(lecturerID);
//            StateHistoryDAO.addStateHistory(scenarioID, "ST0", lecturerID);
//            session.setAttribute("success", "You have successfully activated the case: " + scenarioID + "!");
//            
//           //response.sendRedirect("viewScenarioAdmin.jsp");
//        }

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
