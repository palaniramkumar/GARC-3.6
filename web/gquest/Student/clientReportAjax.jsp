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
    Document   : clientReportAjax
    Created on : Mar 11, 2009, 5:57:54 PM
    Author     : Ramkumar
--%>

<table class="theme">
    <tr>
        <th>Exam Name</th>
        <th>Total Question</th>
        <th>Attended</th>
        <th>Correct</th>
        <th>Total Credit</th>
        <th>Awarded Credit</th>
        <th>View Report</th>
    </tr>
<jsp:directive.page import="java.sql.*" />
<%@ include file="/common/pageConfig.jsp" %>
<%
    Connection connection = DriverManager.getConnection(CONNECTION_URL,USER_NAME,PASSWORD);
    Statement statement = connection.createStatement();
    String client_id=session.getAttribute("userid").toString();
    String sql="select x.exam_id,y.exam_name,sum(x.points),sum(x.correct),sum(x.attended),sum(x.total),sum(x.total_points) from gquestresult x,exam_master y where x.user_id='"+client_id+"' and x.exam_id=y.exam_id group by x.exam_id";
    ResultSet rs=statement.executeQuery(sql);
    boolean attended=false;
    while(rs.next()){
        attended=true;
%>
 <tr>
        <td><a href="#" onclick="fullReport('<%=rs.getString(1)%>')"><%=rs.getString(2)%></a></td>
        <td><%=rs.getString(6)%></td>
        <td><%=rs.getString(5)%></td>
        <td><%=rs.getString(4)%></td>
        <td><%=rs.getString(7)%></td>
        <td><%=rs.getString(3)%></td>
        <td><a href="#" onclick="takeSummery('<%=rs.getString(1)%>')"><img src="/images/view.png" height="16">View</a></td>
    </tr>
<%}connection.close();
if(!attended){
    %>
    <td colspan="7" align="center"><center>You have't attend Exam</center></td>
    <%
    }
%>

</table>
<br><br>
