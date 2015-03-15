/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

package controller;

import java.io.File;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.Iterator;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import org.apache.commons.fileupload.FileItem;
import org.apache.commons.fileupload.disk.DiskFileItemFactory;
import org.apache.commons.fileupload.servlet.ServletFileUpload;

/**
 *
 * @author weiyi.ngow.2012
 */
@WebServlet(name = "ProcessPDFCreation", urlPatterns = {"/ProcessPDFCreation"})
public class ProcessPDFCreation extends HttpServlet {
    
     private static final long serialVersionUID = 1L;

    // location to store file uploaded
    private static final String DATA_DIRECTORY = "scenarioPDF";
    // upload settings
    private static final int MEMORY_THRESHOLD = 1024 * 1024 * 3;  // 3MB
    private static final int MAX_FILE_SIZE = 1024 * 1024 * 40; // 40MB
    private static final int MAX_REQUEST_SIZE = 1024 * 1024 * 50; // 50MB
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
            /* TODO output your page here. You may use following sample code. */
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Servlet ProcessPDFCreation</title>");            
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet ProcessPDFCreation at " + request.getContextPath() + "</h1>");
            out.println("</body>");
            out.println("</html>");
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
         // checks if the request actually contains upload file
        if (!ServletFileUpload.isMultipartContent(request)) {
            // if not, we stop here
            PrintWriter writer = response.getWriter();
            writer.println("Error: Please upload a PDF file.");
            writer.flush();
            return;
        }
        
        String scenario = "";
        String scenarioID = ""; 
        String fileName = "";

        // configures upload settings
        DiskFileItemFactory factory = new DiskFileItemFactory();
        // sets memory threshold - beyond which files are stored in disk
        factory.setSizeThreshold(MEMORY_THRESHOLD);
        // sets temporary location to store files
        factory.setRepository(new File(System.getProperty("java.io.tmpdir")));

        ServletFileUpload upload = new ServletFileUpload(factory);

        // sets maximum size of upload file
        upload.setFileSizeMax(MAX_FILE_SIZE);

        // sets maximum size of request (include file + form data)
        upload.setSizeMax(MAX_REQUEST_SIZE);
        
        /////////////////////////////////
        /////     LOCAL UPLOAD      /////
        /////////////////////////////////
        
        // constructs the directory path to store upload file
//         this path is relative to application's directory
//        String uploadPath = getServletContext().getRealPath("")
//                + File.separator + UPLOAD_DIRECTORY;
//        
 //       String uploadPath = System.getenv("OPENSHIFT_DATA_DIR") + UPLOAD_DIRECTORY;
        
        String pathToRoot =  System.getenv("OPENSHIFT_DATA_DIR");
        String uploadFolder = "";
        if (pathToRoot == null){
            uploadFolder = getServletContext().getRealPath("") + File.separator + "tmp";
        }
        else{
            uploadFolder = pathToRoot + File.separator + DATA_DIRECTORY; 
        }
       
        // Set overall request size constraint
        upload.setSizeMax(MAX_REQUEST_SIZE);
        HttpSession session = request.getSession(false);
        try {
            // Parse the request
            List items = upload.parseRequest(request);
            Iterator iter = items.iterator();
            while (iter.hasNext()) {
                FileItem item = (FileItem) iter.next();

                if (!item.isFormField()) {
                    //Direct to the <uploadFolder> directory
                    //If the folder does not exist then create an empty folder with the path from <uploadFolder>
                    File folder = new File(uploadFolder);
                    if (!folder.exists()) {
                        folder.mkdir();
                    }

                    //Get the uploaded file
                    fileName = new File(item.getName()).getName();
                    String filePath = uploadFolder + File.separator + fileName;
                    File uploadedFile = new File(filePath);

                    //Validate the file is ".zip"
                    int indexOfLastDot = fileName.lastIndexOf('.');
                    String fileType = fileName.substring(indexOfLastDot + 1).toLowerCase();
                    if (!fileType.equals("pdf")) {
                        String errorMessage = "Please upload PDF file";
                        session.setAttribute("error", errorMessage);
                        getServletContext().getRequestDispatcher("/createPDFUpload.jsp").forward(request, response);
                        return;
                    }
                    if (item.getFieldName().equals("scenarioID")) {
                        scenarioID = item.getString();
                    }
                    //saves the file to upload directory
                    item.write(uploadedFile);
                    
                    //pass the uploaded file and path to UnzipServlet
                    session.setAttribute("pdf_file", uploadedFile);
                    session.setAttribute("pdf_path", filePath);
                }
            }
            
            //save it to database
            //DocumentDAO.add(documentName, fileName, 1, scenarioID, stateID);
            
            //session.setAttribute("success", "You have successfully uploaded: " + fileName + " .");
            
        } catch (Exception ex) {
            request.setAttribute("message",
                    "There was an error: " + ex.getMessage());
            session.setAttribute("error", "There was an error in uploading " + fileName + " .");
        }
        // redirects client to message page
        //session.setAttribute("success", "You have successfully uploaded: " + fileName + " .");
        response.sendRedirect("ProcessExtractPDF");
        
//        getServletContext().getRequestDispatcher("/createStateWithReports.jsp").forward(
//                request, response);
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
