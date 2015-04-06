/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

package controller;

import com.itextpdf.text.Chapter;
import com.itextpdf.text.Document;
import com.itextpdf.text.Element;
import com.itextpdf.text.Font;
import com.itextpdf.text.Paragraph;
import com.itextpdf.text.Phrase;
import com.itextpdf.text.Section;
import com.itextpdf.text.pdf.PdfPCell;
import com.itextpdf.text.pdf.PdfPTable;
import com.itextpdf.text.pdf.PdfWriter;
import dao.MedicationHistoryDAO;
import dao.NoteDAO;
import dao.ScenarioDAO;
import dao.VitalDAO;
import entity.MedicationHistory;
import entity.Note;
import entity.Vital;
import java.io.*;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.List;
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
        PrintWriter out = response.getWriter();
        try {
            
            HttpSession session = request.getSession(false);
            String practialGroupID= (String) session.getAttribute("practicalGrpID");
            String scenarioID= (String) session.getAttribute("scenarioID");
            String scenarioName= (String) session.getAttribute("scenarioName");
             
            //retrieve notelist
            ArrayList<Note> notesList = (ArrayList<Note>) NoteDAO.retrieveNotesByPraticalGrpDesc(practialGroupID, scenarioID);
            
            //retrieve medication historylist
            List<MedicationHistory> medicationHistoryList=  MedicationHistoryDAO.retrieveAllInPracticalGroup(scenarioID,practialGroupID);
            
            //retrieve vitals
            List<Vital> vitalList= VitalDAO.retrieveAllVital(scenarioID, practialGroupID);
 
            Document document = new Document();
            Font catFont = new Font(Font.FontFamily.TIMES_ROMAN, 18, Font.BOLD);
          
            String pathToRoot =  System.getenv("OPENSHIFT_DATA_DIR");
            String fileLocation = "";
            if (pathToRoot == null){
                fileLocation = getServletContext().getRealPath("") + File.separator + "public";
            } else{
                fileLocation = pathToRoot + File.separator + "public" ; 
            }
            PdfWriter.getInstance(document, new FileOutputStream(fileLocation));
            document.open();
           
            //Paragraph nextLine = new Paragraph();
             document.add(new Paragraph(" "));
            
            //title of scenario
            document.add(new Paragraph(scenarioName,catFont));
            document.add(new Paragraph(" "));
            
            //Header 1 for notes
            document.add(new Paragraph(practialGroupID + " Multidisciplinary Notes"));
            document.add(new Paragraph(" "));
          
            
            //Table 1
            PdfPTable tableOfNotes = new PdfPTable(4);
            
            PdfPCell c1 = new PdfPCell(new Phrase("Time submited"));
            c1.setHorizontalAlignment(Element.ALIGN_CENTER);
            tableOfNotes.addCell(c1);
            
            c1 = new PdfPCell(new Phrase("Practical Group ID"));
            c1.setHorizontalAlignment(Element.ALIGN_CENTER);
            tableOfNotes.addCell(c1);
            
            c1 = new PdfPCell(new Phrase("Multidisciplinary Notes"));
            c1.setHorizontalAlignment(Element.ALIGN_CENTER);
            tableOfNotes.addCell(c1);
            
            c1 = new PdfPCell(new Phrase("Nurse In-Charge"));
            c1.setHorizontalAlignment(Element.ALIGN_CENTER);
            tableOfNotes.addCell(c1);

            
            tableOfNotes.setHeaderRows(1);
            
            DateFormat df = new SimpleDateFormat("yyyy-M-dd HH:mm:ss");
            
            if(notesList == null || notesList.isEmpty()){
                document.add(new Paragraph("There are no notes submmited"));
            }else{
                //for the content in table 1
                for (Note note : notesList){ 
                    tableOfNotes.addCell(df.format(note.getNoteDatetime()));
                    tableOfNotes.addCell(note.getPracticalGroupID());
                    tableOfNotes.addCell(note.getMultidisciplinaryNote());
                     tableOfNotes.addCell(note.getGrpMemberNames());
                }
            }
            //Contents of table 1
            document.add(tableOfNotes);
            document.add(new Paragraph(" "));

            //Header 2 for medication history
            document.add(new Paragraph(practialGroupID + " Medication History"));
            document.add(new Paragraph(" "));
            
            //Table 2
            PdfPTable tableOfMedicationHistory = new PdfPTable(2);
            PdfPCell mh1 = new PdfPCell(new Phrase("Medication Datetime"));
            mh1.setHorizontalAlignment(Element.ALIGN_CENTER);
            tableOfMedicationHistory.addCell(mh1);

            mh1 = new PdfPCell(new Phrase("Medicine Adminstered"));
            mh1.setHorizontalAlignment(Element.ALIGN_CENTER);
            tableOfMedicationHistory.addCell(mh1);
        
            tableOfMedicationHistory.setHeaderRows(1);
            
            //for the content in table 2
            if(medicationHistoryList == null || medicationHistoryList.isEmpty()){
                
                document.add(new Paragraph("There are no medication history submitted"));

            }else {
                for (MedicationHistory mh : medicationHistoryList){ 
                    tableOfMedicationHistory.addCell(df.format(mh.getMedicineDatetime()));
                    tableOfMedicationHistory.addCell(mh.getMedicineBarcode());
                }
            }
            
            //Contents of table 2
            document.add(tableOfMedicationHistory);
            document.add(new Paragraph(" "));
            
            
            //Header 3 for Vitals submission
            document.add(new Paragraph(practialGroupID + " Vitals Signs"));
            document.add(new Paragraph(" "));
            
            //Table 3
            PdfPTable tableOfVitalHistory = new PdfPTable(7);
            PdfPCell v1 = new PdfPCell(new Phrase("Vitals Datetime"));
            v1.setHorizontalAlignment(Element.ALIGN_CENTER);
            tableOfVitalHistory.addCell(v1);

            v1 = new PdfPCell(new Phrase("Temp"));
            v1.setHorizontalAlignment(Element.ALIGN_CENTER);
            tableOfVitalHistory.addCell(v1);
            
            v1 = new PdfPCell(new Phrase("RR"));
            v1.setHorizontalAlignment(Element.ALIGN_CENTER);
            tableOfVitalHistory.addCell(v1);
            
            v1 = new PdfPCell(new Phrase("BP Systolic"));
            v1.setHorizontalAlignment(Element.ALIGN_CENTER);
            tableOfVitalHistory.addCell(v1);
        
            v1 = new PdfPCell(new Phrase("BP Diastolic"));
            v1.setHorizontalAlignment(Element.ALIGN_CENTER);
            tableOfVitalHistory.addCell(v1);
            
            v1 = new PdfPCell(new Phrase("HR"));
            v1.setHorizontalAlignment(Element.ALIGN_CENTER);
            tableOfVitalHistory.addCell(v1);
            
            v1 = new PdfPCell(new Phrase("SPO"));
            v1.setHorizontalAlignment(Element.ALIGN_CENTER);
            tableOfVitalHistory.addCell(v1);
            
            tableOfVitalHistory.setHeaderRows(1);
            
            //for the content in table 3
            if(vitalList == null || vitalList.isEmpty()){
                
                document.add(new Paragraph("There are no vitals signs submitted."));

            }else {
                boolean allZero = true; 
                for (Vital vitals : vitalList){ 
                   if(vitals.getTemperature()!=0.0 || vitals.getRr() != 0 || vitals.getBpSystolic() != 0 || vitals.getBpDiastolic() != 0 || vitals.getHr() != 0 || vitals.getSpo() != 0 ) {
                        allZero = false; 
                   }
               }
                if (allZero == false) {
                    for (Vital vitals : vitalList){ 
                        if(vitals.getTemperature()==0.0 && vitals.getRr() == 0 && vitals.getBpSystolic() == 0 && vitals.getBpDiastolic() == 0 && vitals.getHr() == 0 && vitals.getSpo() == 0 ) {
                            out.println("");
                        } else {
                            tableOfVitalHistory.addCell(df.format(vitals.getVitalDatetime()));
                            tableOfVitalHistory.addCell(String.valueOf(vitals.getTemperature()));
                            tableOfVitalHistory.addCell(Integer.toString(vitals.getRr()));
                            tableOfVitalHistory.addCell(Integer.toString(vitals.getBpSystolic()));
                            tableOfVitalHistory.addCell(Integer.toString(vitals.getBpDiastolic()));
                            tableOfVitalHistory.addCell(Integer.toString(vitals.getHr()));
                            tableOfVitalHistory.addCell(Integer.toString(vitals.getSpo()));
                        }
                    }
                }
            }
            
            //Contents of table 3
            document.add(tableOfVitalHistory);
            document.add(new Paragraph(" "));
            
            //Header 4 for Vitals submission
            document.add(new Paragraph(practialGroupID + " Intake & Output"));
            document.add(new Paragraph(" "));
            
            //Table 4
            PdfPTable tableOfInputOutput = new PdfPTable(6);
            PdfPCell inputOutput = new PdfPCell(new Phrase("Vitals Datetime"));
            inputOutput.setHorizontalAlignment(Element.ALIGN_CENTER);
            tableOfInputOutput.addCell(inputOutput);
            
            
            inputOutput = new PdfPCell(new Phrase("Output"));
            inputOutput.setHorizontalAlignment(Element.ALIGN_CENTER);
            tableOfInputOutput.addCell(inputOutput);
            
            
            inputOutput = new PdfPCell(new Phrase("Oral type"));
            inputOutput.setHorizontalAlignment(Element.ALIGN_CENTER);
            tableOfInputOutput.addCell(inputOutput);
            
            inputOutput = new PdfPCell(new Phrase("Oral Amount"));
            inputOutput.setHorizontalAlignment(Element.ALIGN_CENTER);
            tableOfInputOutput.addCell(inputOutput);
            
            inputOutput = new PdfPCell(new Phrase("Intravenous Type"));
            inputOutput.setHorizontalAlignment(Element.ALIGN_CENTER);
            tableOfInputOutput.addCell(inputOutput);
            
            inputOutput = new PdfPCell(new Phrase("Intravenous Amount"));
            inputOutput.setHorizontalAlignment(Element.ALIGN_CENTER);
            tableOfInputOutput.addCell(inputOutput);
            
            tableOfInputOutput.setHeaderRows(1);
            
            //for the content in table 3
            if(vitalList == null || vitalList.isEmpty()){
                document.add(new Paragraph("There are no input and output submitted."));
            }else {
                boolean allDashes = true; 
                for (Vital vitals : vitalList){ 
                   if(!vitals.getOutput().equals("-") || !vitals.getOralType().equals("-") || !vitals.getOralAmount().equals("-") || !vitals.getIntravenousType().equals("-") || !vitals.getIntravenousAmount().equals("-")) {
                        allDashes = false; 
                   }
               }
               if (allDashes == false) {
                
                   for (Vital vitals : vitalList){ 
                        if(vitals.getOutput().equals("-") && vitals.getOralType().equals("-") && vitals.getOralAmount().equals("-") && vitals.getIntravenousType().equals("-") && vitals.getIntravenousAmount().equals("-")) {
                            out.println("");
                        } else {
                            tableOfInputOutput.addCell(df.format(vitals.getVitalDatetime()));
                            tableOfInputOutput.addCell(vitals.getOutput());
                            tableOfInputOutput.addCell(vitals.getOralType());
                            tableOfInputOutput.addCell(vitals.getOralAmount());
                            tableOfInputOutput.addCell(vitals.getIntravenousType());
                            tableOfInputOutput.addCell(vitals.getIntravenousAmount());
                        }
                    }
                }
            }
            
            //Contents of table 4
            document.add(tableOfInputOutput);
            document.add(new Paragraph(" "));
            
            //close document
            document.close();
            session.setAttribute("export_path", fileLocation);

        // to be used to determine whether to retrieve form for the first time
            out.println("<html><body>");
            out.println("<script type=\"text/javascript\">");
            out.println("var popwin = window.open(\"viewExportPDF\")");
            out.println("setTimeout(function(){ popwin.close(); window.location.href='viewExportPDF;},5000)");
            out.println("</script>");
            out.println("</body></html>");
            
            response.sendRedirect("viewExportPDF");
         
        } catch(Exception ex){
               
            HttpSession session = request.getSession(false);
            // to be used to determine whether to retrieve form for the first time
            session.setAttribute("error", "PDF Exported Failed. Please try again.");
            out.println(ex);
            
        } finally {
            out.close();
        }
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
