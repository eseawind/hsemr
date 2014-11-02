/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package controller;

import utility.InputValidation;
import dao.AdminDAO;
import dao.LecturerDAO;
import dao.PracticalGroupDAO;
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
        String confirmPassword = request.getParameter("confirmPassword");
        String lecturerID = request.getParameter("lecturerID");

        if (userType.equals("admin")) {
            HttpSession session = request.getSession();
            session.setAttribute("type", "admin");
            if (InputValidation.validateUser(userType, userID) == false) {
                request.setAttribute("error", "User already exist");
                RequestDispatcher rd = request.getRequestDispatcher("createAccount.jsp");
                rd.forward(request, response);
            }else if (!password.equals(confirmPassword)) { 
                request.setAttribute("error", "Password mismatch");
                request.setAttribute("userID", userID);
                RequestDispatcher rd = request.getRequestDispatcher("createAccount.jsp");
                rd.forward(request, response);
            } else {
                AdminDAO.add(userID, password);
                
                session.setAttribute("successAdmin", "New account \"" + userID+  "\" has been created successfully!");
                response.sendRedirect("./viewAdminAccounts.jsp");
            }

        } else if (userType.equals("lecturer")) {
            HttpSession session = request.getSession();
            session.setAttribute("type", "lecturer");
            if (InputValidation.validateUser(userType, userID) == false) {
                request.setAttribute("error", "User already exist");
                RequestDispatcher rd = request.getRequestDispatcher("createAccount.jsp");
                rd.forward(request, response);
            }else if (!password.equals(confirmPassword)) { 
                request.setAttribute("error", "Password mismatch");
                RequestDispatcher rd = request.getRequestDispatcher("createAccount.jsp");
                 request.setAttribute("userID", userID);
                rd.forward(request, response);
            } else {
                LecturerDAO.add(userID, password);
                session.setAttribute("successLecturer", "New account \"" + userID+  "\" has been created successfully!");                LecturerDAO.add(userID, password);
                response.sendRedirect("./viewLecturerAccounts.jsp");
            }

        } else if(userType.equals("nurse")) { 
            HttpSession session = request.getSession();
            session.setAttribute("type", "nurse");
            if (InputValidation.validateUser(userType, userID) == false) {
                request.setAttribute("error", "User already exist");
                RequestDispatcher rd = request.getRequestDispatcher("createPracticalGroupAccount.jsp");
                rd.forward(request, response);
            }else if (!password.equals(confirmPassword)) { 
                request.setAttribute("error", "Password mismatch");
                request.setAttribute("userID", userID);
                RequestDispatcher rd = request.getRequestDispatcher("createPracticalGroupAccount.jsp");
                rd.forward(request, response);
            } else {
                PracticalGroupDAO.add(userID, password, lecturerID);
                session.setAttribute("successNurse", "New account \"" + userID+  "\" has been created successfully!");
                response.sendRedirect("./viewPracticalGroupAccounts.jsp");
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
