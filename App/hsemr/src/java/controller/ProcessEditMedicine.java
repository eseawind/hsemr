/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

package controller;

import dao.MedicineDAO;
import entity.Medicine;
import java.io.IOException;
import java.io.PrintWriter;
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
@WebServlet(name = "ProcessEditMedicine", urlPatterns = {"/ProcessEditMedicine"})
public class ProcessEditMedicine extends HttpServlet {

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
        HttpSession session = request.getSession(false);
        response.setContentType("text/html;charset=UTF-8");
        PrintWriter out = response.getWriter();
   
        String medicineBarcode = request.getParameter("medicineBarcode");
        String medicineName = request.getParameter("medicineName").trim();
        
        out.println(medicineBarcode);
        out.println(medicineName);
        
        ArrayList<Medicine> medicineList = (ArrayList<Medicine>)MedicineDAO.retrieveAll(); 
        ArrayList<String> medicineNameList = new ArrayList<String>();
        boolean medicineExist = false;
        
        for(Medicine medicine: medicineList){
            medicineNameList.add(medicine.getMedicineName());
            String medicineNameRetreived = medicine.getMedicineName();
        }
        if(medicineNameList.contains(medicineName)){
            String medicineBarcodeReturned = MedicineDAO.retrieveByMedicineName(medicineName).getMedicineBarcode();
            request.setAttribute("medicineBarcode", medicineBarcodeReturned);
            out.println(medicineBarcodeReturned);
            session.setAttribute("error",  "Please ensure that your medicine name is unique.");
            RequestDispatcher rd = request.getRequestDispatcher("./editMedicine.jsp");
            rd.forward(request, response);
            //response.sendRedirect("./editMedicine.jsp");
        }else{
            out.println(medicineNameList.contains(medicineName));
            MedicineDAO.update(medicineBarcode, medicineName);
            session.setAttribute("success",  "You have successfully changed the medicine name.");
            response.sendRedirect("./viewMedicine.jsp");
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
