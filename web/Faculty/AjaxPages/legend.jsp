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
    Document   : legend
    Created on : Oct 12, 2008, 2:54:11 PM
    Author     : Ramkumar
--%>


<%
if(request.getAttribute("action")!=null){%>
    <table>
<%
sql="select a.subject_id,group_concat(s.staff_name),t.subject_name from assign_staff a,staff s,`subject` t where a.semester="+semester+" and a.section="+section+" and s.staff_id=a.staff_id and t.subject_id=a.subject_id group by subject_id;";
out.print(sql);
rs=statement.executeQuery(sql);
while(rs.next()){
    %>
    <tr>
        <td><%=rs.getString(1)%></td>
        <td><%=rs.getString(2)%></td>
        <td><%=rs.getString(3)%></td>
    </tr>
    <%
}
%>
            </table><%
}%>