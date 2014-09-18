<%-- 
    Document   : display
    Created on : Nov 29, 2008, 12:56:45 PM
    Author     : mAESTRO
--%>

<jsp:directive.page import="java.sql.*"  errorPage="../exception.jsp" /> 
<%@ include file="../misc/connector.jsp" %>
<jsp:directive.page import="java.util.*" />
<style type="text/css"> 
.total-width {width:70%;} 
.red {background-color:#cccccc;margin-left:30px;} 
.green {background-color:#336600;} 
.title {display:block;float:left;padding-right:10px;} 

</style> 
<table width="180">
		<tr>
			<td width="132" align="left">POLL</td>
			<td width="16" align="right"><a href="#" onclick="$('#poll').hide()">X</a></td>
		</tr>
</table>


       <%
  Connection connection = null;
    Statement statement = null;
    Class.forName("org.gjt.mm.mysql.Driver");
    connection = DriverManager.getConnection(forum_conn);
    statement = connection.createStatement();
    statement.executeUpdate("update gpoll.result set `"+request.getParameter("option")+"` = `"+request.getParameter("option")+"` +1 where id = "+request.getParameter("id"));
    statement.executeUpdate("update gpoll.misc set user = CONCAT(user,'#','"+session.getAttribute("id")+"') where id = "+request.getParameter("id"));
    ResultSet rs=statement.executeQuery("select poll.*, result.*,`1`+`2`+`3`+`4`+`5` from gpoll.poll,gpoll.result where poll.id=result.id and poll.id="+request.getParameter("id"));
    if(!rs.next()){
        out.print("Poll Unavailable");
        return;
    }
    java.util.StringTokenizer token=new StringTokenizer(rs.getString(3),"#");
    int i=7;
    %>
    <%=rs.getString(2)%>
    <%
        while(token.hasMoreElements()){
            %>
            <div class="total-width"> 
<div class="title"><%=token.nextElement()%> :</div> 

<div class="red" style="width:100%;"> 
<div class="green" style="width:<%=(rs.getInt(i)*100)/rs.getInt(12)%>%;"> 
<span><%=(rs.getInt(i)*100)/rs.getInt(12)%>%</span>
</div> 
</div> 
</div> 
       

            <% i++;
        }
out.print("<center>Total Vote(s): "+rs.getInt(12)+"</center>"); 
connection.close();
    %>
</br>