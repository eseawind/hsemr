/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package controller;

import dao.ScenarioDAO;
import dao.StateDAO;
import dao.StateHistoryDAO;
import entity.Scenario;
import entity.State;
import java.io.IOException;
import java.io.PrintWriter;
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
@WebServlet(name = "ProcessActivateState", urlPatterns = {"/ProcessActivateState"})
public class ProcessActivateState extends HttpServlet {

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

            //To retrieve the selected id to activate or deactive
            String status = (String) request.getParameter("status");
            String stateID = (String) request.getParameter("stateID");
            String scenarioID = (String) request.getParameter("scenarioID");
            //to know which page it comes from then redirect to the correct page

            //call scenarioDAO to update the status of the scenario
            if (status.equals("deactivated")) {
                StateDAO.updateState(stateID, scenarioID,0);
                HttpSession session = request.getSession(false);
                session.setAttribute("success", "You have successfully deactivated the state: " + stateID + " !");
                response.sendRedirect("editStateLecturer.jsp");
            } else {
                Scenario activatedScenario = ScenarioDAO.retrieveActivatedScenario();
                State activatedState = StateDAO.retrieveActivateState(activatedScenario.getScenarioID());
                if (activatedState != null) {
                    if (!activatedState.getStateID().equals(stateID)) {
                        StateDAO.updateState(activatedState.getStateID(), activatedScenario.getScenarioID(),0);
                     
                    }
                }
                StateDAO.updateState(stateID, scenarioID, 1);
                if (StateHistoryDAO.retrieveAll().isEmpty()){ 
                    StateHistoryDAO.addStateHistory(scenarioID, "ST0");
                }
                StateHistoryDAO.addStateHistory(scenarioID, stateID);
                HttpSession session = request.getSession(false);
                session.setAttribute("success", "You have successfully activated the state: " + stateID + " !");
                response.sendRedirect("editStateLecturer.jsp");
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
