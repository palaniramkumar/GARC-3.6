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
    Document   : GQuestSettings
    Created on : Jun 6, 2010, 2:27:11 AM
    Author     : Ram
--%>


<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ include file="/common/pageConfig.jsp" %>

<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
<link type="text/css" rel="stylesheet" href="../../css/style.css" />
<link type="text/css" rel="stylesheet" href="../../css/redmond/jquery-ui.css" />
<link type="text/css" rel="stylesheet" href="../css/GQuest.css" />
<script src="../../js/jquery.js"></script>
<script src="../../js/garcEssentials.js"></script>
<script>
    $(document).ready( function() {
$("#login").hide();
 $('.status').hide();
$.getScript("../../common/servertime.jsp", function(){

});
  
    });

    function selectExam(id){
        $("#result").html("<center><img src='../../images/loading.gif'/> Loading please wait ...</center>");
        if(document.getElementById(id).checked)
            url="exam_id="+id+"&active=1&rand="+Math.random()
        else
            url="exam_id="+id+"&active=0&rand="+Math.random()
                    $.ajax({
                            type: "POST",
                            url: "setActiveAjax.jsp",
                            data: url,
                            success: function(msg){
                                //alert(msg)
                                $('#result').html(msg);
                            }
                        });

    }
</script>
<style type="text/css">
    @import url(../../css/scrolling_table.css);
    @import url(../../css/credit-styles.css);
</style>
<!--[if IE]>
    <style type="text/css">
        @import url(css/scrolling_table.ie.css);
    </style>
<![endif]-->

<title>Garc - Quest</title>
</head>
<body>
    <div id="status" class="status"><img src='../../images/loading.gif'/> Loading please wait ...</div>

        <div class="options" align="right">
		<a href="../../Faculty/" > Faculty Desk </a> | <a href="../../common/logoutvalidation.jsp" >Logout </a>
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
                            <li onclick="window.location='index.jsp'"><a>Home</a></li>
                 	</ul>

                         <div align="right" style="color:gray;margin-top:-5px;"><%@ include file="/common/SemesterSwich.jsp" %></div>
			<div style="clear:both"></div>

		</div>

	</div>
	<div style="clear:both"></div>
</div>

<div id="content_wrapper">
<%@ include file="SidePanel.jsp" %>

    <div id="top_div" style="width: 680px;float: left">



<div id="content">
    <h3>Enable/Disable Exams</h3>
    <table style="margin:auto" class="theme">
        <tr>
            <th width="100px">Enable/Disable</th>
    <th>#</th>
    <th>Exam Name </th>
    <th>Date </th>
</tr>
<%
sql="select exam_name,DATE_FORMAT(`date`,'%d-%m-%Y'),exam_id,if(active=1,'checked','') from exam_master where facid='"+sFacultyID+"' order by `date` desc";
rs=statement.executeQuery(sql);
i=0;
while(rs.next()){
%>
<tr>
    <td><input type="checkbox" id="<%=rs.getString(3)%>"  <%=rs.getString(4)%> onclick="selectExam(this.id)" /></td>
    <td><%=++i%></td>
    <td><%=rs.getString(1)%> </td>
     <td><%=rs.getString(2)%> </td>
</tr>
<%}%>
</table>
<div id="result"></div>
</div>
    </div>
	<div id="bottom_div">

	</div>
	<div style="clear:both"></div>
</div>
<%
connection.close();
%>

<div id="footer_div" class="footer">
    <br />
  <span class="copyright">Visitor Number:<%@ include file="../../common/hitcount.jsp" %></span> |
   <span class="copyright">Copyright 2008-<%=new java.util.Date().getYear()-100%> GARC </span></div>

</body>
</html>
