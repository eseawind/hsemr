package controller;

import dao.ReportDAO;
import java.io.File;
import java.io.IOException;
import java.io.PrintWriter;
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
 * A Java servlet that handles file upload from client.
 *
 * @author www.codejava.net
 */
@WebServlet(name = "ProcessReportUpload", urlPatterns = {"/ProcessReportUpload"})
public class ProcessReportUpload extends HttpServlet {

    private static final long serialVersionUID = 1L;

    // location to store file uploaded
    private static final String UPLOAD_DIRECTORY = "reports";

    // upload settings
    private static final int MEMORY_THRESHOLD = 1024 * 1024 * 3;  // 3MB
    private static final int MAX_FILE_SIZE = 1024 * 1024 * 40; // 40MB
    private static final int MAX_REQUEST_SIZE = 1024 * 1024 * 50; // 50MB

    /**
     * Upon receiving file upload submission, parses the request to read upload
     * data and saves the file on disk.
     */
    protected void doPost(HttpServletRequest request,
            HttpServletResponse response) throws ServletException, IOException {
        // checks if the request actually contains upload file
        if (!ServletFileUpload.isMultipartContent(request)) {
            // if not, we stop here
            PrintWriter writer = response.getWriter();
            writer.println("Error: Form must has enctype=multipart/form-data.");
            writer.flush();
            return;
        }
        
      
       // String stateID = (String) request.getParameter("stateID");
       // String reportName= (String) request.getParameter("reportName");;
        String editReport = "";
        String reportName = "";
        String scenarioID = ""; 
        String stateID = "";
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
        ////////////////////
        // LOCAL PATH    ///
        ///////////////////
        
        // constructs the directory path to store upload file
//         this path is relative to application's directory
//        String uploadPath = getServletContext().getRealPath("")
//                + File.separator + UPLOAD_DIRECTORY;
////        
        String pathToRoot =  System.getenv("OPENSHIFT_DATA_DIR");
        String uploadPath = "";
        
        if (pathToRoot == null){
            uploadPath = getServletContext().getRealPath("")
                + File.separator + UPLOAD_DIRECTORY;
        }
        else{
            uploadPath = pathToRoot + File.separator + UPLOAD_DIRECTORY; 
        }

        // creates the directory if it does not exist
        File uploadDir = new File(uploadPath);
        if (!uploadDir.exists()) {
            uploadDir.mkdir();
        }

        try {
            // parses the request's content to extract file data
            @SuppressWarnings("unchecked")
            List<FileItem> formItems = upload.parseRequest(request);
            String filePath = "";
            if (formItems != null && formItems.size() > 0) {
                // iterates over form's fields
                for (FileItem item : formItems) {
                    // processes only fields that are not form fields
                    if (!item.isFormField()) {
                        fileName = new File(item.getName()).getName();
                        filePath = uploadPath + File.separator + fileName;
                        File storeFile = new File(filePath);

                        // saves the file on disk
                        item.write(storeFile);
                        request.setAttribute("message",
                                "Upload has been done successfully!");

                        
                    } else {
                        if (item.getFieldName().equals("scenarioID")) {
                            scenarioID = item.getString();
                        }

                        if (item.getFieldName().equals("stateID")) {
                            stateID = item.getString();
                        }
                        
                        if(item.getFieldName().equals("reportName")){
                            reportName= item.getString();
                        }
                        if(item.getFieldName().equals("editReport")){
                            editReport= item.getString();
                        }
                    }
                    
                }
            }
            
            //save it to database
            ReportDAO.add(reportName, fileName, scenarioID, stateID, 0);
            response.getWriter().println(reportName);
            response.getWriter().println(fileName);
            response.getWriter().println(scenarioID);
            response.getWriter().println(stateID);
            HttpSession session = request.getSession(false);
            //session.setAttribute("success", "You have successfully uploaded: " + fileName + " .");
            
        } catch (Exception ex) {
            request.setAttribute("message",
                    "There was an error: " + ex.getMessage());
            HttpSession session = request.getSession(false);
            //session.setAttribute("error", "There was an error in uploading " + fileName + " .");
        }
        // redirects client to message page
        HttpSession session = request.getSession(false);
        //session.setAttribute("success", "You have successfully uploaded: " + fileName + " .");
        
        if (editReport == null || editReport.equals("")) {
            response.sendRedirect("createReportDocumentBC.jsp");
        } else {
            response.sendRedirect("editReportDocument.jsp");
        }
//        getServletContext().getRequestDispatcher("/createStateWithReports.jsp").forward(
//                request, response);
    }
}
