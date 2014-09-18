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
    Document   : SidePanel
    Created on : Jun 5, 2010, 8:25:34 PM
    Author     : Ram
--%>

<div id="left" style="height: auto">
        <h2>Main Navigation</h2>
        <br>
        <table cellpadding="5px">
            <tr>
                <td align="center"><a href="#"><img src="../../images/side_add.png" alt="edit" width="18" height="18" border="0" /></a></td>
                <td>       <a href="GQuestAddExam.jsp">Add Quest</a>                </td>
                
            </tr>
            <tr>
                <td align="center"><a href="#"><img src="../../images/settings.png" alt="edit" width="18" height="18" border="0" /></a></td>
                <td><a href="GQuestSettings.jsp">Settings</a></td>
            </tr>
        </table>
        <br>
        <h3>Latest Quest</h3>
        <br>
        <table cellpadding="5px">
<%
    Connection connection = DriverManager.getConnection(CONNECTION_URL,USER_NAME,PASSWORD);
    Statement statement=connection.createStatement();
    String sFacultyID=session.getAttribute("userid").toString();
    String sql="select exam_id,exam_name from exam_master where facid='"+sFacultyID+"'";


    ResultSet rs=statement.executeQuery(sql);
    int i=1;
    while(rs.next()){
      //  out.print(sql);
%>
        <tr>
            <td align="center"><a href="#"><img src="/images/edit.png" alt="edit" width="18" height="18" border="0" /></a></td>
            <td><a href="GQuestAddQuestion.jsp?exam_id=<%=rs.getString(1)%>"><%=rs.getString(2)%> #<%=i++%></a></td> <!--// ...Article #7 -->
        </tr>
        <%} %>
      </table>

    </div>

