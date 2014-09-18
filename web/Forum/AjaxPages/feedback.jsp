<%-- 
    Document   : feedback
    Created on : Oct 21, 2009, 4:26:37 PM
    Author     : Ramkumar
--%>
 <jsp:directive.page import="java.sql.*"  />
<jsp:directive.page import="java.util.*" />
<%@ include file="../../common/DBConfig.jsp" %>
<%
        if(request.getParameter("title")!=null){
            Connection connection = null;
            Statement statement = null;
            Class.forName("org.gjt.mm.mysql.Driver");
            ConnectionPool pool = (ConnectionPool) application.getAttribute("pool");
            connection = pool.getConnection();
            statement = connection.createStatement();
            statement.executeUpdate("insert into mail values(null,'"+session.getAttribute("userid")+"','"+request.getParameter("title")+"','1','"+request.getParameter("desc")+"',now(),'','UNREAD')");
            //out.print("insert into mail values(null,'"+session.getAttribute("userid")+"','"+request.getParameter("title")+"','1','"+request.getParameter("desc")+"',now(),'',null)");
            connection.close();
            out.print("Message Sent...");
            return;
        }
    %>
     <div style="background-color:White;padding:10px;">



    <form method=get action='#'>
        <p><strong>TITLE </strong><br/>
            <input type="text" name="title"  id="title" size=40 maxlength=150  />
            <P><strong>DESCRIPTION:</strong><br/>
        <textarea name="desc" id="desc" rows=8 cols=40 wrap=virtual></textarea></p>
            <P> <input type="button" name="submit" value="Add Post" onclick="sendfeedback()" /> </p>

     </form>
 </div>