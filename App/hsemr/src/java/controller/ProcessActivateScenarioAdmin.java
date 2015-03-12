/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package controller;

import dao.LecturerScenarioDAO;
import dao.StateHistoryDAO;
import entity.LecturerScenario;
import java.io.IOException;
import java.util.ArrayList;
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
@WebServlet(name = "ProcessActivateScenarioAdmin", urlPatterns = {"/ProcessActivateScenarioAdmin"})
public class ProcessActivateScenarioAdmin extends HttpServlet {

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
        //To retrieve the selected id to activate or deactive
        HttpSession session = request.getSession(false);
        
        String[] lecturerToActivateCase = (String[]) request.getParameterValues("lecturerToActivateCase");
        String[] lecturerToActivateCaseWhoHasOtherCase = (String[]) request.getParameterValues("lecturerToActivateCaseWhoHasOtherCase");
       
        //add all into the arraylist of string (COMBINING THEM)
        ArrayList<String> combinedLecturerToActivate = new ArrayList<String>(); 
        
        if(lecturerToActivateCase != null){
            for(String lecturerToActivate: lecturerToActivateCase){
                combinedLecturerToActivate.add(lecturerToActivate);
            }
        }
        
        if(lecturerToActivateCaseWhoHasOtherCase != null){
            for(String lecturerToActivate: lecturerToActivateCaseWhoHasOtherCase){
                combinedLecturerToActivate.add(lecturerToActivate);
            }
        }
        
        String scenarioID = (String) request.getParameter("scenarioID");
        
        String status = (String) request.getParameter("status");
        String errorMessage = ""; 
        String successMessage = "";
        response.getWriter().println(combinedLecturerToActivate);
        
        if(combinedLecturerToActivate == null || combinedLecturerToActivate.size() == 0){
            session.setAttribute("error", "Please select at least 1 lecturer to activate the case for.");
            
            response.sendRedirect("activateScenarioAdmin.jsp");
        }else{
            response.getWriter().println(combinedLecturerToActivate.size());
            for(String lecturerToActivate: combinedLecturerToActivate){
                if(LecturerScenarioDAO.retrieveLecturer(lecturerToActivate) == null){
                    LecturerScenarioDAO.activateScenario(lecturerToActivate, scenarioID);
                    StateHistoryDAO.addStateHistory(scenarioID, "ST0", lecturerToActivate);
                }else{
                    //deactivate previous cases first
                    LecturerScenarioDAO.deactivateScenario(lecturerToActivate);
                    //activate the case now
                    LecturerScenarioDAO.activateScenario(lecturerToActivate, scenarioID);
                    StateHistoryDAO.addStateHistory(scenarioID, "ST0", lecturerToActivate);
                }
            }
            session.setAttribute("success", "Successfully activated cases for lecturers.");
            response.sendRedirect("viewScenarioAdmin.jsp");
            
        }
        
       
        
        
        
//        if(lecturerToActivateCase == null || lecturerToActivateCase.length == 0){
//            session.setAttribute("error", "Please select at least 1 lecturer to activate the case for.");
//            response.sendRedirect("activateScenarioAdmin.jsp");
//        }else{
//            for(String lecturerToActivate: lecturerToActivateCase){
//                
//                if(LecturerScenarioDAO.retrieveLecturer(lecturerToActivate) == null){
//                    
//                    LecturerScenarioDAO.activateScenario(lecturerToActivate, scenarioID);
//                    StateHistoryDAO.addStateHistory(scenarioID, "ST0", lecturerToActivate);
//                }else{
//                    LecturerScenario lecScen =  LecturerScenarioDAO.retrieveLecturer(lecturerToActivate);
//                    
//                    session.setAttribute("error", lecturerToActivate + " has activated " + lecScen.getScenarioId() + ". Please deactivate it before activating this case.");
//                    response.sendRedirect("activateScenarioAdmin.jsp");
//                    return;
//                }
//            }
//            session.setAttribute("success", "Successfully activated cases for lecturers.");
//            response.sendRedirect("viewScenarioAdmin.jsp");
//            return;
//        }
//        
//        if(lecturerToActivateCaseWhoHasOtherCase == null || lecturerToActivateCaseWhoHasOtherCase.length == 0){
//            session.setAttribute("error", "Please select at least 1 lecturer to activate the case for.");
//            response.sendRedirect("activateScenarioAdmin.jsp");
//        }else{
//            for(String lecturerToDeactivateThenActivate: lecturerToActivateCaseWhoHasOtherCase){
//                
//                if(LecturerScenarioDAO.retrieveLecturer(lecturerToDeactivateThenActivate) == null){
//                    
//                    LecturerScenarioDAO.activateScenario(lecturerToDeactivateThenActivate, scenarioID);
//                    StateHistoryDAO.addStateHistory(scenarioID, "ST0", lecturerToDeactivateThenActivate);
//                }else{
//                    LecturerScenarioDAO.deactivateScenarioForLecturer(lecturerToDeactivateThenActivate);
//                    LecturerScenarioDAO.activateScenario(lecturerToDeactivateThenActivate, scenarioID);
//                }
//            }
//            session.setAttribute("success", "Successfully activated cases for lecturers.");
//            response.sendRedirect("viewScenarioAdmin.jsp");
//            return;
//        }


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
