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
    Document   : FacultyProfile
    Created on : Sep 29, 2009, 11:57:21 AM
    Author     : Dinesh Kumar .D
--%>
<%@ include file="../common/DBConfig.jsp" %>
<jsp:directive.page import="java.sql.*,java.io.*"  />

<%
 if((session.getAttribute("DB_Name")==null)){
        %>
        <script>

            window.location="./";
        </script>
        <%
        return;
    }
 
   try{

        Connection connection = DriverManager.getConnection(CONNECTION_URL,USER_NAME,PASSWORD);
        Statement st=connection.createStatement();
        ResultSet rs=st.executeQuery("select staff_name,qualification,user_type,designation,subjects_handled,mailid,phone_number,staff_id from staff where user_type='Director'");

%>
<h1><center>Faculty Profile</center></h1>
           <TABLE cellSpacing=0 cellPadding=5px width=800 border=0>
               <TBODY valign="top">
                    <tr>
                        <%if(rs.next()){
                            String path="./images/faculty/"+rs.getString("staff_id")+".jpg";
                            //out.println(getServletContext().getRealPath("/")+path);
                            File file=new File(getServletContext().getRealPath("/")+path);
                            if(!file.exists())
                                path="./images/unknown.png";                            
                            %>
                        <td width="120">
                            <img width="100px" height="120px" src="<%=path%>"/>
                        </td>
                    <TD>
                                <ul style="list-style-type:none">
                                    <li style="color:brown;font-weight:bolder;"><%=rs.getString(1)%></li>
                                    <li><%=rs.getString(2)%></li>
                                    <li><%=rs.getString(3)%> & <%=rs.getString(4)%></li>
                                    <li><%=(rs.getString(5)==null)?"":rs.getString(5)%></li>
                                    <li><%=(rs.getString(6)==null)?"":rs.getString(6)%></li>
                                    <li><%=(rs.getString(7)==null)?"":rs.getString(7)%></li>
                                </ul>
                            </TD>
                        <%}
                        rs=st.executeQuery("select staff_name,qualification,user_type,designation,subjects_handled,mailid,phone_number,staff_id  from staff where user_type='HOD'");
                        if(rs.next()){
                             String path="./images/faculty/"+rs.getString("staff_id")+".jpg";
                            File file=new File(getServletContext().getRealPath("/")+path);
                            if(!file.exists())
                                path="./images/unknown.png";    
                            %>
                        <td idth="120">
                            <img width="100px" height="120px" src="<%=path%>"/>
                        </td>
                            <TD>

                                <ul style="list-style-type:none">
                                    <li style="color:brown;font-weight:bolder;"><%=rs.getString(1)%></li>
                                    <li><%=rs.getString(2)%></li>
                                    <li><%=rs.getString(3)%> & <%=rs.getString(4)%></li>
                                    <li><%=(rs.getString(5)==null)?"":rs.getString(5)%></li>
                                    <li><%=(rs.getString(6)==null)?"":rs.getString(6)%></li>
                                    <li><%=(rs.getString(7)==null)?"":rs.getString(7)%></li>
                                </ul>
                            </TD>
                        </tr>
                        <%}rs=st.executeQuery("select staff_name,qualification,user_type,designation,subjects_handled,mailid,phone_number,staff_id  from staff where user_type='Staff' or user_type='Office' or user_type='Library' or user_type='Garc' order by priority");
                        int i=0;
                        while(rs.next()){
                             String path="./images/faculty/"+rs.getString("staff_id")+".jpg";
                            File file=new File(getServletContext().getRealPath("/")+ path);
                            if(!file.exists())
                                path="./images/unknown.png";    
                            if(i%2==0)
                                out.print("<tr>");
                            i++;
                        %>
                        <td width="120">
                            <img width="100px" height="120px" src="<%=path%>"/>
                        </td>
                            <td>

                                <ul style="list-style-type:none">
                                    <li style="color:brown;font-weight:bolder;"><%=rs.getString(1)%></li>
                                    <li><%=rs.getString(2)%></li>
                                    <li><%=rs.getString(4)%></li>
                                    <li><%=(rs.getString(5)==null)?"":rs.getString(5)%></li>
                                    <li><%=(rs.getString(6)==null)?"":rs.getString(6)%></li>
                                    <li><%=(rs.getString(7)==null)?"":rs.getString(7)%></li>
                                </ul>
                            </td>
                            
                        <%
                            if(i%2==0)
                                out.print("</tr>");

                       }
                        connection.close();
                       }catch(Exception e){
                        out.print("<span class=error>"+e.toString()+"</span>");
    }%>

                    
                  </TBODY>
            </TABLE>

   
