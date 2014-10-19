/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package controller;

import dao.ScenarioDAO;
import entity.Scenario;
import java.io.IOException;
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
        String status = (String) request.getParameter("status");
        String scenarioID = (String) request.getParameter("scenarioID");
      //make sure no other case are activated before activating a new case
        //prevents having more than 1 case activated 
        if (status.equals("deactivated")) {
            ScenarioDAO.updateScenarioStatus(scenarioID, 0);
            request.setAttribute("successMessageDeactivateCase", "You have successfully deactivated the case \"" + scenarioID + "\" !");
            RequestDispatcher rd = request.getRequestDispatcher("/viewScenarioAdmin.jsp");
            rd.forward(request, response);
        } else {
            Scenario activatedScenario = ScenarioDAO.retrieveActivatedScenario();
            if (activatedScenario != null) {
                if (!activatedScenario.getScenarioID().equals(scenarioID)) {
                    ScenarioDAO.updateScenarioStatus(activatedScenario.getScenarioID(), 0);
                }
            }
             ScenarioDAO.updateScenarioStatus(scenarioID, 1);
            request.setAttribute("successMessageActivateCase", "You have successfully activated the case \"" + scenarioID + "\" !");
            RequestDispatcher rd = request.getRequestDispatcher("/viewScenarioAdmin.jsp");
            rd.forward(request, response);
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
