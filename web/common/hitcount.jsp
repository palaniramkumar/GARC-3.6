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
    Document   : hitcount
    Created on : Apr 3, 2009, 7:51:00 PM
    Author     : Ramkumar
--%>

<jsp:directive.page import="java.sql.*"  />


<%

Connection connection_count = DriverManager.getConnection(CONNECTION_URL,USER_NAME,PASSWORD);
Statement statement1 = connection_count.createStatement();
if(session.isNew())
     statement1.executeUpdate("update misc set value = value + 1 where type like 'hit_count'");
ResultSet rs1 = statement1.executeQuery("select value from misc where type like 'hit_count'");
rs1.next();
out.print(rs1.getInt(1));
connection_count.close();

%>