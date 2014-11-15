/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package controller;

import dao.ScenarioDAO;
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
@WebServlet(name = "ProcessEditScenario", urlPatterns = {"/ProcessEditScenario"})
public class ProcessEditScenario extends HttpServlet {

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

        String scenarioID = request.getParameter("scenarioID");
        String scenarioName = request.getParameter("scenarioName");
        String status = request.getParameter("status");
        String scenarioDescription = request.getParameter("scenarioDescription");
        String admissionInfo = request.getParameter("admissionInfo");
        
        int scenarioStatus = 0;
        
        if (status.equals("activated")) {
            Scenario activatedScenario = ScenarioDAO.retrieveActivatedScenario();
            if (activatedScenario != null) {
                if (!activatedScenario.getScenarioID().equals(scenarioID)) {
                    ScenarioDAO.updateScenarioStatus(activatedScenario.getScenarioID(), 0);
                }
            }
            
            scenarioStatus = 1;
        }
        
        ScenarioDAO.update(scenarioID, scenarioName, scenarioDescription, scenarioStatus, admissionInfo);
        
        HttpSession session = request.getSession(false);
        session.setAttribute("success", "The case has been edited successfully!");
        response.sendRedirect("./viewScenarioAdmin.jsp");
        return;
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
