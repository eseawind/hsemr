/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package controller;

import dao.*;
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
@WebServlet(name = "ProcessEditAccount", urlPatterns = {"/ProcessEditAccount"})
public class ProcessEditAccount extends HttpServlet {

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
        String lecturerID = request.getParameter("lecturerID");
        String confirmPassword = request.getParameter("confirmPassword");
        
        if (userType.equals("admin")) {
            if (password.equals(confirmPassword)) { 
                AdminDAO.update(userID, password);
                HttpSession session = request.getSession(false);
                session.setAttribute("success", "Account: " + userID + " has been edited successfully.");
                //RequestDispatcher rd = request.getRequestDispatcher("./viewAdminAccounts.jsp");
                //rd.forward(request, response);
                 response.sendRedirect("./viewAdminAccounts.jsp");
            } else { 
                request.setAttribute("error", "Password mismatch"); 
                request.setAttribute("userID", userID);
                request.setAttribute("password", password);
                RequestDispatcher rd = request.getRequestDispatcher("./editAccount.jsp");
                rd.forward(request, response);
               
            }
        } else if (userType.equals("lecturer")) {
            if (password.equals(confirmPassword)) { 
                LecturerDAO.update(userID, password);
                HttpSession session = request.getSession(false);
               session.setAttribute("success", "Account: " + userID + " has been edited successfully.");
    //            RequestDispatcher rd = request.getRequestDispatcher("./viewLecturerAccounts.jsp");
    //            rd.forward(request, response); 
            response.sendRedirect("./viewLecturerAccounts.jsp");
            }else { 
                request.setAttribute("error", "Password mismatch"); 
                request.setAttribute("userID", userID);
                request.setAttribute("password", password);
                RequestDispatcher rd = request.getRequestDispatcher("./editAccount.jsp");
                rd.forward(request, response);
               
            }
        } else { // practical group
            if ((password != null && !password.equals("")) || (confirmPassword != null && !confirmPassword.equals(""))){
                if (password.equals(confirmPassword)) { 
                    PracticalGroupDAO.update(userID, password, lecturerID);
                    HttpSession session = request.getSession(false);
                    session.setAttribute("success", "Account: " + userID + " has been edited successfully.");
                   // RequestDispatcher rd = request.getRequestDispatcher("./viewNurseAccounts.jsp");
                   // rd.forward(request, response);
                    response.sendRedirect("./viewPracticalGroupAccounts.jsp");
                }else { 
                request.setAttribute("error", "Password mismatch"); 
                request.setAttribute("userID", userID);
                request.setAttribute("password", password);
                RequestDispatcher rd = request.getRequestDispatcher("./editPracticalGroupAccount.jsp");
                rd.forward(request, response);
                }
            } else {
                PracticalGroupDAO.updateLecturer(userID, lecturerID);
                HttpSession session = request.getSession(false);
                session.setAttribute("success", "Account: " + userID + " has been edited successfully.");
               // RequestDispatcher rd = request.getRequestDispatcher("./viewNurseAccounts.jsp");
               // rd.forward(request, response);
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
