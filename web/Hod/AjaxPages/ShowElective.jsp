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
    Document   : ShowAllStudents
    Created on : July 20, 2009, 5:53:04 PM
    Author     : Ram Kumar
--%>
<%

    if((session.getAttribute("usertype")==null) || (session.getAttribute("usertype").toString().equalsIgnoreCase("student"))){
        %>
        <script>
            alert("Session Expired");
            window.location="../";
        </script>
        <%
        return;
    }
 %>
<%@ include file="../../common/DBConfig.jsp" %>
<jsp:directive.page import="java.sql.*"  />


<%
  try{

        Connection connection = DriverManager.getConnection(CONNECTION_URL,USER_NAME,PASSWORD);
        Statement st=connection.createStatement();
        if(request.getParameter("action").toString().equals("view")){
            String sql="select * from electives order by semester";
            //out.print(sql);
            ResultSet rs=st.executeQuery(sql);
            %>
            <table id="hor-minimalist-b">
            <thead>
            <tr  cellspacing="2" cellpadding="1">
                <th>Semester</th>
                <th>Elective Paper</th>
                <th >Action</th>
            </tr>
            </thead>
            <tbody>
            <%
            while(rs.next()){
            %>
            <tr >
                <td><%=rs.getString(2)%></td>
                <td><%=rs.getString(3)%></td>
                <td>
                    <ul class="action">
                        <li onclick="DeleteElective('<%=rs.getString(1)%>')" class="delete"><a href="#">Trash</a></li>
                    </ul>
                </td>
            </tr>
            <%
            }
            %>
            </tbody>
        </table>
            <%
        }
        else if(request.getParameter("action").toString().equals("delete")){
            String sql="delete from electives where subject_id='"+request.getParameter("subject_id")+"'";
            int rec=st.executeUpdate(sql);
            if(rec>0)
                out.print("<span class=success>Updated</span>");
            else
                out.print("<span class=success>No Change</span>");
        }
        connection.close();
  }
    catch(Exception e){
        out.print("<span class=error>"+e.toString()+"</span>");
    }

%>
