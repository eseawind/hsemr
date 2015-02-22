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
            HttpSession session = request.getSession(false);
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
            String temperatureStr = request.getParameter("temperature0");
            String rrStr = request.getParameter("RR0");
            String hrStr = request.getParameter("HR0");
            String bpsStr = request.getParameter("BPS");
            String bpdStr = request.getParameter("BPD");
            String spoStr = request.getParameter("SPO0");
            String intragastricType = request.getParameter("intragastricType");
            String intragastricAmount = request.getParameter("intragastricAmount");
            String intravenousType = request.getParameter("intravenousType");
            String intravenousAmount = request.getParameter("intravenousAmount");
            String output = request.getParameter("output");
            
            if (temperatureStr.equals("")) {
                temperatureStr = "0";
            }
            if (rrStr.equals("")) {
                rrStr = "0";
            }
            if (hrStr.equals("")) {
                hrStr = "0";
            }
            if (bpsStr.equals("")) {
                bpsStr = "0";
            }
            if (bpdStr.equals("")) {
                bpdStr = "0";
            }
            if (spoStr.equals("")) {
                spoStr = "0";
            }
            
 if (intragastricType.equals("")) {
                intragastricType = "-";
            }
            if (intragastricAmount.equals("")) {
                intragastricAmount = "-";
            }
            if (intravenousType.equals("")) {
                intravenousType = "-";
            }
            if (intravenousAmount.equals("")) {
                intravenousAmount = "-";
            }
            if (output.equals("")) {
                output = "-";
            }            
            double temperature = Double.parseDouble(temperatureStr);
            int rr = Integer.parseInt(rrStr);
            int hr = Integer.parseInt(hrStr);
            int bps = Integer.parseInt(bpsStr);
            int bpd = Integer.parseInt(bpdStr);
            int spo = Integer.parseInt(spoStr);
            String newDefaultVital = request.getParameter("newDefaultVital");
                        
            AllergyPatientDAO.update(patientNRIC, allergy, retrieveNRIC);
            StateDAO.updateNRIC(patientNRIC, retrieveNRIC);
            PatientDAO.update(patientNRIC, firstName, lastName, gender, dob, retrieveNRIC);
            
            if(newDefaultVital.equals("yes")) {
                VitalDAO.add(scenarioID, temperature, rr, bps, bpd, hr, spo, output, intragastricType, intragastricAmount, intravenousType, intravenousAmount, 1);
            } else {
                VitalDAO.update(temperature, rr, hr, bps, bpd, spo, output, intragastricType, intragastricAmount, intravenousType, intravenousAmount, scenarioID);
            }
           
            ScenarioDAO.update(scenarioID, scenarioName, scenarioDescription, admissionInfo);
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
