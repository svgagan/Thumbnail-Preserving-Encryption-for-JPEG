package com.thumbnails.model;

import java.io.ByteArrayOutputStream;
import java.io.IOException;
import java.io.OutputStream;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 * Servlet implementation class DownloadFile
 */
@WebServlet("/DownloadFile")
public class DownloadFile extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public DownloadFile() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		response.sendRedirect("download.jsp");
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		String fileId = request.getParameter("fileId");//"0BwwA4oUTeiV1UVNwOHItT0xfa2M";
		if(fileId.length() > 0){
			OutputStream outputStream = new ByteArrayOutputStream();
			//driveService.files().get(fileId).executeMediaAndDownloadTo(outputStream);
			request.setAttribute("filePath","File Downloaded");
	    	RequestDispatcher rs = request.getRequestDispatcher("download.jsp");
		    rs.forward(request, response);
		}else{
			request.setAttribute("filePath","Not Connected To Drive");
	    	RequestDispatcher rs = request.getRequestDispatcher("download.jsp");
		    rs.forward(request, response);
		}
		
	}

}
