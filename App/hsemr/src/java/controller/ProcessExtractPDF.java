/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

package controller;

import com.itextpdf.text.BaseColor;
import com.itextpdf.text.DocumentException;
import com.itextpdf.text.Rectangle;
import com.itextpdf.text.pdf.PdfReader;
import com.itextpdf.text.pdf.PdfStamper;
import com.itextpdf.text.pdf.parser.PdfTextExtractor;
import com.itextpdf.text.pdf.pdfcleanup.PdfCleanUpLocation;
import com.itextpdf.text.pdf.pdfcleanup.PdfCleanUpProcessor;
import dao.KeywordDAO;
import entity.Keyword;
import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;
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
@WebServlet(name = "ProcessExtractPDF", urlPatterns = {"/ProcessExtractPDF"})
public class ProcessExtractPDF extends HttpServlet {

     /** The original PDF that will be parsed. */
        // location to store file uploaded
    private static final String DATA_DIRECTORY = "scenarioPDF";
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
      
        HttpSession session = request.getSession(false);
        String pathToRoot =  System.getenv("OPENSHIFT_DATA_DIR");
        String uploadFolder = "";
        if (pathToRoot == null){
            uploadFolder = getServletContext().getRealPath("") + File.separator + "tmp";
        }
        else{
            uploadFolder = pathToRoot + File.separator + DATA_DIRECTORY; 
        }
        
        String retrievePDF = (String) session.getAttribute("pdf_path");
        File pdfFile = (File) session.getAttribute("pdf_file");
        String name = pdfFile.getName();
        name = name.replaceAll(".pdf", "");
        String outputName = name + "output.pdf";
        
        //retrievePDF = "C:\\\\HealthLab\\\\ECS UK ARF Adult (Faculty) - remove.pdf";

         //for cleaning the pdf file
        String SRC = retrievePDF;
        String DEST = uploadFolder + File.separator + outputName;
        
        try {
            //clean up the pdf and block out information first
            manipulatePdf(SRC, DEST);
        } catch (DocumentException ex) {
            Logger.getLogger(ProcessExtractPDF.class.getName()).log(Level.SEVERE, null, ex);
        }
        
        try {
            //retrieve list of keywords to loop thru
            List<Keyword> keywordList= KeywordDAO.retrieveKeywordDesc();
                    
            PdfReader reader = new PdfReader(DEST);
            int totalPages = reader.getNumberOfPages(); 
            String scenarioDescriptionList = ""; 
            String scenarioName = "";
            boolean scenarioDescriptionReading = false;
            for (int i = 1; i <= totalPages; i++) {
                String page = PdfTextExtractor.getTextFromPage(reader, i);
                
                //print out which page
                out.println("Page " + i );
                
                //insert info into db
                String[] words = page.split("\n");
                
                for(int j = 0; j < words.length; j++){
                    String wordLine = words[j];
                    
                   for(Keyword keyword : keywordList) {
                       int indexOfKeyword = wordLine.indexOf(keyword.getKeywordDesc() + ":");
                       
                        String attributeName = keyword.getFieldsToMap();
                       String entityName = keyword.getEntityToMap(); 
                       
                       if (indexOfKeyword >= 0 ) {
                         
                          if(attributeName.equals("scenarioName")) {
                             // out.println("KEYWORD=" + keyword.getKeywordDesc() +"LENGTH=" + keyword.getKeywordDesc().length() );
                              int lengthOfKeyword = keyword.getKeywordDesc().length() + 1;
                              scenarioName = wordLine.substring(lengthOfKeyword);
                              
                          }
                       } else if (attributeName.equals("scenarioDescription")) { 
                            int storeLineNumberOfKeyword = j; 
                           if (scenarioDescriptionReading == true) {
                               int indexOfEndingKeyword = wordLine.indexOf("History//Information:");
                               for(int k = storeLineNumberOfKeyword; k < words.length; k++){
                                    String wordLine2 = words[k];
                                    if(indexOfEndingKeyword < 0) {
                                        scenarioDescriptionList += wordLine2; 
                                    } else { 
                                        scenarioDescriptionReading = false; 
                                       
                                    }
                              }
                          } else { 
                              scenarioDescriptionReading = true; 
                           }
                       }
                   } 
                  out.println("<br><br>" + wordLine);
                }
            }
                out.println("scenarioName = " + scenarioName);
                out.println("scenarioDescription = " + scenarioDescriptionList);
            

        } catch (IOException e) {
            out.println(e);
        }
    }
    
    //creating a gray block to block out information
    
   
    public void manipulatePdf(String src, String dest) throws IOException, DocumentException {
        PdfReader reader = new PdfReader(src);
        PdfStamper stamper = new PdfStamper(reader, new FileOutputStream(dest));
        List<PdfCleanUpLocation> cleanUpLocations = new ArrayList<PdfCleanUpLocation>();
        //block in first page
        //cleanUpLocations.add(new PdfCleanUpLocation(1, new Rectangle(97f, 750f, 430f, 450f), BaseColor.BLACK));
        cleanUpLocations.add(new PdfCleanUpLocation(1, new Rectangle(97f, 470f, 430f, 3000f), BaseColor.BLACK));
        PdfCleanUpProcessor cleaner = new PdfCleanUpProcessor(cleanUpLocations, stamper);
        cleaner.cleanUp() ;
        
        int totalPages = reader.getNumberOfPages(); 
        
        //loop from 3rd page onwards, 2 confirm not used
        for(int i = 2; i <= totalPages; i++){
            //cleanUpLocations.add(new PdfCleanUpLocation(i, new Rectangle(95f, 330f, 550f, 3000f), BaseColor.BLACK));
            cleanUpLocations.add(new PdfCleanUpLocation(i, new Rectangle(95f, 330f, 550f, 3000f), BaseColor.BLACK));
            cleaner = new PdfCleanUpProcessor(cleanUpLocations, stamper);
            cleaner.cleanUp();
        }
 
        stamper.close();
        reader.close();
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
