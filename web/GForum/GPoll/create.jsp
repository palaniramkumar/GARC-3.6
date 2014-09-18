<%-- 
    Document   : create
    Created on : Nov 29, 2008, 12:56:22 PM
    Author     : mAESTRO
--%>
<jsp:directive.page import="java.sql.*" />
<jsp:directive.page import="java.util.*" />
<%@page contentType="text/html" pageEncoding="windows-1252"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
   "http://www.w3.org/TR/html4/loose.dtd">
<%
if(request.getParameter("Question")!=null){
    Connection connection = null;
    Statement statement = null;
    Class.forName("org.gjt.mm.mysql.Driver");
    connection = DriverManager.getConnection("jdbc:mysql://localhost:3306/gpoll", "root", "garc@somca");
    statement = connection.createStatement();
    int day=7;
    String ques=request.getParameter("Question").toUpperCase();
    String ans="";
    int i=0;
    while(request.getParameter((++i)+"")!=null){
        ans+=request.getParameter(i+"").toString()+"#";
    }
    statement.executeUpdate("insert into poll values(null,'"+ques+"','"+ans+"',now(),'"+day+"')");
    statement.executeUpdate("insert into result (id) (select max(id) from poll)");
    statement.executeUpdate("insert into misc (id,user) (select max(id) from poll,'#')");
    connection.close();
}

%>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=windows-1252">
        <title>Create Poll</title>
    </head>
    <body>
    <form action="#">
    Q:<textarea name="Question" rows="4" cols="20"></textarea><br>
    <input type="text" name="1" value="" /><br>
    <input type="text" name="2" value="" /><br>
    <input type="text" name="3" value="" /><br>
    <input type="text" name="4" value="" /><br>
    <input type="text" name="5" value="" /><br>
        <input type="submit" value="submit" />
</form>
    </body>
</html>
