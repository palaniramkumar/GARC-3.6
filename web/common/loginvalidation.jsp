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
    Document   : loginvalidation
    Created on : Apr 3, 2009, 8:20:19 PM
    Author     : Ramkumar
--%>
<jsp:directive.page import="java.sql.*"  errorPage="exception.jsp" />
<%@ include file="DBConfig.jsp" %>
<%
try{
String username=request.getParameter("username");
String password=request.getParameter("password");

   
Connection connection = DriverManager.getConnection(CONNECTION_URL,USER_NAME,PASSWORD);
/*Statement st= connection.createStatement();
Class.forName("org.gjt.mm.mysql.Driver");
Connection connection = DriverManager.getConnection(conn_string);*/



Statement st=connection.createStatement();
ResultSet rs = st.executeQuery( "select staff_id,user_type,DATE_FORMAT(day, '%W %d,%M %Y') ,DATE_FORMAT(day, '%r')  from staff where user_name = '"+username.replace("'", "''").replace("\\", "\\\\")+"' and pass =  password('"+password.replace("'", "''").replace("\\", "\\\\")+"')");
if (rs.next())
 {
    String user_id=rs.getString(1);
    String user_type=rs.getString(2);
    session.isNew();
    session.setAttribute("userid",user_id);
    session.setAttribute("usertype",user_type);
    session.setAttribute("logintime",rs.getString(3)+" at "+rs.getString(4));
    String sql="update staff set day=now() where `staff_id`='"+session.getAttribute("userid")+"'";
    st.executeUpdate(sql);
    connection.close();
    
    if(username.equalsIgnoreCase(password)){
        out.print("newUser.jsp");
    }
    
       else if(user_type.equals("Admin")||user_type.equalsIgnoreCase("GARC"))
    {session.setAttribute("userid",user_id);out.print("./Admin");}
  else if(user_type.equalsIgnoreCase("Staff"))
     {out.print("./Faculty");}
  else if(user_type.equalsIgnoreCase("office"))
     {out.print("./Office");}
     else if(user_type.equalsIgnoreCase("Director"))
     {out.print("./Director");}
  else if(user_type.equalsIgnoreCase("HOD"))
     {out.print("./Hod");}
    }
    else
    {
            rs=st.executeQuery("select semester,section,student_id, DATE_FORMAT(day, '%W %d,%M %Y') ,DATE_FORMAT(day, '%r')  from students where username='"+username.replace("'", "''").replace("\\", "\\\\")+"' and pass=password('"+password.replace("'", "''").replace("\\", "\\\\")+"')");
            boolean flag=false;
            if(rs.next())flag=true;
            if(flag){
                    String sql="update students set day=now() where `username`='"+username+"'";
                    session.setAttribute("userid",rs.getString("student_id"));
                    session.setAttribute("semester",rs.getString(1));
                    session.setAttribute("section",rs.getString(2));
                    session.setAttribute("usertype","student");
                    session.setAttribute("logintime",rs.getString(5)+"@"+rs.getString(4));
                    st.executeUpdate(sql);connection.close();
                    
                    if(username.equalsIgnoreCase(password)){
                        out.print("newUser.jsp");
                    }
                    else
                        out.print("./Student");
             }
     else{
                connection.close();
            out.print("error");
            }

    }
 

       %>

 <%
 }catch (Exception ex) {
    out.println("error e="+ex.toString());
    }%>