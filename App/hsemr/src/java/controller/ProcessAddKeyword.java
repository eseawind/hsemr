/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package controller;

import dao.KeywordDAO;
import entity.Keyword;
import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/**
 *
 * @author Jocelyn Ng
 */
@WebServlet(name = "ProcessAddKeyword", urlPatterns = {"/ProcessAddKeyword"})
public class ProcessAddKeyword extends HttpServlet {

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
        HttpSession session = request.getSession(false);

        int keywordID = Integer.parseInt(request.getParameter("keywordID"));
        String keywordDesc = (String) request.getParameter("keywordDesc");
        String fieldsToMap = (String) request.getParameter("fieldsToMap");
        Keyword keyword= KeywordDAO.retrieveEntity(fieldsToMap);
        String entityToMap = keyword.getEntityToMap();
        
        /*if (keywordID != 0 && keywordID == 0) {
         session.setAttribute("error", "Update failed: Please update BOTH Systolic and Diastolic values.");
         response.sendRedirect("./createPDFUpload.jsp");
         } */
        if (keywordDesc == null || keywordDesc.equals(" ") || keywordDesc.equals("")) {
            session.setAttribute("error", "Please enter a valid keyword.");
            response.sendRedirect("./createPDFUpload.jsp");
        } else if (fieldsToMap == null || fieldsToMap.equals(" ") || fieldsToMap.equals("")) {
            session.setAttribute("error", "Please select a field to map the keyword.");
            response.sendRedirect("./createPDFUpload.jsp");
        } else {
            KeywordDAO.insertKeyword(keywordID, keywordDesc, fieldsToMap,entityToMap);
            session.setAttribute("success", "Added new keyword " + keywordDesc);
            response.sendRedirect("./createPDFUpload.jsp");
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
