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
    Document   : updateSingleExamSettingsAjax
    Created on : Mar 8, 2009, 5:14:59 PM
    Author     : Ramkumar
--%>

<jsp:directive.page import="java.sql.*" />
<%@ include file="/common/pageConfig.jsp" %>
<%
    Connection connection = DriverManager.getConnection(CONNECTION_URL,USER_NAME,PASSWORD);
    Statement statement = connection.createStatement();
    String sql="";
    try{
	 int time=Integer.parseInt(request.getParameter("duration").toString())*60;
        sql="update exam_master set exam_name='"+request.getParameter("exam_name").replace("\\", "\\\\").replace("'", "''") +"' , category='"+request.getParameter("category").replace("\\", "\\\\").replace("'", "''")+"',duration='"+time+"' , `desc`='"+request.getParameter("desc").replace("\\", "\\\\").replace("'", "''")+"' where exam_id='"+request.getParameter("exam_id")+"'";
       statement.execute(sql);
      %>
      <div id="positive" > <!--// Positive message -->
    <table width="450" cellpadding="0" cellspacing="12">
      <tr>
        <td width="52"><div align="center"><img src="../images/icons/positive.png" alt="positive" width="22" height="16" /></div></td>
        <td width="388" class="bodytext style3"><strong>Updated </strong>  successfully<br /></td> <!--// positive message -->
      </tr>
    </table>
  </div>
      <%
    }
    catch(Exception e){
        %>
        <div id="negative" > <!--// Positive message -->
    <table width="450" cellpadding="0" cellspacing="12">
      <tr>
        <td width="52"><div align="center"><img src="../images/icons/negative.png" alt="positive" width="22" height="16" /></div></td>
        <td width="388" class="bodytext style3"><strong>Updation </strong>  Failed<br />reason: <%=e.toString()%> <br> Sql: <%=sql%> </td> <!--// positive message -->
      </tr>
    </table>
  </div>
        <%
    }
    connection.close();
 %>
