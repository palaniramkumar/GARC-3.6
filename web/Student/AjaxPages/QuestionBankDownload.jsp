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
    Document   : QuestionBankDownload
    Created on : Nov 3, 2009, 10:02:30 AM
    Author     : Administrator
--%>
<%

    if((session.getAttribute("usertype")==null) || (!session.getAttribute("usertype").toString().equalsIgnoreCase("student"))){
        %>
        <script>
            alert("Session Expired");
            window.location="../";
        </script>
        <%
        return;
    }
 %>
<jsp:directive.page import="java.sql.*"  />
<%@ include file="../../common/DBConfig.jsp" %>
<%try{
                        Connection connection = DriverManager.getConnection(CONNECTION_URL,USER_NAME,PASSWORD);
                        Statement st=connection.createStatement();
                        String sql="select * from questionbank";
                        %>
          <div id="tabs">
		<ul>
                    <li><a href="#tabs-1" >Question Bank Download</a></li>
                </ul>
              <div id="tabs-1">
                    <%ResultSet rs= st.executeQuery(sql);%>
                                <table id="hor-minimalist-b">
                                    <thead>
                                    <tr  cellspacing="2" cellpadding="1">
                                        <th>Semester</th>
                                        <th>Question Bank(.zip/.rar file)</th>
                                        <th></th>
                                    </tr>
                                    </thead>
                                    <tbody>
                                    <% while(rs.next()){%>
                                     <tr>
                                            <td><%=rs.getString(1)%></td>
                                            <td><a href="../common/fileDownload.jsp?type=QB&filename=<%=rs.getString(2)%>" ><%=rs.getString(2)%></a></td>
                                           
                                     </tr>
                                    <%}%>
                                    </tbody>
                                </table>
                                    <div id="warning" class="error"><center>Note: Click on the Question Bank to download the Files</center></div>
                                        </div>
              </div>
<%          connection.close();
     }
    catch(Exception e){
    out.print("<span class=error>"+e.toString()+"</span>");
  }%>

