/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package controller;

import dao.*;
import entity.*;
import java.io.IOException;
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
 * @author Administrator
 */
@WebServlet(name = "ProcessRetrieveNotesByPracticalGroup", urlPatterns = {"/ProcessRetrieveNotesByPracticalGroup"})
public class ProcessRetrieveNotesByPracticalGroup extends HttpServlet {

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
        String practicalGrpID = request.getParameter("practicalGroup");
        String scenarioName = request.getParameter("scenarioName");

        Scenario scenario = ScenarioDAO.retrieveByScenarioName(scenarioName);

        if (scenario != null) {
            String scenarioID = scenario.getScenarioID();

            //retrieve notelist
            ArrayList<Note> noteList = (ArrayList<Note>) NoteDAO.retrieveNotesByPraticalGrpDesc(practicalGrpID, scenarioID);

            //retrieve medication historylist
            List<MedicationHistory> medicationHistoryList = MedicationHistoryDAO.retrieveAllInPracticalGroup(scenarioID, practicalGrpID);

            //retrieve vitals
            List<Vital> vitalList = VitalDAO.retrieveAllVital(scenarioID, practicalGrpID);

            //setting of attribute
            request.setAttribute("noteList", noteList);
            request.setAttribute("medicationHistoryList", medicationHistoryList);
            request.setAttribute("vitalList", vitalList);
            request.setAttribute("practicalGrpID", practicalGrpID);
            request.setAttribute("scenarioName", scenarioName);
            request.setAttribute("scenarioID", scenarioID);
            request.setAttribute("isPageLoaded", "true");

            if (noteList.isEmpty() && medicationHistoryList.isEmpty() && vitalList.isEmpty()) {
                session.setAttribute("error", "There are no notes available for " + scenarioName + " for " + practicalGrpID + ".");
            } else {
                session.setAttribute("success", "Successfully retrieved notes for " + scenarioName + " for " + practicalGrpID + ".");
            }
            RequestDispatcher rd = request.getRequestDispatcher("/viewSubmissionLecturer.jsp");
            rd.forward(request, response);
        }else{
            response.getWriter().println(scenarioName);
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
