<%@include file="include.jsp"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Thumbnail Preserving Encryption</title>
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
		<h2 style="color:blue;">File is available at this path : <%=request.getAttribute("filePath") %></h2>
	<%} %>
	<br><br><br><br>
	<center>
		<form action="EncryptFile" method="post" enctype="multipart/form-data">
		<table width="10%">
			<tr>
				<th><h1>Encryption for Images</h1></th>
			</tr>
			<tr>
				<td>Select File : <input type="file" name="imageFiles" /><br><br></td>
			</tr>
			<tr>
				<td><input type="submit" name="upload" value="Encrypt File"></td>
			</tr>
		</table>
		</form>
	</center>
</body>
</html>