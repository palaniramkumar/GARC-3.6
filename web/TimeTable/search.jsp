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
    Document   : search
    Created on : Sep 2, 2009, 5:10:12 PM
    Author     : Ramkumar
--%>
<jsp:directive.page import="java.sql.*"  />
<%@ include file="../common/DBConfig.jsp" %>
<%
    Connection connection = DriverManager.getConnection(CONNECTION_URL,USER_NAME,PASSWORD);
    Statement statement = connection.createStatement();
    String sql="select subject_id,subject_name from subject";
    ResultSet rs=statement.executeQuery(sql);
    while(rs.next())
        out.print(rs.getString(1)+"|"+rs.getString(2)+"\n");

%>

<%
    connection.close();
%>
