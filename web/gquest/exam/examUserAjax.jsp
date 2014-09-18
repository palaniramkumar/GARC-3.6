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
    Document   : examUserAjax
    Created on : Mar 10, 2009, 7:19:40 PM
    Author     : Ramkumar
--%>
<script>
 function remove(user_id,examid){
                var answer = confirm("Are you want to delete ?")
                if (!answer)
                    return;
               $("#prog").html("<center><img src='/images/preload.gif'/> Loading please wait ...</center>");
               url="user_id="+user_id+"&exam_id="+examid
               $.ajax({
                            type: "POST",
                            url: "deleteExamUserAjax.jsp",
                            data: url,
                            success: function(msg){
                                $.ajax({
                                    type: "POST",
                                    url: "examUserAjax.jsp",
                                    data: "rand="+Math.random()+"&exam_id="+examid,
                                    success: function(msg){
                                        $("#userlist").html(msg)
                                        $("#prog").html("")
                                        }
                                });
                               
                           }

                        });
            }
            </script>
<table bgcolor="white" width="90%" style="margin:auto" class="theme">
    <tr>
        <th class="title_table">USER ID</th>
        <th class="title_table">NAME</th>
        
        <th class="title_table">SEMESTER</th>
        <th class="title_table">SCORE</th>
        <th class="title_table">DELETE</th>
    </tr>
<jsp:directive.page import="java.sql.*" />
<%@ include file="/common/pageConfig.jsp" %>
<%
    Connection connection = DriverManager.getConnection(CONNECTION_URL,USER_NAME,PASSWORD);
    Statement statement = connection.createStatement();
    String sql="select exam_name,DATE_FORMAT(`date`,'%d-%m-%Y') from exam_master where exam_id like '"+request.getParameter("exam_id")+"'"	;
    ResultSet rs=statement.executeQuery(sql);
    String exam_name="";
    if(rs.next())
	exam_name=rs.getString(1)+" ( "+rs.getString(2)+" )";
    sql="select user_id,student_name,'-',semester,sum(points) from gquestresult,students where exam_id='"+request.getParameter("exam_id")+"' and user_id=student_id group by user_id";
    //out.print(sql);
    rs=statement.executeQuery(sql);
 %>
    <p><i><%=exam_name%></i></p>
 <%
    boolean attended=false;
    while(rs.next()){
        attended=true;
%>
<tr>
    <td class="bodytext_table"><%=rs.getString(1)%></td>
    <td class="bodytext_table"><a href="#" onclick="takeSummery('<%=rs.getString(1)%>')"><%=rs.getString(2)%></a></td>
    
    <td class="bodytext_table"><%=rs.getString(4)%></td>
    <td class="bodytext_table"><%=rs.getString(5)%></td>
    <td class="bodytext_table"><div align="center" onclick="remove('<%=rs.getString(1)%>','<%=request.getParameter("exam_id").toString()%>')"><img src="/images/remove.png" alt="remove" width="18" height="18" /></div></td>
</tr>
<%}
    if(!attended){
        %>
        <td colspan="5"><center>No Student Attended!</center></td>
<%
}
    %>
</table>