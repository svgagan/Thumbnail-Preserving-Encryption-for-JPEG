package com.thumbnails.model;

import java.io.ByteArrayInputStream;
import java.io.ByteArrayOutputStream;
import java.io.File;
import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.text.SimpleDateFormat;
import java.util.Date;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.Part;

/**
 * Servlet implementation class DecryptFile
 */
@MultipartConfig(maxFileSize=16177215)//Upload file upto 16Mb
@WebServlet("/DecryptFile")
public class DecryptFile extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public DecryptFile() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		response.sendRedirect("decryption.jsp");
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		Part media = request.getPart("imageFiles");
		InputStream inputstream = null;
		inputstream = media.getInputStream();
		String contentType = media.getContentType();
		if(contentType.equalsIgnoreCase("image/bmp") || contentType.equalsIgnoreCase("image/jpeg")){
			String directory= "D://sts/Thumbnails/WebContent/resource";
			File dir = new File(directory);// Creating New Directory If it not exists
			if (!dir.exists()) {
				dir.mkdir();
			}
			String folderName = "Decrypted";
			File folder = new File(directory + "/" + folderName);// Creating Sub-folders if it not exists
			if (!folder.exists()) {
				folder.mkdir();
			}
			//String imagePath = request.getParameter("img64"); // Base64 image in
			int len;
		    int size = 1024;
		    byte[] decodedBytes;
		    if (inputstream instanceof ByteArrayInputStream) {
		      size = inputstream.available();
		      decodedBytes = new byte[size];
		      len = inputstream.read(decodedBytes, 0, size);
		    } else {
		      ByteArrayOutputStream bos = new ByteArrayOutputStream();
		      decodedBytes = new byte[size];
		      while ((len = inputstream.read(decodedBytes, 0, size)) != -1)
		        bos.write(decodedBytes, 0, len);
		      decodedBytes = bos.toByteArray();
		    }
		    
		    /* Bytes Shuffling */
			//byte[] decodedBytes;
			int header=54;
			byte temp = 0;
			for(int j=0;j<145;j++){
				for(int i=header; i< decodedBytes.length; i++){
					if((i == (decodedBytes.length)-1)){ 
						break;//(header%2 == 1) &&
					}
					else{
						//System.out.println(j+"Image bytes available are "+i+"->"+imageAis[i]);
						temp = decodedBytes[i+1];
						decodedBytes[i+1] = decodedBytes[i];
						decodedBytes[i] = temp;
						i=i+1;
						//encodedImageAis[header+i+2] = ais[i];
					}
				}
				header++;
			}
		    
		    
		    
			//byte[] decodedBytes = sun.misc.IOUtils.readFully(inputstream, 0, true);
			FileOutputStream imageOutFile = null;
			String filePath = null;
			try {
				Date dt = new Date();
				SimpleDateFormat df = new SimpleDateFormat("dd-MM-yyyy_hh-mm-ss_a");
				String strDt = df.format(dt);
				String mime;
				if(contentType.equalsIgnoreCase("image/jpeg")){
					mime = ".jpg";
				}else{
					mime = ".bmp";
				}
				String fileName = "Decrypted_" + strDt + mime;
				File newFile = new File(folder + "/" + fileName);
				if (!newFile.exists()) {
					newFile.createNewFile();
				}
				imageOutFile = new FileOutputStream(newFile); // Write a image byte
				// array into file
				// system
				imageOutFile.write(decodedBytes);
				imageOutFile.close();
				filePath = newFile.getPath();
				System.out.println("Image Successfully Manipulated! "+ newFile.getPath());
			} catch (FileNotFoundException e) {
				System.out.println("Image not found" + e);
			} catch (IOException ioe) {
				System.out.println("Exception while reading the Image " + ioe);
			}
			//return filePath;
			System.out.println("ImageFile = "+inputstream);
			request.setAttribute("filePath",filePath);
			request.setAttribute("mediaSuccess","Decrypted Successfully");
        	RequestDispatcher rs = request.getRequestDispatcher("decryption.jsp");
		    rs.forward(request, response);
		}else{
			System.out.println(media.getContentType());
			request.setAttribute("mediaError","Image files only");
        	RequestDispatcher rs = request.getRequestDispatcher("decryption.jsp");
		    rs.forward(request, response);
		}
	}

}
