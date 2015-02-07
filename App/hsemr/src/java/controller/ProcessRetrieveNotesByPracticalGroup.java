/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

package controller;

import dao.NoteDAO;
import dao.ScenarioDAO;
import entity.Note;
import entity.Scenario;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
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
        String practicalGroup = request.getParameter("practicalGroup");
        String scenarioName = request.getParameter("scenarioName");
        
        Scenario scenario = ScenarioDAO.retrieveByScenarioName(scenarioName);
        String scenarioID = scenario.getScenarioID();
        ArrayList<Note> noteList = (ArrayList<Note>) NoteDAO.retrieveNotesByPraticalGrpDesc(practicalGroup, scenarioID);
        
        if(noteList == null || noteList.size() == 0){
            session.setAttribute("error", "There are no notes available for " + scenarioName + " for " + practicalGroup + ".");
            response.sendRedirect("viewSubmissionLecturer.jsp");
        }else{
            request.setAttribute("retrievedNoteList",noteList);
            //response.getWriter().println(noteList.size());
            session.setAttribute("success", "Successfully retrieved notes for " + scenarioName + " for " + practicalGroup + ".");
            RequestDispatcher rd = request.getRequestDispatcher("/viewSubmissionLecturer.jsp");
            rd.forward(request, response);
            //response.sendRedirect("viewSubmissionLecturer.jsp");
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
