/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package controller;

import dao.PrescriptionDAO;
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
 * @author gladyskhong.2012
 */
@WebServlet(name = "ProcessEditMedication", urlPatterns = {"/ProcessEditMedication"})
public class ProcessEditMedication extends HttpServlet {

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
        if(session.getAttribute("admin") == null){
            response.sendRedirect("viewMainLogin.jsp");
        }else{

            try {

                String scenarioID = (String) session.getAttribute("scenarioID");

                int prescriptionListSize = Integer.parseInt(request.getParameter("prescriptionListSize"));

                for (int i = 0; i < prescriptionListSize; i++) {
                    String medBarcodeNumber = "medBarcode" + i;
                    String routeNumber = "route" + i;
                    String frequencyNumber = "frequency" + i;
                    String doctorNameNumber = "doctorName" + i;
                    String doctorOrderNumber = "doctorOrder" + i;
                    String dosageNumber = "dosage" + i;
                    String medicineNameNumber = "medicineName" + i;
                    String routeDefault = "routeDefault" + i;
                    String frequencyDefault = "frequencyDefault" + i;
                    String stateIDNumber = "stateID" + i;
                    //String docOrderDefault= "docOrderDefault" + i;

                    String stateID = request.getParameter(stateIDNumber);

                    String medicineName = request.getParameter(medicineNameNumber);
                    String route = request.getParameter(routeNumber);
                    if (route == null) {
                        route = request.getParameter(routeDefault);
                    }
                    String frequency = request.getParameter(frequencyNumber);
                    if (frequency == null) {
                        frequency = request.getParameter(frequencyDefault);
                    }

                    //String doctorOrder = request.getParameter(doctorOrderNumber);
                   /* if(doctorOrder == null ){
                        doctorOrder= request.getParameter(docOrderDefault);
                    }*/
                    String doctorName = request.getParameter(doctorNameNumber);
                    String doctorOrder = request.getParameter(doctorOrderNumber);
                    String dosage = request.getParameter(dosageNumber);
                    String medBarcode = request.getParameter(medBarcodeNumber);

                    String initialRoute = request.getParameter(routeDefault);
                  //  String initalOrder= request.getParameter(docOrderDefault);
                    String initialFreq= request.getParameter(frequencyDefault);

                  //  MedicinePrescriptionDAO.updateMedPres(frequency, dosage, medBarcode, scenarioID, stateID);
                  //  MedicineDAO.updateMed(medBarcode, medicineName, route, initialRoute); // route can change

                    PrescriptionDAO.updatePres(doctorName, doctorOrder, frequency, scenarioID, stateID, medBarcode, route, dosage, initialRoute, initialFreq);

                }
                response.sendRedirect("editReportDocument.jsp");

            } catch (Exception e) {
                e.printStackTrace();
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
