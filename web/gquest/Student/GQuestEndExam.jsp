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
    Document   : GQuestEndExam
    Created on : Jun 6, 2010, 1:56:01 PM
    Author     : Ram
--%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ include file="/common/pageConfig.jsp" %>


<%
    Connection connection = DriverManager.getConnection(CONNECTION_URL,USER_NAME,PASSWORD);
    Statement statement=connection.createStatement();
    String sql="";
    int i=0;
    String client_id=session.getAttribute("userid").toString();
%>

<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
<link type="text/css" rel="stylesheet" href="../../css/style.css" />
<link type="text/css" rel="stylesheet" href="../css/GQuest.css" />
<script src="../../js/jquery.js"></script>
<script src="../../js/garcEssentials.js"></script>
<script type="text/javascript" src="../js/jquery.countdown.js"></script>
<script defer type="text/javascript" src="../js/restrict.js"></script>
<script>
    $(document).ready( function() {
$("#login").hide();
 $('.status').hide();
$.getScript("../../common/servertime.jsp", function(){

});
 });
    function takeSummery(exam_id) {
                $("#content").html("<center><img src='../../images/preload.gif'/> Please Wait ...</center>");
                user_id="<%=client_id%>";
                $("#content").load("summeryAjax.jsp?rand="+Math.random()+"&exam_id="+exam_id+"&user_id="+user_id);
             }
  
  </script>
<style type="text/css">
    @import url(../../css/scrolling_table.css);
    @import url(../../css/credit-styles.css);
</style>
<!--[if IE]>
    <style type="text/css">
        @import url(../../css/scrolling_table.ie.css);
    </style>
<![endif]-->

<title>Garc - Quest</title>
</head>
<body>
    <div id="status" class="status">Loading ...</div>

        <div class="options" align="right">
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
                            <!--li><a href="index.jsp">Home</a></li-->
                 	</ul>

			<div style="clear:both"></div>

		</div>

	</div>
	<div style="clear:both"></div>
</div>

<div id="content_wrapper">
  
    <div id="top_div">
<%
    sql="select x.qid,x.question,x.category,x.weight,x.choice,IF(STRCMP(x.ans,y.user_ans),'negative','positive'),y.user_ans from questionset x,user_answer y where x.qid=y.qno and y.exam_id='"+request.getParameter("exam_id")+"' and user_id='"+client_id+"' and x.exam_id=y.exam_id;";
    ResultSet rs=statement.executeQuery(sql);
%>

<div id="content">
    <div style="text-align: right"><input type="button" class="ui-state-default ui-corner-all" onclick="takeSummery('<%=request.getParameter("exam_id")%>')" class="button" value="Click here to View Report >>"/></div>
<div id="result"></div>
<table class="theme" width="100%">
    <tr>
    <th >QID</th>
    <th >Question</th>
    <th >Category</th>
    <th >Point</th>
    <th >Options</th>
    <th >Answered</th>
    <th ></th>

    </tr>
<%while(rs.next()){%>
<tr>
    <td valign="top"><%=rs.getString(1)%></td>
    <td valign="top"><%=rs.getString(2)%></td>
    <td valign="top"><%=rs.getString(3)%></td>
    <td valign="top"><%=rs.getString(4)%></td>
    <td valign="top"><%=rs.getString(5).replace("#","<br>")%></td>
    <td valign="top"><%=rs.getString(7).replace("#",",")%></td>
    <td valign="top"><img src="/images/<%=rs.getString(6)%>.png" width="16px"/></td>

</tr>

<%}%>
<tr>
<td colspan="7" align="right"><input type="button" class="ui-state-default ui-corner-all" onclick="takeSummery('<%=request.getParameter("exam_id")%>')" class="button" value="Click here to View Report >>"/></td>
</tr>
</table>
<%
sql="select x.category,count(x.category),sum(x.weight) from questionset x where x.exam_id='"+request.getParameter("exam_id")+"'  group by x.category";
rs=statement.executeQuery(sql);
Connection connection_res = DriverManager.getConnection(CONNECTION_URL,USER_NAME,PASSWORD);
Statement statement_res = connection_res.createStatement();
String category="",point="0",correct="0",attended="0",total="",total_points="0";
while(rs.next()){

    category=rs.getString(1);
    total=rs.getString(2);
    total_points=rs.getString(3);
    sql="select y.category,sum(y.weight),count(*) from user_answer x,questionset y where y.ans=x.user_ans  and x.user_id='"+client_id+"' and x.exam_id='"+request.getParameter("exam_id")+"' and x.exam_id=y.exam_id and y.qid=x.qno and y.category='"+category+"' group by category";
    ResultSet rs_res=statement_res.executeQuery(sql);
    if(rs_res.next()){

	    correct=rs_res.getString(3);
	    if(rs_res.getString(2)!=null)
      	  point=rs_res.getString(2);
	    else
		  point="0";
	}
	else{
	    	point="0";
			 correct="0";
			}
    sql="select y.category,count(y.weight) from user_answer x,questionset y where x.user_id='"+client_id+"' and x.exam_id='"+request.getParameter("exam_id")+"' and x.exam_id=y.exam_id and y.qid=x.qno and y.category='"+category+"' group by category";
    rs_res=statement_res.executeQuery(sql);
    if(rs_res.next()){
	    if(rs_res.getString(2)!=null)
       	 	attended=rs_res.getString(2);
	    else
		 	attended="0";
	}
    else
	    	attended="0";

    statement_res.executeUpdate("insert into gquestresult values('"+request.getParameter("exam_id")+"','"+client_id+"','"+category+"','"+point+"','"+correct+"','"+attended+"','"+total+"','"+total_points+"')");
}
    /* delete previous client result (enable-reappear)*/
    sql="delete from user_answer where exam_id='"+request.getParameter("exam_id")+"' and user_id='"+client_id+"'";
    statement.executeUpdate(sql);
    /*--- end of deletion--*/

connection_res.close();
connection.close();

%>


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
