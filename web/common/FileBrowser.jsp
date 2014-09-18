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
    Document   : FileBrowser
    Created on : Sep 30, 2009, 1:49:03 PM
    Author     : Ramkumar
--%>
<jsp:directive.page import="java.io.*"  />
<%@ include file="../common/FlashPaperConfig.jsp" %>
<%
            String ROOT=config.getServletContext().getRealPath("/")+"uploadedFiles\\"+MYDOCUMENT+"\\"+session.getAttribute("userid");
            String CUR_PATH="";
            if(!request.getParameter("folder").equals("none"))
                CUR_PATH=request.getParameter("folder");
            else
                CUR_PATH=ROOT;
            new File(CUR_PATH).mkdirs();
            File dir = new File(CUR_PATH);
            CUR_PATH=dir.getCanonicalPath()+"\\";
            out.print("<b>Current Folder</b> <span class='currentFolder'>"+dir.getCanonicalPath().replace(ROOT, ".")+"</span>");

            String[] children = dir.list();
            if (children == null) {
                // Either dir does not exist or is not a directory
                 out.print("<span class='currentFolder'>Unknown Folder: "+CUR_PATH+"</span>");

                 return;
            } else {
                for (int i=0; i<children.length; i++) {
                    // Get filename of file or directory
                    File temp=new File(CUR_PATH+children[i]);
                    if(temp.isDirectory())
                        children[i]="<span class='afolder' title='"+temp.getCanonicalPath()+"\\'>"+children[i].toLowerCase()+"</span>";
                    else
                         children[i]="<span class='file' title='"+temp.getCanonicalPath()+"'>"+children[i].toLowerCase()+"</span>";
                }
            }
            java.util.Arrays.sort(children);
            if(new File(CUR_PATH).compareTo(new File(ROOT))!=0)
                out.print("<span class='afolder' title='"+CUR_PATH+"..\\"+"'>< Back</span>");
            for(int i=0;i<children.length;i++)
                out.print(children[i]);
        %>