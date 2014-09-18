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
    Document   : changeProfile
    Modified on : Jun 16, 2012, 3:18:08 PM
    Author     : Ramkumar
--%>
<%

    if((session.getAttribute("usertype")==null)){
        %>
        <script>
            alert("Session Expired");
            window.location="../";
        </script>
        <%
        return;
    }
 %>

<jsp:directive.page import="java.sql.*"  />
<%@ include file="../../common/DBConfig.jsp" %>

<%try{
                        Connection connection = DriverManager.getConnection(CONNECTION_URL,USER_NAME,PASSWORD);
                        Statement st=connection.createStatement();
                        String userid=session.getAttribute("userid").toString();
                        String user_type=session.getAttribute("usertype").toString();
                        String new_pass=request.getParameter("newpass").toString();
                            if(request.getParameter("action").toString().equals("changePass")){
                                String sql="";
                                
                                if(session.getAttribute("usertype").equals("student"))
                                    sql="update students set pass=password('"+new_pass+"') where student_id='"+userid+"'";
                                else if(user_type.equals("Admin")||user_type.equalsIgnoreCase("GARC")||user_type.equalsIgnoreCase("Staff")||user_type.equalsIgnoreCase("office")||user_type.equalsIgnoreCase("Director")||user_type.equalsIgnoreCase("HOD"))
                                    sql="update staff set pass=password('"+new_pass+"') where staff_id='"+userid+"'";
                                st.executeUpdate(sql);
                                out.print("<span class=error> New Password Set</span>");
                                //}
                                //else
                                //    out.print("<span class=error> Wrong Password</span>");
                                connection.close();
                                return;
                                }
                        
            connection.close();
     }
    catch(Exception e){
        out.print("<span class=error>"+e.toString()+"</span>");
  }%>
  
