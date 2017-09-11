<%@include file="include.jsp"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Thumbnail Preserving Uploading Page To Drive</title>
</head>
<style>
	table{border:1%;width: 100%;text-align: center;}
</style>
<script>
function data(){
	var filename = document.getElementById("text").value;alert("filename = "+filename);
	var files = document.getElementById("files").value;
	var srcName = null;
	if (files) {
	    var startIndex = (files.indexOf('\\') >= 0 ? files.lastIndexOf('\\') : files.lastIndexOf('/'));
	    srcName = files.substring(startIndex);
	    if (srcName.indexOf('\\') === 0 || srcName.indexOf('/') === 0) {
	    	srcName = srcName.substring(1);
	    }
	}
	var src_Name = "//localhost:8080/Thumbnails/resource/Encrypted/"+srcName;
	alert("Path = "+src_Name);
	var file = document.getElementById("newfile");
	if (file.hasAttribute("data-src")) {
        file.setAttribute("data-src", src_Name);
    }
	if (file.hasAttribute("data-filename")) {
        file.setAttribute("data-filename", filename);//Encrypted1.bmp
    }
	
	
	/* var iDiv = document.createElement('div');
	iDiv.id = 'newfile';
	iDiv.className = 'g-savetodrive';
	
	var att = document.createAttribute('data-src');       
	att.value = '//localhost:8080/Thumbnails/resource/Encrypted/Encrypted_03-05-2017_02-12-08_PM.bmp';
	iDiv.setAttributeNode(att);
	
	var att2 = document.createAttribute('data-filename');       
	att2.value = 'Encrypted.bmp'; 
	iDiv.setAttributeNode(att2);
	
	var att3 = document.createAttribute('data-sitename');       
	att3.value = 'Project'; 
	iDiv.setAttributeNode(att3);
	
	document.getElementById('filesDetails').appendChild(iDiv); */
	
}
</script>
<body bgcolor="#ccccff">
	<%if(request.getAttribute("mediaError")!=null){%>
		<h2 style="color:red;"><%=request.getAttribute("mediaError") %></h2>
	<%} %>
	<%if(request.getAttribute("mediaSuccess")!=null){%>
		<h2 style="color:green;"><%=request.getAttribute("mediaSuccess") %></h2>
	<%} %>
	<%if(request.getAttribute("filePath")!=null){%>
		<h2 style="color:blue;">File is available at this path = <%=request.getAttribute("filePath") %></h2>
	<%} %>
	<br><br><br><br>
	<center>
	
		<table width="10%">
			<tr>
				<th><h1>Click 'Save' To Upload Encrypted Images</h1></th>
			</tr>
			<!-- <tr><td>Select File : <input id="files" type="file" name="imageFiles" /><br><br></td></tr>
			<tr><td>Enter Filename : <input id="text" type="text" name="textname" /><br><br></td></tr>    //localhost:8080/Thumbnails/resource/Encrypted/Encrypted_06-05-2017_01-48-26_AM.bmp-->
			<tr>
				<!-- <td><button name="upload" onclick="data();">Confirm</button></td> -->
				<td><script src="https://apis.google.com/js/platform.js" async defer></script>
				<div id="newfile" class="g-savetodrive" data-src="<%=request.getAttribute("uploadLink")%>"  data-filename="<%=request.getAttribute("filenaam")%>" data-sitename="Project"></div>
				</td>
			</tr>
		</table>
		

	</center>
	
	
	<span style="color:red;">Google Drive API Quickstart</span>
	

    <!--Add buttons to initiate auth sequence and sign out-->
    <button id="authorize-button" style="display: none;">Authorize</button>
    <button id="signout-button" style="display: none;">Sign Out</button>

    <pre id="content"></pre>

    <script type="text/javascript">
      // Client ID and API key from the Developer Console
      var CLIENT_ID = '894343244036-bqc2g322isa9mvc9uinfh481m9v774ds.apps.googleusercontent.com';

      // Array of API discovery doc URLs for APIs used by the quickstart
      var DISCOVERY_DOCS = ["https://www.googleapis.com/discovery/v1/apis/drive/v3/rest"];

      // Authorization scopes required by the API; multiple scopes can be
      // included, separated by spaces.
      var SCOPES = 'https://www.googleapis.com/auth/drive.metadata.readonly';

      var authorizeButton = document.getElementById('authorize-button');
      var signoutButton = document.getElementById('signout-button');

      /**
       *  On load, called to load the auth2 library and API client library.
       */
      function handleClientLoad() {
        gapi.load('client:auth2', initClient);
      }

      /**
       *  Initializes the API client library and sets up sign-in state
       *  listeners.
       */
      function initClient() {
        gapi.client.init({
          discoveryDocs: DISCOVERY_DOCS,
          clientId: CLIENT_ID,
          scope: SCOPES
        }).then(function () {
          // Listen for sign-in state changes.
          gapi.auth2.getAuthInstance().isSignedIn.listen(updateSigninStatus);

          // Handle the initial sign-in state.
          updateSigninStatus(gapi.auth2.getAuthInstance().isSignedIn.get());
          authorizeButton.onclick = handleAuthClick;
          signoutButton.onclick = handleSignoutClick;
        });
      }

      /**
       *  Called when the signed in status changes, to update the UI
       *  appropriately. After a sign-in, the API is called.
       */
      function updateSigninStatus(isSignedIn) {
        if (isSignedIn) {
          authorizeButton.style.display = 'none';
          signoutButton.style.display = 'block';
          listFiles();
        } else {
          authorizeButton.style.display = 'block';
          signoutButton.style.display = 'none';
        }
      }

      /**
       *  Sign in the user upon button click.
       */
      function handleAuthClick(event) {
        gapi.auth2.getAuthInstance().signIn();
      }

      /**
       *  Sign out the user upon button click.
       */
      function handleSignoutClick(event) {
        gapi.auth2.getAuthInstance().signOut();
      }

      /**
       * Append a pre element to the body containing the given message
       * as its text node. Used to display the results of the API call.
       *
       * @param {string} message Text to be placed in pre element.
       */
      function appendPre(message) {
        var pre = document.getElementById('content');
        var textContent = document.createTextNode(message + '\n');
        pre.appendChild(textContent);
      }

      /**
       * Print files.
       */
      function listFiles() {
        gapi.client.drive.files.list({
          'pageSize': 10,
          'fields': "nextPageToken, files(id, name)"
        }).then(function(response) {
          appendPre('Files:');
          var files = response.result.files;
          if (files && files.length > 0) {
            for (var i = 0; i < files.length; i++) {
              var file = files[i];
              appendPre(file.name + ' (' + file.id + ')');
            }
          } else {
            appendPre('No files found.');
          }
        });
      }

    </script>

    <script async defer src="https://apis.google.com/js/api.js"
      onload="this.onload=function(){};handleClientLoad()"
      onreadystatechange="if (this.readyState === 'complete') this.onload()">
    </script>
		
</body>
</html>