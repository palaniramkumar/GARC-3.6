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
    Document   : fileDownload
    Created on : Aug 10, 2009, 2:36:19 PM
    Author     : Ramkumar
--%>

<%@ page import="java.util.*,java.io.*,java.net.*"%>
<%@ include file="FlashPaperConfig.jsp" %>
<%@ include file="../../common/pageConfig.jsp" %>
<%
//validating session
if(session.getAttribute("usertype")==null && request.getParameter("type").equals("MYDOCUMENT")){
        %>
        <script>
            alert("Session Expired");            
        </script>
        <%
        return;
		}
if(LOCK_RESOURCE.equals("1") && request.getParameter("type").equals("RESOURCE")){
%>
        <script>
            alert("Dont have permission to download");
            window.location="../";
        </script>
        <%
        return;
}
if( LOCK_SOFTWARE.equals("1") && request.getParameter("type").equals("MYDOCUMENT")){
        %>
        <script>
            alert("Dont have permission to download");
            window.location="../";
        </script>
        <%
        return;
		}
		
String file_name = URLDecoder.decode(request.getParameter("filename"));
String path="";
if(request.getParameter("type").equals("RESOURCE"))
    path=RESOURCE_UPLOAD;
if(request.getParameter("type").equals("QB"))
    path=QUESTIONBANK;
if(request.getParameter("type").equals("ARTICLE"))
    path=ARTICLE_UPLOAD;
if(request.getParameter("type").equals("EMAIL"))
    path=MAIL_UPLOAD;

String file =config.getServletContext().getRealPath("/")+"/uploadedFiles/"+path+"/"+ file_name;
if(request.getParameter("type").equals("MANUAL"))
    file =config.getServletContext().getRealPath("/")+"Manual/"+ file_name;
if(request.getParameter("type").equals("MYDOCUMENT"))
    file=file_name;
//out.println(file);
File f = new File(file);
if(f.exists()){

	int filesize = (int)f.length();
	byte buff[] = new byte[2048];
	int bytesRead;

	try {
		response.setContentType("session/x-msdownload");
		response.setHeader("Content-Disposition","attachment; filename=\""+file_name+"\"");
		FileInputStream fin = new java.io.FileInputStream(f);
		BufferedInputStream bis = new BufferedInputStream(fin);
		ServletOutputStream fout = response.getOutputStream();
		BufferedOutputStream bos = new BufferedOutputStream(fout);

		while((bytesRead = bis.read(buff)) != -1) {
			  bos.write(buff, 0, bytesRead);
		  }
		bos.flush();

		fin.close();
		fout.close();
		bis.close();
		bos.close();

	} catch( IOException e){
		response.setContentType("text/html");
		out.println("Error : "+e.getMessage());
	}
} else {
	response.setContentType("text/html");
	out.println("The Requested file is not found");
}
%>
