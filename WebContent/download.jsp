<%@include file="include.jsp"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Thumbnail Preserving Downlaoding Page</title>
</head>
<style>
	table{border:1%;width: 100%;text-align: center;}
</style>
<body bgcolor="#ccccff">
	<%if(request.getAttribute("mediaError")!=null){%>
		<h2 style="color:red;"><%=request.getAttribute("mediaError") %></h2>
	<%} %>
	<%if(request.getAttribute("mediaSuccess")!=null){%>
		<h2 style="color:green;"><%=request.getAttribute("mediaSuccess") %></h2>
	<%} %>
	<%if(request.getAttribute("filePath")!=null){%>
		<h2 style="color:blue;"><%=request.getAttribute("filePath") %></h2>
	<%} %>
	<br><br><br><br>
	<center>
		<table width="10%">
			<tr>
				<th><h1>Download Encrypted Images</h1></th>
			</tr>
			<tr>
				<td>Enter File Id : <input id="fileid" type="text" name="fileId" placeholder="File-ID" value=""/><br><br></td>
			</tr>
			<tr>
				<td><input type="button" name="download" onclick="openPage();" value="Download File"></td>
			</tr>
		</table>
		<script>
			
		function openPage(){
			var id = document.getElementById("fileid").value;
			var theUrl = "https://www.googleapis.com/drive/v3/files/"+id;//alert(theUrl);
			window.location.href = theUrl;
		}
		
		/* function printFile() {
		  var id = document.getElementById("fileid").value;
		  var request = gapi.client.drive.files.get({
		    'fileId': id
		  });
		  request.execute(function(resp) {
		    console.log('Title: ' + resp.title);
		    console.log('Description: ' + resp.description);
		    console.log('MIME type: ' + resp.mimeType);
		  });
		}

		
		function downloadFile(file, callback) {
		  if (file.downloadUrl) {
		    var accessToken = gapi.auth.getToken().access_token;
		    var xhr = new XMLHttpRequest();
		    xhr.open('GET', file.downloadUrl);
		    xhr.setRequestHeader('Authorization', 'Bearer ' + accessToken);
		    xhr.onload = function() {
		      callback(xhr.responseText);
		    };
		    xhr.onerror = function() {
		      callback(null);
		    };
		    xhr.send();
		  } else {
		    callback(null);
		  }
		} */
	
</script>
		
	</center>
</body>
</html>