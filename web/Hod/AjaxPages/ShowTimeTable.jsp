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
    Document   : ShowTimeTable
    Created on : Jan 19, 2009, 1:43:45 AM
    Author     : Ramkumar
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
<%@ include file="../../common/pageConfig.jsp" %>
<jsp:directive.page import="java.sql.*"  />
<%
  try{
        Connection connection = DriverManager.getConnection(CONNECTION_URL,USER_NAME,PASSWORD);
        Statement st=connection.createStatement();
        String sql="select sectioncount,year,semester from section";
        //out.print(sql);
        ResultSet rs=st.executeQuery(sql);
        %>
        Year: 
        <select id="semester" onchange="gettimetable()">
            <%while(rs.next()){%>
            <option value="<%=rs.getInt("semester")%>"><%=rs.getInt("year")%></option>
            <%}%>
        </select>
        Section: 
        <select id="section" onchange="gettimetable()">
            <%  for(int i=1;i<=NO_OF_SECTIONS;i++){
                %>
            <option value="<%=i%>"><%=(char)('A'+i-1)%></option>
                <%}%>
        </select>
        <div id="timetable"></div>
        <%
        connection.close();
     }
  catch(Exception e){
      
  }
%>
    
