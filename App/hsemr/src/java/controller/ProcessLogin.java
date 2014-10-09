/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

package controller;

import dao.AdminDAO;
import dao.NurseDAO;
import dao.LecturerDAO;
import entity.Lecturer;
import entity.Admin;
import entity.Nurse;
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
 * @author jocelyn.ng.2012
 */
@WebServlet(name = "ProcessLogin", urlPatterns = {"/ProcessLogin"})
public class ProcessLogin extends HttpServlet {
 
    /**
     * Processes requests for both HTTP
     * <code>GET</code> and
     * <code>POST</code> methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
                
        HttpSession session = request.getSession();
        
        String userid = null;
        String userType = request.getParameter("userType");
        userid = request.getParameter("userid");
        String password = request.getParameter("password");
        
        // If userid and password is blank
        if (userid == null || password == null) {
            request.setAttribute("error", "Invalid userid/password");
            RequestDispatcher rd = request.getRequestDispatcher("viewMainLogin.jsp");
            rd.forward(request, response);
        }
        
        if (userType.equals("admin")) {
            
            Admin admin = AdminDAO.retrieve(userid);
            
            // If such userid does not exist in DB
            if (admin == null) {
                request.setAttribute("error", "Invalid userid/password");
                RequestDispatcher rd = request.getRequestDispatcher("viewMainLogin.jsp");
                rd.forward(request, response);
            } else {
                String correctPassword = admin.getAdminPassword();
                
                // If password matches the one in DB
                if (correctPassword.equals(password)) {
                    session.setAttribute("user", userid);
                    response.sendRedirect("viewAdminHomePage.jsp");
                } else {
                    request.setAttribute("error", "Invalid userid/password");
                    RequestDispatcher rd = request.getRequestDispatcher("viewMainLogin.jsp");
                    rd.forward(request, response);
                }
            }
        } else if (userType.equals("lecturer")) {
           
            Lecturer lecturer = LecturerDAO.retrieve(userid);
            
            if (lecturer == null) {
                request.setAttribute("error", "Invalid userid/password");
                RequestDispatcher rd = request.getRequestDispatcher("viewMainLogin.jsp");
                rd.forward(request, response);
            } else {
                String correctPassword = lecturer.getLecturerPassword();
                
                // If password matches the one in DB
                if (correctPassword.equals(password)) {
                    session.setAttribute("user", userid);
                    response.sendRedirect("viewLecturerHomePage.jsp");
                } else {
                    request.setAttribute("error", "Invalid userid/password");
                    RequestDispatcher rd = request.getRequestDispatcher("viewMainLogin.jsp");
                    rd.forward(request, response);
                }
            }
            
        } else { 
            
            Nurse nurse = NurseDAO.retrieve(userid);
            
            // If no such student exist in DB
            if (nurse == null) {
                request.setAttribute("error", "Invalid userid/password");
                RequestDispatcher rd = request.getRequestDispatcher("viewMainLogin.jsp");
                rd.forward(request, response);
            } else { 
                String correctPassword = nurse.getNursePassword();

                if (correctPassword.equals(password)) {
                    session.setAttribute("user", userid);
                    response.sendRedirect("viewPatientInformation.jsp");
                } else {
                    request.setAttribute("error", "Invalid userid/password");
                    RequestDispatcher rd = request.getRequestDispatcher("viewMainLogin.jsp");
                    rd.forward(request, response);
                }
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
