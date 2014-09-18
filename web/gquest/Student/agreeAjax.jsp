   <!--
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
  -->
<%-- 
    Document   : agreeAjax
    Created on : Mar 8, 2009, 11:35:24 PM
    Author     : Ramkumar
--%>

<%@ include file="/common/pageConfig.jsp" %>
<jsp:directive.page import="java.sql.*" />
<%
    Connection connection = DriverManager.getConnection(CONNECTION_URL,USER_NAME,PASSWORD);
    Statement statement = connection.createStatement();
    String sql="select * from exam_master where exam_id='"+request.getParameter("exam_id")+"'";
    ResultSet rs=statement.executeQuery(sql);
    if(!rs.next()){
        connection.close();
        return;
        }
 %>
 <h1>Take A Quest</h1>
 <table  cellpadding="4" cellspacing="6" class="theme">
     <tr>
         <th >Exam Name</th>
         
         <th >Duration</th>
         
     </tr>
     <tr>
         <td align="center"><%=rs.getString(2)%></td>
         <td align="center"><%=Integer.parseInt(rs.getString(5))/60%> Min</td>
     </tr>
     <tr>
         <th  colspan="2">Category</th>
     </tr>
      <tr>
         <td  colspan="2" align="center"><%=rs.getString(3)%></td>
     </tr>
      <tr>
         <th colspan="2">Description</th>
     </tr>
      <tr>
         <td colspan="2" align="center"><%=rs.getString(4)%></td>
     </tr>
     <tr>
         <td colspan="2" align="center"><center><input type="button" class="ui-state-default ui-corner-all" value="Proceed"  onclick="loadExam('<%=rs.getString(1)%>')" /></center></td>
     </tr>
 </table>
 <%connection.close();%>