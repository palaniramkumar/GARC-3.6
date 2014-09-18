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
    Document   : ShowStaff
    Created on : July 20, 2009, 5:53:04 PM
    Author     : Dinesh Kumar
--%>
<%

    if((session.getAttribute("usertype")==null) || (!session.getAttribute("usertype").toString().equalsIgnoreCase("admin"))){
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

        if(request.getParameter("action").toString().equals("view")){
            String sql="select year,semester,sectioncount,no_of_electives,grade from section";
            //out.print(sql);
            ResultSet rs=st.executeQuery(sql);
            %>
            <table id="hor-minimalist-b">
                <tr>
                <th>Year</th>
                <th>Semeter</th>
                <th>No Of Section(s)</th>
                <th>Elective</th>
                <th>Grade System</th>

                </tr>
                <%
            while(rs.next()){
            %>
            <tr>
                <td><%=rs.getString(1)%></td>
                <td><%=rs.getString(2)%></td>
                <td><%=rs.getString(3)%></td>
                <td><%=(rs.getString(4).equals("0"))?"None":rs.getString(4)%></td>
                <td><%=(rs.getString(5).equals("YES"))?"YES":"NO"%></td>
                <td><ul class="action">
                <li onclick="DeleteDept('<%=rs.getString(1)%>')" class="delete"><a>Trash</a></li>
                <li onclick="EditDept('<%=rs.getString(1)%>')" class="edit"><a href="#">Edit</a></li>

                </ul>
            </td>
            </tr>
            <%
            }%>
            </table><%
        }
        else if(request.getParameter("action").toString().equals("delete")){
            String sql="delete from section where year="+request.getParameter("year");
            int rec=st.executeUpdate(sql);
            if(rec>0)
                out.print("<span class=error>Updated...</span>");
            else
                out.print("<span class=error>No Change...</span>");
        }

           else if(request.getParameter("action").toString().equals("update")){
            String sql="update section set semester='"+request.getParameter("semester")+"',sectioncount='"+request.getParameter("section")+"',no_of_electives='"+request.getParameter("elective")+"',grade='"+request.getParameter("grade")+"' where year="+request.getParameter("year");
            out.print(sql);
            int rec=st.executeUpdate(sql);
            if(rec>0)
                out.print("Updated...");
            else
                out.print("No Change...");
        }  else if(request.getParameter("action").toString().equals("editview")){
            String sql="select year,semester,sectioncount,no_of_electives,grade from section where year="+request.getParameter("year");
            ResultSet rs=st.executeQuery(sql);
            if(rs.next()){

            %>
            <table style="margin:auto" cellspacing="2" cellpadding="1" width="50%" id="form">
                <thead>
                    <tr>
                        <th>Year</th>
                        <th><%=request.getParameter("year")%></th>
                    </tr>
                </thead>
                <tbody>
                     <tr>
                        <th>Semester</th>
                        <td><select id="editsem" name="editsem" class="required">
                                    <option value="selectone">Please Select...</option>
                                    <%for(int i=1;i<=NO_OF_YEARS*2;i++){%>
                                    <option value="<%=i%>" <%=(rs.getInt(2)==i)?"selected":""%>><%=i%></option>
                                                <%}%>
                            </select> </td>
                    </tr>
                    <tr>
                        <th>Section</th>
                        <td><select id="editsection" name="editsection" class="required" >
                                    <option value="selectone">Please Select...</option>
                                    <%for(int i=1;i<=NO_OF_SECTIONS;i++){%>
                                    <option value="<%=i%>" <%=(rs.getInt(3)==i)?"selected":""%>><%=i%></option>
                                                <%}%>
                            </select> </td>
                    </tr>
                    <tr>
                        <th>No of Electives</th>
                        <td><select id="editelective" name="editelective" title="Choose the title">
                                    <option value="0">None</option>
                                    <%for(int i=1;i<=20;i++){%>
                                    <option value="<%=i%>" <%=(rs.getInt(4)==i)?"selected":""%>><%=i%></option>
                                                <%}%>
                            </select> </td>
                    </tr>
                   <tr>
                           <th>Grade System</th>
                           <td><input name="editgrade" id="editgrade" type="checkbox" <%=(rs.getString(5).equals("YES"))?"checked":""%> value="YES"/>YES</td>
                   </tr>
                    
                </tbody>
            </table>
                    <center><input type="button" value="Update" name="update" onclick="UpdateDept('<%=request.getParameter("year")%>')"/></center>
             <%
           }
            else
                out.print("No Record Found!");
        }
        connection.close();

  }
    catch(Exception e){
        out.print("<span class=error>"+e.toString()+"</span>");
    }

%>