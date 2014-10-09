/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package controller;

import dao.InputValidation;
import dao.AdminDAO;
import dao.LecturerDAO;
import dao.NurseDAO;
import java.io.IOException;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/**
 *
 * @author weiyi.ngow.2012
 */
@WebServlet(name = "ProcessCreateAccount", urlPatterns = {"/ProcessCreateAccount"})
public class ProcessCreateAccount extends HttpServlet {

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

        String userType = request.getParameter("type");
        String userID = request.getParameter("userID");
        String password = request.getParameter("password");

        if (userType.equals("admin")) {
            if (InputValidation.validateUser(userType, userID) == false) {
                request.setAttribute("error", "user already exist");
                RequestDispatcher rd = request.getRequestDispatcher("createAccount.jsp");
                rd.forward(request, response);
            } else {
                AdminDAO.add(userID, password);
                HttpSession session = request.getSession();
                session.setAttribute("successAdmin", "New account \"" + userID+  "\" has been created successfully!");
                response.sendRedirect("./viewAdminAccounts.jsp");
            }

        } else if (userType.equals("lecturer")) {
            if (InputValidation.validateUser(userType, userID) == false) {
                request.setAttribute("error", "user already exist");
                RequestDispatcher rd = request.getRequestDispatcher("createAccount.jsp");
                rd.forward(request, response);
            } else {
                LecturerDAO.add(userID, password);
                HttpSession session = request.getSession();
                session.setAttribute("successLecturer", "New account \"" + userID+  "\" has been created successfully!");                LecturerDAO.add(userID, password);
                response.sendRedirect("./viewLecturerAccounts.jsp");
            }

        } else {
            if (InputValidation.validateUser(userType, userID) == false) {
                request.setAttribute("error", "user already exist");
                RequestDispatcher rd = request.getRequestDispatcher("createAccount.jsp");
                rd.forward(request, response);
            } else {
                NurseDAO.add(userID, password);
                HttpSession session = request.getSession();
                session.setAttribute("successNurse", "New account \"" + userID+  "\" has been created successfully!");
                response.sendRedirect("./viewNurseAccounts.jsp");
            }

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
