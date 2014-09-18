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
    Document   : ShowAttendance
    Created on : Aug 1, 2009, 10:28:46 AM
    Author     : Ramkumar
--%>
<%

    if((session.getAttribute("usertype")==null) || (session.getAttribute("usertype").toString().equalsIgnoreCase("student"))){
        %>
        <script>
            alert("Session Expired");
            window.location="../";
        </script>
        <%
        return;
    }
 %>
 <META HTTP-EQUIV="Content-Type" CONTENT="text/html; charset=UTF-8">
<%@ page pageEncoding="UTF-8" %>
<%@ page language="java" contentType="text/html;charset=UTF-8" %>
<jsp:directive.page import="java.sql.*"  />
<%@ include file="../../common/DBConfig.jsp" %>
 <%
            try {
//		out.print("Saved ...");
                Connection connection =DriverManager.getConnection(CONNECTION_URL,USER_NAME,PASSWORD);
                Statement statement = connection.createStatement();
                
                if(request.getParameter("action").toString().equals("add")){
		statement.executeUpdate("delete from courseoutline where staff_id='"+session.getAttribute("userid")+"' and subject_id='"+session.getAttribute("subject_id")+"' and sec='"+session.getAttribute("section")+"'");
//		out.print("delete from courseoutline where staff_id='"+session.getAttribute("userid")+"' and subject_id='"+session.getAttribute("subject_id")+"' and sec='"+session.getAttribute("section")+"'");
		String sql="insert into courseoutline values('"+session.getAttribute("userid")+"','"+request.getParameter("course_outline").trim().replace("'","''").replace("\\","\\\\")+"','"+session.getAttribute("subject_id")+"','"+session.getAttribute("section")+"','"+session.getAttribute("semester")+"')" ;
		//out.print(sql);
                statement.executeUpdate(sql);
                ResultSet rs=statement.executeQuery("select data from courseoutline where staff_id='"+session.getAttribute("userid")+"' and subject_id='"+session.getAttribute("subject_id")+"' and sec='"+session.getAttribute("section")+"'");
		if(rs.next())
		out.print(rs.getString(1));
                  connection.close();
                return;
                }else if(request.getParameter("action").toString().equals("view")){
                    %>
                <%
                ResultSet rs=statement.executeQuery("select data from courseoutline where staff_id='"+session.getAttribute("userid")+"' and subject_id='"+session.getAttribute("subject_id")+"' and sec='"+session.getAttribute("section")+"'");
		if(rs.next())
		out.print(rs.getString(1));
                connection.close();
                return;
                }
		connection.close();
                }
                catch(Exception e){
                    out.print(e.toString());
                }
         %>

<ul class="action" style="float:right;padding-bottom:10px;"><li onclick="AddCourseOutline()" class="save"><a href="#">Save</a></li></ul>
<div id="viewCourse"><textarea name="area3" id="area3" style="width: 825px; height: 450px;"></textarea>
<center><input type="button" value="Save" onclick="AddCourseOutline()"></center>
</div>