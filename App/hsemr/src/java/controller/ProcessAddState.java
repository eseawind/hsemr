/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package controller;

import dao.StateDAO;
import entity.State;
import java.io.IOException;
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
@WebServlet(name = "ProcessAddState", urlPatterns = {"/ProcessAddState"})
public class ProcessAddState extends HttpServlet {

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
        String patientNRIC = request.getParameter("patientNRIC");
        String stateDescription = request.getParameter("stateDescription");
        
        ArrayList<State> stateList = (ArrayList<State>) StateDAO.retrieveAll(scenarioID);
        int stateNumber = stateList.size();
     
        String stateID = "ST" + stateNumber;
        
        
        
        //StateDAO.add(stateID, scenarioID, RR, BP, HR, SPO, intake, output, temperature, stateDescription, patientNRIC);
        StateDAO.add(stateID, scenarioID, stateDescription, 0, patientNRIC);
       // response.sendRedirect("createStateBC.jsp");
        
//        RequestDispatcher rd = request.getRequestDispatcher("createStateBC.jsp");
//         rd.forward(request, response);
         
         response.sendRedirect("createStateBC.jsp");

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
