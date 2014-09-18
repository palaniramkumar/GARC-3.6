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
    Document   : DBConfig
    Created on : Jul 20, 2009, 10:46:14 AM
    Author     : Ramkumar
--%>
<jsp:directive.page import="java.util.Scanner,java.io.*" />
<%
    /*
    ** Format
    ** jdbc:mysql//domainname:port/dbname;
    */
    String USER_NAME="root";
    String PASSWORD="garc@somca";
    String CONNECTION_URL="jdbc:mysql://localhost:3306/"+session.getAttribute("DB_Name");
    
    File file_=new File(getServletContext().getRealPath("/")+"/common/dbuser.ini");
    Scanner scanner_ = new Scanner(file_);
        try {
      //first use a Scanner to get each line
      while ( scanner_.hasNextLine() ){
            Scanner _scanner = new Scanner( scanner_.nextLine());
            _scanner.useDelimiter("=");
            if ( _scanner.hasNext() ){
               USER_NAME = _scanner.next();
               if ( _scanner.hasNext() ){
               PASSWORD = _scanner.next();
               }
               else
                   PASSWORD = "";
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
      scanner_.close();
    }
    
    
    Class.forName ("com.mysql.jdbc.Driver");

   // out.print(CONNECTION_URL);
    /*
     *Connection polling
    */

%>