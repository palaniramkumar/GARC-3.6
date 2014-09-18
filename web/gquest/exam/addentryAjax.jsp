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
    Document   : addentryAjax
    Created on : Mar 7, 2009, 5:32:01 PM
    Author     : Ramkumar
--%>

<jsp:directive.page import="java.sql.*" />
<%@ include file="/common/pageConfig.jsp" %>
<%
     if(request.getParameter("qus").replaceAll("\\<.*?>","").trim().equals("") ){
                        %>
                        <script>alert("please Enter the Question");</script>
                        <%
                        return;
     }
     
     if(request.getParameter("choice").replace("#","").replaceAll("\\<.*?>","").trim().equals("") ){
                        %>
                        <script>alert("Please Enter the Answer");</script>
                        <%
                        return;
     }
     if(request.getParameter("ans").replace("#","").replaceAll("\\<.*?>","").trim().equals("") ){
                        %>
                        <script>alert("Please select the Choice");</script>
                        <%
                        return;
     }
    Connection connection = DriverManager.getConnection(CONNECTION_URL,USER_NAME,PASSWORD);
    Statement statement = connection.createStatement();
    try{
        if(request.getParameter("val").equals("0")){
            statement.execute("insert into questionset(question,choice,ans,exam_id,category,weight) values('"+request.getParameter("qus").replace("'", "''").replace("\\", "\\\\")+"','"+request.getParameter("choice").replace("'", "''").replace("\\", "\\\\")+"','"+request.getParameter("ans").replace("'", "''").replace("\\", "\\\\")+"','"+request.getParameter("exam_id").replace("'", "''")+"','"+request.getParameter("category").replace("'", "''").replace("\\", "\\\\")+"',"+request.getParameter("weight").replace("'", "''")+")");
            %>
           <strong>New Question</strong> Has been added successfully
  
            <%
            }
        else{
            statement.execute("update questionset set question= '"+request.getParameter("qus").replace("'", "''").replace("\\", "\\\\")+"',choice='"+request.getParameter("choice").replace("'", "''").replace("\\", "\\\\")+"',ans= '"+request.getParameter("ans").replace("'", "''").replace("\\", "\\\\")+"',weight='"+request.getParameter("weight").replace("'", "''")+"',category='"+request.getParameter("category").replace("'", "''").replace("\\", "\\\\")+"' where qid="+request.getParameter("val"));
        %>
        <strong>Question</strong> Has been Updated successfully
        <%
        }
    }
    catch(Exception e){
        %>
        <strong>Error!</strong> Please try again <br>Error trace: <%=e.toString()%>
      
        <%
    }
    connection.close();
 %>