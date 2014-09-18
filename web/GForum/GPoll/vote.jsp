<%-- 
    Document   : vote
    Created on : Nov 29, 2008, 12:56:37 PM
    Author     : Ramkumar
--%>
<jsp:directive.page import="java.sql.*"   /> 
<jsp:directive.page import="java.util.*" />
<%@ include file="../misc/connector.jsp" %>
<style type="text/css"> 
.total-width {width:70%;} 
.red {background-color:#cccccc;margin-left:30px;} 
.green {background-color:#336600;} 
.title {display:block;float:left;padding-right:10px;} 

</style> 
<%@page contentType="text/html" pageEncoding="windows-1252"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
"http://www.w3.org/TR/html4/loose.dtd">
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
    //out.print("select * from gpoll.misc where user like '%"+session.getAttribute("id")+"%' and active=0");
    ResultSet rs=statement.executeQuery("select * from gpoll.misc where user like '%"+session.getAttribute("id")+"%' and active=0");
	String check="0";
    if(rs.next())
	    check="1";

    rs.close();

    if(check.equals("1")){
        rs=statement.executeQuery("select poll.*, result.*,`1`+`2`+`3`+`4`+`5` from gpoll.poll,gpoll.result,gpoll.misc where poll.id=result.id and poll.id=misc.id and misc.active=0");
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
<div class="green" style="width:<%=(rs.getInt(12)!=0)?(rs.getInt(i)*100)/rs.getInt(12):0%>%;"> 
<span><%=(rs.getInt(12)!=0)?(rs.getInt(i)*100)/rs.getInt(12):0%>%</span>
</div> 
</div> 
</div> 
       
                <% i++;
            }
        out.print("<center>Total Vote(s): "+rs.getInt(12)+"</center>"); 
        connection.close();

%>
<br>
<%
        return;
    }

    rs=statement.executeQuery("select poll.* from gpoll.poll,gpoll.misc where poll.id=misc.id and misc.active=0");
    if(!rs.next()){
        out.print("No active poll");
        return;
    }
    int i=0;
    int poll_id=rs.getInt(1);
%>
<div class="line"><%=rs.getString(2)%></div>
<%
java.util.StringTokenizer token=new StringTokenizer(rs.getString(3),"#");
while(token.hasMoreElements()){%>
<div class="line"><input  type = "radio" name = "option" id  ="<%=++i%>" value="<%=i%>" /><label for="<%=i%>"><%=token.nextElement()%></label> </div>
<%}%>
    <input type="hidden" name="id" id="id" value="<%=poll_id%>" />
    <div class="line">    <input type="button" value="Vote &rarr;" onclick="votepoll('<%=i%>')" /></div>


