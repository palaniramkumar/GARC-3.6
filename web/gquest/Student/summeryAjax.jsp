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
    Document   : summeryAjax
    Created on : Mar 9, 2009, 4:31:15 PM
    Author     : Ramkumar
--%>


<style>
    td.value {
	
	background-repeat: repeat-x;
	background-position: left top;
	border-left: 1px solid #e5e5e5;
	border-right: 1px solid #e5e5e5;
	padding:0;
	border-bottom: none;
	background-color:transparent;
}

td.value img {
	vertical-align: middle;
	margin: 5px 5px 5px 0;
}
td.last {
	border-bottom:1px solid #e5e5e5;
}
td.first {
	border-top:1px solid #e5e5e5;
}
.auraltext
{
	position: absolute;
	font-size: 0;
	left: -1000px;
}
</style>
<jsp:directive.page import="java.sql.*" />
<%@ include file="/common/pageConfig.jsp" %>

<table class="theme">
    <tr>
        <th >Category</th>
        <th >NO.Q#</th>
        <th >Answered</th>
        <th >Correct</th>
        <th >Credit</th>
        <th >Score</th>
    </tr>
<%
    Connection connection = DriverManager.getConnection(CONNECTION_URL,USER_NAME,PASSWORD);
    Statement statement = connection.createStatement();
    String client_id=request.getParameter("user_id").toString();
    String sql="select exam_name,DATE_FORMAT(`date`,'%d-%m-%Y') from exam_master where exam_id like '"+request.getParameter("exam_id")+"'"	;
    ResultSet rs=statement.executeQuery(sql);
    String exam_name="";
    if(rs.next())
	exam_name=rs.getString(1)+" ( "+rs.getString(2)+" )";

    sql="select * from gquestresult where exam_id='"+request.getParameter("exam_id")+"' and user_id='"+client_id+"' ";
    rs=statement.executeQuery(sql);
    int mark=0,total=0,noq=0,ans=0,correct=0;
%>
<p><i><%=exam_name%></i></p>
<%
    while(rs.next()){
        mark+=rs.getInt(4);
        total+=rs.getInt(8);
        noq+=rs.getInt(7);
        ans+=rs.getInt(6);
        correct+=rs.getInt(5);
%>      <tr>
            <td class="bodytext_table"><%=rs.getString(3)%></td>
            <td class="bodytext_table"><%=rs.getString(7)%></td>
            <td class="bodytext_table"><%=rs.getString(6)%></td>
            <td class="bodytext_table"><%=rs.getString(5)%></td>
            <td class="bodytext_table"><%=rs.getString(8)%></td>
            <td class="bodytext_table"><%=rs.getString(4)%></td>
         </tr>


<%}
    
    connection.close();
    %>
        <tr>
            <th>Total</th>
            <td class="title_table" colspan="6"><%=mark%> / <%=total%></td>
         </tr>
</table>
<h1>Question</h1>
<table width="100%" bgcolor="white">
    <tr>
        <td width="200px">Total Question</td>
        <td class="value"><img src="/images/bar.png" alt="" width="<%=(noq/noq)*200%>" height="16" /><%=noq%></td>
    </tr>
    <tr>
        <td>Answered</td>
        <td class="value"><img src="/images/bar.png" alt="" width="<%=((float)ans/noq)*200%>" height="16" /><%=ans%></td>
    </tr>
   <tr>
        <td>Correct</td>
        <td class="value"><img src="/images/bar.png" alt="" width="<%=((float)correct/noq)*200%>" height="16" /><%=correct%></td>
    </tr>
    
</table>
<h1>Credit</h1>
<table width="100%" bgcolor="white">
    <tr>
        <td width="200px">Total credit</td>
        <td class="value"><img src="/images/bar.png" alt="" width="<%=(total/total)*200%>" height="16" /><%=total%></td>
    </tr>
    <tr>
        <td>My Credit</td>
        <td class="value"><img src="/images/bar.png" alt="" width="<%=((float)mark/total)*200%>" height="16" /><%=mark%></td>
    </tr>
</table>