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
    Document   : GQuestClientExam
    Created on : Jun 6, 2010, 3:38:20 AM
    Author     : Ram
--%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ include file="../../common/pageConfig.jsp" %>
<link type="text/css" rel="stylesheet" href="../../css/redmond/jquery-ui.css" />

<%
    Connection connection = DriverManager.getConnection(CONNECTION_URL,USER_NAME,PASSWORD);
    Statement statement=connection.createStatement();
    String sql="";
    int i=0;
    String client_id=session.getAttribute("userid").toString();

    sql="select exam_id from gquestresult where exam_id='"+request.getParameter("exam_id")+"' and user_id='"+client_id+"'";
    ResultSet rs=statement.executeQuery(sql);
    if(rs.next()){
        %>

        <div  class="ui-widget-content ui-corner-all" style="margin: auto;">
            <div class="ui-widget-header ui-corner-all" style="padding-left: 10px">Error Message</div>
            <p style="padding-left: 40%">
			<strong>Oops!</strong> You have attended this exam already
		</p>
	</div>


        <%
        connection.close();
        return;
        }


    sql="select exam_name,duration from exam_master where exam_id='"+request.getParameter("exam_id")+"'";
    rs=statement.executeQuery(sql);
    if(!rs.next())
        return;
    int time=rs.getInt(2);
    String exam_name=rs.getString(1);

    /* delete previous client result (enable-reappear)*/
    sql="delete from user_answer where exam_id='"+request.getParameter("exam_id")+"' and user_id='"+client_id+"'";
    statement.executeUpdate(sql);
    /*--- end of deletion--*/

    sql="select count(*) from questionset where exam_id='"+request.getParameter("exam_id")+"'";
    rs=statement.executeQuery(sql);
    if(!rs.next())
        return;
    int total_question=rs.getInt(1);
    sql="select qid from questionset where exam_id='"+request.getParameter("exam_id")+"'";
    rs=statement.executeQuery(sql);
%>

<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
<link type="text/css" rel="stylesheet" href="../../css/style.css" />
<link type="text/css" rel="stylesheet" href="../css/GQuest.css" />
<link type="text/css" rel="stylesheet" href="../../css/table-style.css" />
<script src="/js/jquery.js"></script>
<script src="/js/garcEssentials.js"></script>
<script type="text/javascript" src="../js/jquery.countdown.js"></script>
<script defer type="text/javascript" src="../js/restrict.js"></script>
<script>
    $(document).ready( function() {
$("#login").hide();
 $('.status').hide();
$.getScript("../../common/servertime.jsp", function(){

});
 });
  </script>
<script>
$(document).ready(function() {
   var exam_id=<%=request.getParameter("exam_id")%>
   $.getScript("js/randomscript.jsp?exam_id="+exam_id, function(){
       randomize();
       $('#timer').countdown({until: +<%=time%> , onTick: CheckExpire,compact: true});
        $("#result").html("<center><img src='../../images/preload.gif'/> Please Wait ...</center>");
       qdisplay('1');
   });
});


</script>

<title>Garc - Quest</title>
</head>
<body>
    <div id="status" class="status">Loading ...</div>

        <div class="options" align="right">
		<a href="#" ></a> 
	</div>
<div id="top_wrapper">
	<div id="banner">


	<div id="logo">
             <div class="logo1"><img src="../../images/garc.png" height="80px" width="150px;"/></div>
        </div>
	<div id="Search_box"><center><%=college%></center></div>
    <div class="logo2" align="right"><%=dept%></div>
    <div id="servertime" align="right">Retriving Server Time...</div>

	</div>
	<div id="menu">
		<div id="hovermenu" class="hovermenu">
			<ul>
                            <li ><a>Remaining Time: </a><a href="#" id="timer">Loading ...</a></li>
                 	</ul>

			<div style="clear:both"></div>

		</div>

	</div>
	<div style="clear:both"></div>
</div>

<div id="content_wrapper">
  <div id="left" style="height: auto">
        <h2>Questions</h2>
        <table class="theme" cellspacing="2">
<%


    for( i=0;i<total_question;i++){
	if(i%3==0)
		out.println("<tr>");
%>


            <td style=""><a href="#" onclick="qdisplay('<%=i+1%>')" > #<%=i+1%></a></td>


        <%}connection.close();%>
      </table>

    </div>

    <div id="top_div" style="width: 680px;float: left">

<div id="content">
<h3><%=exam_name%></h3>
<div id="result"></div>


</div>

  </div>
	<div id="bottom_div">

	</div>
	<div style="clear:both"></div>
</div>

<div id="footer_div" class="footer">
    <br />
  <span class="copyright">Visitor Number:<%@ include file="../../common/hitcount.jsp" %></span> |
   <span class="copyright">Copyright 2008-<%=new java.util.Date().getYear()-100%> GARC </span></div>

</body>
</html>
