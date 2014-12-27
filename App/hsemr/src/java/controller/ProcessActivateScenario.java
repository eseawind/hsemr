/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package controller;

import dao.ScenarioDAO;
import dao.StateDAO;
import entity.Scenario;
import java.io.IOException;
import java.io.PrintWriter;
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
@WebServlet(name = "ProcessActivateScenario", urlPatterns = {"/ProcessActivateScenario"})
public class ProcessActivateScenario extends HttpServlet {

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
        response.setContentType("text/html;charset=UTF-8");
        PrintWriter out = response.getWriter();
        try {
            /* TODO output your page here. You may use following sample code. */

            //To retrieve the selected id to activate or deactive
            String status = (String) request.getParameter("status");
            String scenarioID = (String) request.getParameter("scenarioID");
            //to know which page it comes from then redirect to the correct page

            //call scenarioDAO to update the status of the scenario
            if (status.equals("deactivated")) {
                ScenarioDAO.updateScenarioStatus(scenarioID, 0);
                HttpSession session = request.getSession(false);
                session.setAttribute("success", "You have successfully deactivated the case: " + scenarioID + " !");
//                RequestDispatcher rd = request.getRequestDispatcher("/viewScenarioLecturer.jsp");
//                rd.forward(request, response);
                response.sendRedirect("viewScenarioLecturer.jsp");
            } else {
                Scenario activatedScenario = ScenarioDAO.retrieveActivatedScenario();
                if (activatedScenario != null) {
                    if (!activatedScenario.getScenarioID().equals(scenarioID)) {
                        ScenarioDAO.updateScenarioStatus(activatedScenario.getScenarioID(), 0);
                        StateDAO.resetState();
                        StateDAO.updateState("ST0", scenarioID, 1);
                        
                    }
                }
                ScenarioDAO.updateScenarioStatus(scenarioID, 1);
                StateDAO.resetState();
                StateDAO.updateState("ST0", scenarioID, 1);
                HttpSession session = request.getSession(false);
                session.setAttribute("success", "You have successfully activated the case: " + scenarioID + " !");
//                RequestDispatcher rd = request.getRequestDispatcher("/viewScenarioLecturer.jsp");
//                rd.forward(request, response);
                response.sendRedirect("viewScenarioLecturer.jsp");
            }

        } finally {
            out.close();
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
