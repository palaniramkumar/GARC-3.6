<%-- 
    Document   : home
    Created on : Oct 20, 2009, 4:22:40 PM
    Author     : Ramkumar
--%>

<%

    if(session.getAttribute("userid")==null){
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
String sql;
if(session.getAttribute("usertype").toString().equalsIgnoreCase("student"))
    sql="select student_name from students where student_id='"+session.getAttribute("userid")+"'";
else
    sql="select staff_name from staff where staff_id='"+session.getAttribute("userid")+"'";
ResultSet rs = null;
Connection connection = null;
Statement statement = null;
connection = DriverManager.getConnection(CONNECTION_URL,USER_NAME,PASSWORD);
statement = connection.createStatement();
rs=statement.executeQuery(sql);
if(rs.next())
    session.setAttribute("name",rs.getString(1));
connection.close();
%>
<div style="background-color:White;padding:10px;width:600px;">
 
   <h2>Welcome <%=session.getAttribute("name")%>!</h2>
        <p>Hi, welcome to the GForum.People participating in an Intranet forum can build bonds with each other and interest groups will easily form around a topic's discussion, subjects dealt with in or around sections in the forum.

</p>
        <p></p>
    </div>