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
    Document   : ViewAssessment
    Created on : Aug 10, 2009, 2:38:17 PM
    Author     : Dinesh Kumar D
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
<jsp:directive.page import="java.sql.*"  />
<%@ include file="../../common/DBConfig.jsp" %>

 <%
            try {
                Connection connection =  DriverManager.getConnection(CONNECTION_URL,USER_NAME,PASSWORD);
                Statement statement = connection.createStatement();
                String elective=session.getAttribute("elective").toString();
                String subject_id=session.getAttribute("subject_id").toString();
                String semester=session.getAttribute("semester").toString();
                int section= Integer.parseInt(session.getAttribute("section").toString());
                if(request.getParameter("action").toString().equals("list"))
                {
                  String sql="";
                  String examid=request.getParameter("examid");
                  %>
                  <%int displaysection=Integer.parseInt(session.getAttribute("section").toString());%>
                  <h1>Internal Assessment Report for <%=session.getAttribute("subject_name").toString()+"["+(char)(displaysection-1+'A')+"]"%></h1>
                    <table class="Table" cellspacing="0" >
                   <thead>
                        <tr>
                            <th>Reg. No.</th>
                            <th>Student Name</th>
                            <%  ResultSet rs=null;
                                sql="select examname from assessment_master where subject_id='"+subject_id+"' and section="+section;
                                rs=statement.executeQuery(sql);
                                while(rs.next()){
                            %>
                            <th><%=rs.getString(1)%></th>
                            <%}%>
                        </tr>
                    </thead>
                    <tbody>
                <%                
                Connection con =  DriverManager.getConnection(CONNECTION_URL,USER_NAME,PASSWORD);
                Statement st=con.createStatement();
                ResultSet rset1=null;
                if(elective.equals("yes"))
                    sql="select s.* from students s,elective_students e where e.student_id=s.student_id and e.subject_id='"+subject_id+"' order by s.username";
                else
                    sql="select * from students where semester="+semester+" and section="+section +" order by username";
                
              
                rs=statement.executeQuery(sql);
                Connection conn =  DriverManager.getConnection(CONNECTION_URL,USER_NAME,PASSWORD);
                Statement stmt=con.createStatement();
                ResultSet rset=null;
                int classAverage = 0, classcount=0;
                while(rs.next()){


    %>
                <tr>
                    <td><%=rs.getString("username").substring(rs.getString("username").length()-3)%></td>
                    <td><%=rs.getString(2)%></td>
                    <% 
                    sql="select examid from assessment_master where subject_id='"+subject_id+"' and section="+section;
                    rset=stmt.executeQuery(sql);
                    //out.print(sql);
                    while(rset.next())
                    {
                    rset1=st.executeQuery("select mark from marks where examid='"+rset.getString(1)+"' and student_id='"+rs.getString(1)+"'");
                    if(rset1.next()){
                        classcount = classcount + 1;
                        try {
                      classAverage = classAverage + Integer.parseInt(rset1.getString(1));
                      } catch (Exception e) {
                          
                          }
    %>
                     <td><%=rset1.getString(1)%></td>
                    <%}
                    else
                        out.print("<td></td>");
                    %>

                <%}%>
                </tr>
                <%}%>
                <tr><td>&nbsp;</td><td>Class Average: </td><td><%=classAverage/classcount%></td></tr>
                </tbody>
                </table>
            
<%
                con.close();
                connection.close();
                con.close();
                return;
                }
                connection.close();
            }catch(Exception e){
                  out.print(e.toString());
            }
%>