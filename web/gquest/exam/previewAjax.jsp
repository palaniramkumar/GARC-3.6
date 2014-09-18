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
    Document   : previewAjax
    Created on : Mar 8, 2009, 3:18:46 PM
    Author     : Ramkumar
--%>

<script>
    function remove(qid,examid){
                var answer = confirm("Are you want to delete ?")
                if (!answer)
                    return;
               url="qid="+qid+"&exam_id="+examid+"&rand="+Math.random();
               $("#result").html("<center><img src='/images/loading.gif'/> Loading please wait ...</center>");
               $.ajax({
                            type: "POST",
                            url: "deleteentryAjax.jsp",
                            data: url,
                            success: function(msg){
                                $.ajax({
                                    type: "POST",
                                    url: "previewAjax.jsp",
                                    data: "rand="+Math.random()+"&exam_id="+examid,
                                    success: function(msg){
                                        $("#report").html(msg)
                                        $("#result").html("");
                                        }

                                });
                            }
                            
                        });
            }
</script>
<jsp:directive.page import="java.sql.*" />
<%@ include file="/common/pageConfig.jsp" %>
<%
     Connection connection = DriverManager.getConnection(CONNECTION_URL,USER_NAME,PASSWORD);
    Statement statement = connection.createStatement();
    String sql="";

%>
<%

sql="select exam_name,DATE_FORMAT(`date`,'%d-%m-%Y') from exam_master where exam_id='"+request.getParameter("exam_id")+"'";
ResultSet rs=statement.executeQuery(sql);
String exam_name="",date="";
if(rs.next()){
    exam_name=rs.getString(1);
    date=rs.getString(2);
    }

%>
<h1><%=exam_name%> ( <%=date%> )</h1>
    <table class="theme">

        <thead>

      <tr>
        <th>SNo</th>
        <th>QID</th>
        <th>Question</th>
        <th>Choice</th>
        <th>Answer</th>
        <th>Complexity</th>
        <th>Category</th>
        <th></th>
        
      </tr>
        </thead>
<%
sql="select * from questionset where exam_id='"+request.getParameter("exam_id")+"'";
rs=statement.executeQuery(sql);
int i=0;
while(rs.next()){
%>
<tbody>
      <tr>
        <td valign="top">
          <div align="left" >
            <%=++i%>
            
        </div></td>
        <td valign="top"><div align="left">#<%=rs.getString(1)%></div></td>
        <td valign="top"><pre><div align="left"><%=rs.getString(3)%></div></pre></td>
        <td valign="top"><div align="left">
		<%
		  java.util.StringTokenizer token=new java.util.StringTokenizer(rs.getString(6).trim(),"#");
		  int cntno=0;
		  while(token.hasMoreElements()){
                        String temp=token.nextElement().toString();
                        if(temp.replaceAll("\\<.*?>","").trim().equals(""))continue;
		  	out.print((++cntno)+"."+temp+"<br/>");
		  }
                  String []complex={"","Easy","","Medium","","Difficult"};
		%>
		</div></td>
        <td valign="top"><div align="left"><%=rs.getString(7).replace("#",",")%></div></td>
        <td valign="top"><div align="left"><%=complex[rs.getInt(5)]%></div></td>
        <td valign="top"><div align="left"><%=rs.getString(4)%></div></td>
        <td valign="top"><div align="center" onclick="remove('<%=rs.getString(1)%>','<%=request.getParameter("exam_id").toString()%>')"><img src="/images/remove.png" alt="remove" width="18" height="18" /></div></td>

      </tr>
      <%}connection.close();%>
</tbody>
      </table>

    