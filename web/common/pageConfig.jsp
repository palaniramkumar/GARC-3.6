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
    Document   : pageConfig
    Created on : Apr 3, 2009, 7:39:03 PM
    Author     : Ramkumar
--%>
<jsp:directive.page import="java.sql.*,java.util.Scanner,java.io.*"  />

<%
if(request.getParameter("cursemester")!=null)
    session.setAttribute("DB_Name", request.getParameter("cursemester"));

if(session.getAttribute("DB_Name")==null || session.getAttribute("DB_Name").equals("")){
        
File _file=new File(getServletContext().getRealPath("/")+"/common/config.ini");
Scanner scanner = new Scanner(_file);
String final_db="";
    try {
      //first use a Scanner to get each line
          while ( scanner.hasNextLine() ){
                Scanner _scanner = new Scanner( scanner.nextLine());
                _scanner.useDelimiter("=");
                if ( _scanner.hasNext() ){
                  final_db = _scanner.next();
                  _scanner.next();
                  session.setAttribute("DB_Name", final_db);
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
        
    }
    String USER_NAME="";
    String PASSWORD="";
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
               PASSWORD = _scanner.next();              
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
    
    


    Class.forName("org.gjt.mm.mysql.Driver");
    Connection _connection = DriverManager.getConnection(CONNECTION_URL,USER_NAME,PASSWORD);
    Statement _st=_connection.createStatement();
    ResultSet _rs=_st.executeQuery("select * from misc");
    _rs.next();
    //_rs.next();
    final String college=_rs.getString(2);
	_rs.next();
    final int NO_OF_YEARS=_rs.getInt(2);
    _rs.next();
    final String dept=_rs.getString(2);
    _rs.next();
	_rs.next();
	final String LOCK_RESOURCE=_rs.getString(2);
	_rs.next();
	final String LOCK_SOFTWARE=_rs.getString(2);
	_rs.next();
	final int MAX_NO_OF_PERIODS=_rs.getInt(2);/* MAX NO OF HOUR =9*/
	_rs.next();
	final int NO_OF_UNITS=_rs.getInt(2);
	
	_rs.next();
    final int NO_OF_SECTIONS=_rs.getInt(2);
    
    
    
    
    

    
    String[] exam_months={"Mar/Apr","Nov/Dec"};
    String[] GRADE_LETTER={"S","A","B","C","D","E","U","W","I",};
    int[] GRADE_POINT={10,9,8,7,6,5,0,0,0};
    
    String[] STAFF_DESIGNATION={"Professor","Associate Professor","Asst. Professor","Visiting Professor","S.G. Lecturer","Sr. Lecturer","Lecturer","Guest Lecturer","Office Assitant","Library Assistant","Lab Assistant"};
    int[] STAFF_PRIORITY={1,2,3,4,5,6,7,8,9,10,11};
%>