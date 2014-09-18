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
    Document   : SemesterSwich.jsp
    Created on : Nov 7, 2009, 7:42:16 PM
    Author     : Ramkumar
--%>
<jsp:directive.page import="java.io.*,java.util.Scanner"  />
<select id="switchsemester" onChange="window.location='?cursemester='+this.value">

<%
File _file=new File(getServletContext().getRealPath("/")+"/common/config.ini");
Scanner scanner = new Scanner(_file);
String final_db="";
    try {
      //first use a Scanner to get each line
      while ( scanner.hasNextLine() ){
            Scanner _scanner = new Scanner( scanner.nextLine());
            _scanner.useDelimiter("=");
            if ( _scanner.hasNext() ){
              String name = _scanner.next();
              String alias = _scanner.next();
              %>
              <option <%=(name.trim().equals(session.getAttribute("DB_Name")))?"selected":""%> value='<%=name.trim()%>'><%= alias.trim()%></option>
              <%
              final_db=name.trim();
              
            }
            else {
              log("Empty or invalid line. Unable to process.");
            }
            //(no need for finally here, since String is source)
            _scanner.close();

      }
    }
    finally {
      //ensure the underlying stream is always closed
      scanner.close();
    }
    if(session.getAttribute("DB_Name")==null)
        session.setAttribute("DB_Name", final_db);
%>
</select>
