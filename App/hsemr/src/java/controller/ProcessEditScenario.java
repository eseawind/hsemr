/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package controller;

import dao.AllergyPatientDAO;
import dao.PatientDAO;
import dao.ScenarioDAO;
import dao.StateDAO;
import dao.VitalDAO;
import entity.Scenario;
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
@WebServlet(name = "ProcessEditScenario", urlPatterns = {"/ProcessEditScenario"})
public class ProcessEditScenario extends HttpServlet {

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

        PrintWriter out = response.getWriter();
        try {
            /* TODO output your page here. You may use following sample code. */
            String scenarioID = request.getParameter("scenarioID");
            String scenarioName = request.getParameter("scenarioName");
            String scenarioDescription = request.getParameter("scenarioDescription");
            String admissionInfo = request.getParameter("admissionInfo");

            String retrieveNRIC = request.getParameter("retrieveNRIC");
            String patientNRIC = request.getParameter("patientNRIC");
            String firstName = request.getParameter("firstName");
            String lastName = request.getParameter("lastName");
            String dob = request.getParameter("DOB");
            String allergy = request.getParameter("allergy");
            String gender = request.getParameter("gender");
            String temperature = request.getParameter("temperature0");
            String rr = request.getParameter("RR0");
            String hr = request.getParameter("HR0");
            String bps = request.getParameter("BPS");
            String bpd = request.getParameter("BPD");
            String spo = request.getParameter("SPO0");

            AllergyPatientDAO.update(patientNRIC, allergy, retrieveNRIC);
            StateDAO.updateNRIC(patientNRIC, retrieveNRIC);
            PatientDAO.update(patientNRIC, firstName, lastName, gender, dob, retrieveNRIC);

            VitalDAO.update(temperature, rr, hr, bps, bpd, spo, scenarioID);
            ScenarioDAO.update(scenarioID, scenarioName, scenarioDescription, admissionInfo);

            HttpSession session = request.getSession(false);
            session.setAttribute("scenarioIDedit", scenarioID);
            session.setAttribute("patientNRIC", patientNRIC);
//            RequestDispatcher rd = request.getRequestDispatcher("/editState.jsp");
//            
//            rd.forward(request, response);

            response.sendRedirect("editState.jsp");
        } catch (Exception e) {
            e.printStackTrace();

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
