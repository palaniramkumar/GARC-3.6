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
    Document   : setActiveAjax
    Created on : Mar 11, 2009, 2:16:30 AM
    Author     : Ramkumar
--%>
<jsp:directive.page import="java.sql.*" />
<%@ include file="/common/pageConfig.jsp" %>
<%
    Connection connection = DriverManager.getConnection(CONNECTION_URL,USER_NAME,PASSWORD);
    Statement statement = connection.createStatement();
    String sql="update exam_master set active='"+request.getParameter("active")+"' where exam_id="+request.getParameter("exam_id");
    statement.executeUpdate(sql);
    out.print("<center>Last Update @ "+new java.util.Date().toString()+"</center>");
    %>
   