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
    Document   : singleexamsummeryAjax
    Created on : Mar 11, 2009, 1:55:24 AM
    Author     : Ramkumar
--%>
<jsp:directive.page import="java.sql.*" />
<%@ include file="/common/pageConfig.jsp" %>
<%
    Connection connection = DriverManager.getConnection(CONNECTION_URL,USER_NAME,PASSWORD);
    Statement statement = connection.createStatement();
    String sql="";
    sql="select count(distinct(user_id)) from gquestresult where exam_id = '"+request.getParameter("exam_id")+"' group by exam_id";
    ResultSet rs=statement.executeQuery(sql);
    if(!rs.next()){
	connection.close();
	out.println("<center><b>No Records!</b></center>");
	return;
	}
    int total_client=rs.getInt(1);
    sql="SELECT sum(points),sum(correct),sum(attended),sum(total),sum(total_points) FROM gquestresult where exam_id='"+request.getParameter("exam_id")+"' ";
    rs=statement.executeQuery(sql);
%>

<table  style="margin:auto" bgcolor="white">
    <tr>
        <td class="title_table">Total number of canditates</td>
        <td><%=total_client%></td>
    </tr>
</table>
<br>
<h1>Avearge</h1>
<table width="90%" style="margin:auto"  class="theme">
    <tr>
        <th >Points</th>
        <th >Correct Questions</th>
        <th >Questions attended</th>
        <th >Total Questions</th>
        <th >Total Points</th>
        
    </tr>
    <%while(rs.next()){%>
    <tr>
        <td  class="bodytext_table"><%=rs.getInt(1)/total_client%></td>
        <td  class="bodytext_table"><%=rs.getInt(2)/total_client%></td>
        <td  class="bodytext_table"><%=rs.getInt(3)/total_client%></td>
        <td  class="bodytext_table"><%=rs.getInt(4)/total_client%></td>
        <td  class="bodytext_table"><%=rs.getInt(5)/total_client%></td>
    </tr>
    <%}%>
</table>
<%
int max_point,min_point,max_correct,min_correct,max_attend,min_attend;
max_point=min_point=max_correct=min_correct=max_attend=min_attend=0;

sql="SELECT sum(points) FROM gquestresult where exam_id='"+request.getParameter("exam_id")+"' group by user_id order by sum(points) desc";
rs=statement.executeQuery(sql);
if(rs.next())
    max_point=rs.getInt(1);
sql="SELECT sum(correct) FROM gquestresult where exam_id='"+request.getParameter("exam_id")+"' group by user_id order by sum(correct) desc";
rs=statement.executeQuery(sql);
if(rs.next())
    max_correct=rs.getInt(1);
sql="SELECT sum(attended)FROM gquestresult where exam_id='"+request.getParameter("exam_id")+"' group by user_id order by sum(attended) desc";
rs=statement.executeQuery(sql);
if(rs.next())
    max_attend=rs.getInt(1);

sql="SELECT sum(points) FROM gquestresult where exam_id='"+request.getParameter("exam_id")+"' group by user_id order by sum(points) ";
rs=statement.executeQuery(sql);
if(rs.next())
    min_point=rs.getInt(1);
sql="SELECT sum(correct) FROM gquestresult where exam_id='"+request.getParameter("exam_id")+"' group by user_id order by sum(correct) ";
rs=statement.executeQuery(sql);
if(rs.next())
    min_correct=rs.getInt(1);
sql="SELECT sum(attended)FROM gquestresult where exam_id='"+request.getParameter("exam_id")+"' group by user_id order by sum(attended) ";
rs=statement.executeQuery(sql);
if(rs.next())
    min_attend=rs.getInt(1);
connection.close();
%>
<br>
<h1>Highest</h1>
<table width="90%" style="margin:auto"  class="theme">
    <tr>
        <th class="title_table">Points</th>
        <th class="title_table">Correct Questions</th>
        <th class="title_table">Questions attended</th>
    </tr>
    <tr>
        <td  class="bodytext_table"><%=max_point%></td>
        <td  class="bodytext_table"><%=max_correct%></td>
        <td  class="bodytext_table"><%=max_attend%></td>
    </tr>
</table><br>
    <h1>Lowest</h1>
<table width="90%" style="margin:auto"  class="theme">
    <tr>
        <th class="title_table"d>Points</th>
        <th class="title_table">Correct Questions</th>
        <th class="title_table">Questions attended</th>
    </tr>
    <tr>
        <td  class="bodytext_table"><%=min_point%></td>
        <td  class="bodytext_table"><%=min_correct%></td>
        <td class="bodytext_table"><%=min_attend%></td>
    </tr>
</table>