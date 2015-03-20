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
import dao.*;
import entity.Keyword;
import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;
import java.util.regex.Matcher;
import java.util.regex.Pattern;
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
            String contentsOfCase = "";
            //String[] wordsLine = new String[10000];
      
             for (int i = 1; i <= totalPages; i++) {
                String page = PdfTextExtractor.getTextFromPage(reader, i);
                contentsOfCase += page;
                
                /*
                //line by line code
               String[] wordsLine= page.split("\n");
              
                for(String words : wordsLine){
                 out.println("<br>" + words);
                }
                */
             }
             
             
            //out.println(contentsOfCase);

           
           /////////////////////////////////
           //// SUBSTRING METHOD        ////
           ///////////////////////////////// 
            
            
            /////////////////////////////////
           //// ONLY PAGE 1             ////
           /////////////////////////////////  
            
             String pageOne = PdfTextExtractor.getTextFromPage(reader, 1);
     
            //1. Initialise the keywords
            String keywordScenarioName = "";
            String keywordScenarioDesc = "";
            String keywordAdmissionInformation = "";
            String keywordDoctorOrder = ""; 
            
            //2. Get keywords from database
            List<Keyword> keywordsForScenarioName = (List<Keyword>) KeywordDAO.retrieveKeywordsByFields("scenarioName");
            List<Keyword> keywordsForScenarioDescription = (List<Keyword>) KeywordDAO.retrieveKeywordsByFields("scenarioDescription");
            List<Keyword> keywordsForAdmissionInformation = (List<Keyword>) KeywordDAO.retrieveKeywordsByFields("admissionNote");
            List<Keyword> keywordsForDoctorOrder = (List<Keyword>) KeywordDAO.retrieveKeywordsByFields("doctorOrder");
            
            //3. Finding the appropriate keywords. 
            // Loop all the keywords to find the respective keywords that exists in the chunk of test
            
            //Scenario Name Keywords
            for(Keyword keywordsScenarioName : keywordsForScenarioName){
                keywordScenarioName = keywordsScenarioName.getKeywordDesc();
                
                //out.println(keywordsScenarioName.getKeywordDesc());
                
                if(pageOne.contains(keywordScenarioName)){
                    //if found, this is the START of the substring for scenarioName
                    break;
                }
            }
            
            
            //Scenario Description Keywords
            for(Keyword keywordsScenarioDesc : keywordsForScenarioDescription){
                keywordScenarioDesc = keywordsScenarioDesc.getKeywordDesc();
                
                if(pageOne.contains(keywordScenarioDesc)){
                    //if found, this is the END to substring for scenarioName
                    break;
                }
            }
            
            // Admission Notes Keywords
            for(Keyword keywordsAdmissionInformation : keywordsForAdmissionInformation){
                keywordAdmissionInformation = keywordsAdmissionInformation.getKeywordDesc();
                
                if(pageOne.contains(keywordAdmissionInformation)){
                    //if found, this is the END to substring for scenarioName
                    break;
                }
            }
            
            // Healthcare Provider Orders Keywords
            for(Keyword keywordsDoctorOrder : keywordsForDoctorOrder){
                keywordDoctorOrder = keywordsDoctorOrder.getKeywordDesc();
                
                if(pageOne.contains(keywordDoctorOrder)){
                    //if found, this is the END to substring for scenarioName
                    break;
                }
            }
            
            
            //4. Extracting Information based on keywords found earlier in step 3
            //Scenario Name
   //         out.println("<h1>Case Name</h1>");
            int startPositionScenarioName = pageOne.indexOf(keywordScenarioName) + keywordScenarioName.length();
            int endPositionScenarioName = pageOne.indexOf(keywordScenarioDesc, startPositionScenarioName);
            String scenarioNameExtracted = pageOne.substring(startPositionScenarioName, endPositionScenarioName);
   //         out.println(scenarioNameExtracted);
            

            //Scenario Description
            out.println("<h1>Case Description</h1>");
            int startPositionScenarioDesc = pageOne.indexOf("Synopsis:") + ("Synopsis:").length();
            int endPositionScenarioDesc = pageOne.indexOf(keywordAdmissionInformation, startPositionScenarioDesc);
            String scenarioDescExtracted = pageOne.substring(startPositionScenarioDesc, endPositionScenarioDesc);
  //          out.println(scenarioDescExtracted);
            
            //AdmissionNotes
  //          out.println("<h1>Admission Notes</h1>");
            int startPositionAdmissionNotes = pageOne.indexOf(keywordAdmissionInformation) + keywordAdmissionInformation.length();
            int endPositionAdmissionNotes = pageOne.indexOf(keywordDoctorOrder, startPositionAdmissionNotes);
            String scenarioAdmissionNotesExtracted = pageOne.substring(startPositionAdmissionNotes, endPositionAdmissionNotes);
 //           out.println(scenarioAdmissionNotesExtracted);
            
            //State 0 Healthcare Provider Order
 //           out.println("<h1>State 0 Healthcare Provider Order</h1>");
            int startPositionInitialStateOrders = pageOne.indexOf(keywordDoctorOrder) + keywordDoctorOrder.length();
            int endPositionInitialStateOrders = pageOne.indexOf("®", startPositionInitialStateOrders);
            String initialStateOrdersExtracted = pageOne.substring(startPositionInitialStateOrders, endPositionInitialStateOrders);
   //         out.println(initialStateOrdersExtracted);
            
            
            //Insertion into database:
            //Scenario Table
            Integer scNumber= ScenarioDAO.retrieveMaxBedNumber() + 1;
            String scenarioID= "SC" + scNumber;
            ScenarioDAO.add(scenarioID, scenarioNameExtracted, scenarioDescExtracted.trim(), scenarioAdmissionNotesExtracted.trim(), scNumber);
            
            //State Table
            StateDAO.add("ST0", scenarioID, "default state", "-");
            //Prescription Table
            PrescriptionDAO.add(scenarioID, "ST0", "Dr.Tan/01234Z" , initialStateOrdersExtracted, "NA", "NA", "-", "-", "N.A");
            
            
            
           // request.setAttribute("scID", scenarioID);
            session.setAttribute("scenarioID", scenarioID);
            response.sendRedirect("./editScenario.jsp");
            //RequestDispatcher rd = request.getRequestDispatcher("/editScenario.jsp");
            //rd.forward(request, response);
            /////////////////////////////////
           //// END OF PAGE 1             ////
           ///////////////////////////////// 

            
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
