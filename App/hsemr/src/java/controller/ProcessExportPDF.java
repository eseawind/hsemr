/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

package controller;

import com.itextpdf.text.Document;
import com.itextpdf.text.Element;
import com.itextpdf.text.Paragraph;
import com.itextpdf.text.Phrase;
import com.itextpdf.text.pdf.PdfPCell;
import com.itextpdf.text.pdf.PdfPTable;
import com.itextpdf.text.pdf.PdfWriter;
import dao.ScenarioDAO;
import entity.Note;
import java.io.*;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/**
 *
 * @author hpkhoo.2012
 */
@WebServlet(name = "ProcessExportPDF", urlPatterns = {"/ProcessExportPDF"})
public class ProcessExportPDF extends HttpServlet {

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
        PrintWriter out = response.getWriter();
        try {
            
            HttpSession session = request.getSession(false);
            ArrayList<Note> retrievedNote= (ArrayList<Note>) session.getAttribute("notesExport");
            
            //retrieve 1st note to get the practical group
            Note retrieved1Note = retrievedNote.get(0);
            String practicalGroup = retrieved1Note.getPracticalGroupID();
            String scenarioID = ScenarioDAO.retrieve(retrieved1Note.getScenarioID()).getScenarioID();
            String scenarioName= ScenarioDAO.retrieve(retrieved1Note.getScenarioID()).getScenarioName();
 
            Document document = new Document();
           
            //String fileLocation= "C:\\NPHSEMR\\" + practicalGroup + "for" + scenarioID + "Submission.pdf";
            String fileLocation= System.getProperty("user.home") + "\\desktop\\" + practicalGroup + "for" + scenarioID + "Submission.pdf";
            out.println(fileLocation);
            PdfWriter.getInstance(document, new FileOutputStream(fileLocation));
            document.open();
            
            //Header
            document.add(new Paragraph(practicalGroup + " Multidisciplinary Notes for " + scenarioName));
            document.add(new Paragraph(" "));
            
            //Table
            PdfPTable tableOfNotes = new PdfPTable(4);
            PdfPCell c1 = new PdfPCell(new Phrase("Practical Group ID"));
            c1.setHorizontalAlignment(Element.ALIGN_CENTER);
            tableOfNotes.addCell(c1);

            c1 = new PdfPCell(new Phrase("Nurse In-Charge"));
            c1.setHorizontalAlignment(Element.ALIGN_CENTER);
            tableOfNotes.addCell(c1);

            c1 = new PdfPCell(new Phrase("Multidisciplinary Notes"));
            c1.setHorizontalAlignment(Element.ALIGN_CENTER);
            tableOfNotes.addCell(c1);
            
            c1 = new PdfPCell(new Phrase("Time submited"));
            c1.setHorizontalAlignment(Element.ALIGN_CENTER);
            tableOfNotes.addCell(c1);
            
            tableOfNotes.setHeaderRows(1);
            
            DateFormat df = new SimpleDateFormat("yyyy-M-dd HH:mm:ss");
            
            //for the content in table
            for (Note note : retrievedNote){ 
                tableOfNotes.addCell(note.getPracticalGroupID());
                tableOfNotes.addCell(note.getGrpMemberNames());
                tableOfNotes.addCell(note.getMultidisciplinaryNote());
                tableOfNotes.addCell(df.format(note.getNoteDatetime()));
            }

            document.add(tableOfNotes);
   
            //close document
            document.close();
            
        // to be used to determine whether to retrieve form for the first time
           response.sendRedirect("viewSubmissionLecturer.jsp");
            session.setAttribute("success", "PDF Successfully Exported");
            
        } catch(Exception ex){
               
            HttpSession session = request.getSession(false);
            // to be used to determine whether to retrieve form for the first time
            session.setAttribute("error", "PDF Exported Failed");
            out.println(ex);
            response.sendRedirect("viewSubmissionLecturer.jsp");
            
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
