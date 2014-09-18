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
    Document   : addclientansAjax
    Created on : Mar 9, 2009, 2:22:16 AM
    Author     : Administrator
--%>
<jsp:directive.page import="java.sql.*" />
<%@ include file="/common/pageConfig.jsp" %>
<%
    Connection connection = DriverManager.getConnection(CONNECTION_URL,USER_NAME,PASSWORD);
    Statement statement = connection.createStatement();
    String client_id=session.getAttribute("userid").toString();
    try{
       statement.execute("insert into user_answer values('"+client_id+"','"+request.getParameter("qno")+"','"+request.getParameter("ans")+"','"+request.getParameter("exam_id")+"')");

       out.print("Sucessfully Inserted");

    }
    catch(Exception e){
        try{statement.executeUpdate("update user_answer set user_ans='"+request.getParameter("ans")+"'  where qno='"+request.getParameter("qno")+"' and user_id='"+client_id+"'");}
        catch(Exception ex){out.print("Selection Failed: "+e.toString());}
        out.print(e.toString());
    }
	finally{
		connection.close();
	}
 %>