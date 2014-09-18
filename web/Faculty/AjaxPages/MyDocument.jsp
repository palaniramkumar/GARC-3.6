   <%--
    Copyright (C) 2010  GARC

    This program is free software: you can redistribute it and/or modify
    it under the terms of the GNU General Public License as published by
    the Free Software Foundation, either version 3 of the License, or
    (at your option) any later version.

    This program is distributed in the hope that it will be useful,
    but WITHOUT ANY WARRANTY; without even the implied warranty of
    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
    GNU General Public License for more details.

    You should have received a copy of the GNU General Public License
    along with this program.  If not, see <http://www.gnu.org/licenses/>.
  --%>
<%-- 
    Document   : MyDocument
    Created on : Oct 3, 2009, 10:38:49 AM
    Author     : Ramkumar
--%>
<%

    if((session.getAttribute("userid")==null)){
        %>
        <script>
            alert("Session Expired");
            window.location="../";
        </script>
        <%
        return;
    }
 %>
<jsp:directive.page import="java.sql.*,java.io.*" />
<%@ include file="../../common/FlashPaperConfig.jsp" %>
<%!
public static boolean deleteDir(File dir){
    try{
		// If it is a directory get the child
		if(dir.isDirectory()) {
			// List all the contents of the directory
			File fileList[] = dir.listFiles();

			// Loop through the list of files/directories
			for(int index = 0; index < fileList.length; index++) {
				// Get the current file object.
				File file = fileList[index];

				// Call deleteDir function once again for deleting all the directory contents or
				// sub directories if any present.
				deleteDir(file);
			}
		}

		// Delete the current directory or file.
	        dir.delete();
                return true;
                }
    catch(Exception e){
        return false;
        }
	}
%>
<%
    if(request.getParameter("create")!=null){
          boolean success = (new File(application.getRealPath("/") +"uploadedFiles\\"+MYDOCUMENT+"\\"+session.getAttribute("userid")+"\\"+ request.getParameter("create").toString())).mkdirs();
        if (success)
          out.print("Directory: " + request.getParameter("create").toString() + " created");
        else
          out.print("Failed to Create "+ request.getParameter("create").toString());

        return;
    }
    else if(request.getParameter("rmfile")!=null){
          boolean success = (new File(request.getParameter("rmfile").toString().replace('/', '\\'))).delete();
        if (success)
          out.print("Directory: " + request.getParameter("rmfile").toString() + " Deleted");
        else
          out.print("Failed to Remove");
        return;
    }
    else if(request.getParameter("rmdir")!=null){
          boolean success = deleteDir(new File(request.getParameter("rmdir").toString()));
        if (success)
          out.print("Directory: " + request.getParameter("rmdir").toString() + " Deleted");
        else
          out.print("Failed to Remove");
        return;
    }

%>
<h3>My Document</h3>
			<div align="justify"  style=" border-bottom:1px dotted #C5CBCC; border-top:1px dotted #C5CBCC; padding-top:10px; padding-bottom: 10px; margin-bottom:5px;">
                            <table width="100%" cellpadding="20px">
                                <tr>
                                    <td valign="top" width="40%">
                                        <div id="options">

                                            <p class="caption"> Folder: </p>
                                            <ul class="action">
                                                <li><input type="text" id="new_dir"/></li><li class="create" onclick="createDir()"><a href="#" >Create</a></li>
                                            </ul>
                                             <form action="../common/MyDocumentUpload.jsp" method="POST" enctype="multipart/form-data" name="form1" id="form1">

                                                 <input type="hidden" id="directory" name="directory" value="none"  />
                                                 <input type="hidden" id="file" name="hidden_file" />

                                                 <p class="caption">Selected Folder</p>
                                                 <ul class="action">
                                                     <li> <span id="span_dir" style="padding-right:20px;"></span></li>
                                                     <li class="cancel" onclick="deleteFile($('#directory').val(),'dir')"><a href="#" >Delete</a></li>
                                                 </ul>

                                                 <p class="caption">Selected File</p>
                                                 <ul class="action">
                                                     <li><span id="span_file" style="padding-right:20px;"></span> </li>
                                                     <li class="cancel"><a href="#" onclick="deleteFile($('#file').val(),'file')" >Delete</a> </li>
                                                     <li class="download"><a href="#" onclick="window.open('../common/fileDownload.jsp?type=MYDOCUMENT&filename='+$('#file').val())" >Download</a></li>
                                                 </ul>
                                                 <p class="caption">Upload File:</p>
                                                 <ul class="action">
                                                     <li><input type="file" name="file" value="Upload" /></li>
                                                     <li class="upload"> <input type="submit" name="Submit" id="submit" value="Submit file" /></li>
                                                 </ul>
                                                 <iframe id="inline" name="inline" src="" ></iframe>
                                             </form>

                                          </div>
                                    </td >
                                    <td valign="top" width="25%" >
                                        <div id="overlay" class="black_overlay">

                                        </div>
                                       <div id="list" style="position:relative;float:left"></div>
                                    </td>
                                </tr>
                            </table>
                            <%
                            if(request.getParameter("error")!=null){
                                if(request.getParameter("error").equals("no"))
                                        out.print("<span class=error>Uploaded Successfully</span>");
                                else
                                        out.print("<span class=error>"+request.getParameter("error")+"</span>");
                            }
                            %>
			</div>
			
