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
    Document   : StudentDetail
    Created on : Oct 31, 2009, 3:21:54 PM
    Author     : Ramkumar
--%>
<jsp:directive.page import="java.sql.*,java.io.*"  />
<%@ include file="../../common/DBConfig.jsp" %>
<script>
    function blockStudent(object,studentid){
    //alert('hi')
    $('#status').show();
    url="./AjaxPages/Reports.jsp"
    $(object).html("Blocking...");
    $.ajax({
            type: "POST",
            url: url,
            data:"action=blockstudent&studentid="+studentid+"&rand="+Math.random(),
            success: function(msg){
                   //alert(msg)
                   $(object).html(msg);
                   //$('#tooltip').hide();
                   $('#status').html("<center>Loaded</center>");
                   t=setTimeout("clearmsg()",3000);
            }
    });
}
</script>
<%
 Connection con= DriverManager.getConnection(CONNECTION_URL,USER_NAME,PASSWORD);
 Statement st=con.createStatement();
 String sql="select * from students where student_id='"+request.getParameter("student_id")+"'";
 ResultSet rs=st.executeQuery(sql);
 if(!rs.next()){
     con.close();
     out.print("No Details Found!");
     return;
 }
String path = "/images/students/"+rs.getString("batch")+"/" + rs.getString("student_id") + ".jpg";
//out.print(path);
File file = new File(getServletContext().getRealPath("/")+ path);
if (!file.exists()) {
    path = "/images/unknown.png";
}

%>
<table>
    <tr>
        <td colspan="2"><%=rs.getString("student_name")%></td>
    </tr>
    <tr>
        <td rowspan="3"><img src="<%=path%>" height="80" width="64" /></td>
        <td>SSLC</td>
        <td><%=rs.getString("sslc")==null?"-":rs.getString("sslc")%></td>
    </tr>
    <tr><td>HSC</td><td><%=rs.getString("hsc")==null?"-":rs.getString("hsc")%></td></tr>
    <tr><td>UG</td><td><%=rs.getString("ug")==null?"-":rs.getString("ug")%></td></tr>
    <tr><td>Email Id</td><td colspan="2"><%=rs.getString("email")==null?"-":rs.getString("email")%></td></tr>
    <tr><td>Phone</td><td colspan="2"><%=rs.getString("phone")==null?"-":rs.getString("phone")%></td></tr>
    <tr><th colspan='3' onclick="blockStudent(this,'<%=rs.getString(1)%>')" bgcolor="pink" >Block Attendance</th></tr>
    <tr><th colspan='3' onclick="$('#tooltip').hide()" bgcolor="lightblue" >Close X</th></tr>
</table>
<%
con.close();
%>