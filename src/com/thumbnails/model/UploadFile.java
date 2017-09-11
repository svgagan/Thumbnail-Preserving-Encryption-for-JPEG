package com.thumbnails.model;

import java.io.File;
import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 * Servlet implementation class UploadFile
 */
@WebServlet("/UploadFile")
public class UploadFile extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public UploadFile() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		response.sendRedirect("viewDrive.jsp");
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		/*File fileMetadata = new File();
		fileMetadata.setName("photo.jpg");
		java.io.File filePath = new java.io.File("files/photo.jpg");
		FileContent mediaContent = new FileContent("image/jpeg", filePath);
		File file = driveService.files().create(fileMetadata, mediaContent)
		        .setFields("id")
		        .execute();
		System.out.println("File ID: " + file.getId());*/


	}

}
