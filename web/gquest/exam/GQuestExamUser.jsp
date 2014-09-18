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
    Document   : GQuestExamUser
    Created on : Jun 6, 2010, 1:17:04 AM
    Author     : Ram
--%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ include file="../../common/pageConfig.jsp" %>

<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
<link type="text/css" rel="stylesheet" href="../../css/style.css" />
<link type="text/css" rel="stylesheet" href="../../css/table-style.css" />
<link type="text/css" rel="stylesheet" href="../css/GQuest.css" />
<script src="../../js/jquery.js"></script>
<link type="text/css" rel="stylesheet" href="../../css/redmond/jquery-ui.css" />
<script src="../../js/jquery-ui.js"></script>

<script src="../../js/garcEssentials.js"></script>
<script>
    $(document).ready( function() {
$("#login").hide();
 $('.status').hide();
 
$.getScript("../../common/servertime.jsp", function(){

});
      $("#userlist").html("<center><img src='/images/preload.gif'/> Loading please wait ...</center>");
        var exam_id="<%=request.getParameter("exam_id")%>";
        $("#userlist").load("examUserAjax.jsp?rand="+Math.random()+"&exam_id="+exam_id)
        
 });

      function takeSummery(user_id){
          
        
        $("#report").html("<center><img src='../../images/preload.gif'/> Loading please wait ...</center>");
        exam_id="<%=request.getParameter("exam_id")%>";
        url="exam_id="+exam_id+"&user_id="+user_id+"&rand="+Math.random();
        $('#report').dialog({
                        height: 440,
                        width : 600,
			modal: true
                    });
        $.ajax({
                    type: "POST",
                    url: "../Student/summeryAjax.jsp",
                    data: url,
                    success: function(msg){
                        
                        $("#report").html(msg)
                        
                    }
                });

        

    }

  </script>

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
                            <li onclick="window.location='GQuestAddQuestion.jsp?exam_id=<%=request.getParameter("exam_id")%>'"><a><img src="../../images/add.png" height="12px"/> Add</a></li>
                            <li onclick="window.location='GQuestEditQuestion.jsp?exam_id=<%=request.getParameter("exam_id")%>'"><a><img src="../../images/edit.png" height="12px"/> Edit</a></li>
                            <li onclick="window.location='GQuestShowResult.jsp?exam_id=<%=request.getParameter("exam_id")%>'"><a><img src="../../images/statistic.png" height="12px"/> Statistics</a></li>
                            <li onclick="window.location='GQuestSingleExamSettings.jsp?exam_id=<%=request.getParameter("exam_id")%>'"><a><img src="../../images/settings.png" height="12px"/> Settings</a></li>
                            <li onclick="window.location='GQuestExamUser.jsp?exam_id=<%=request.getParameter("exam_id")%>'"><a><img src="../../images/user.png" height="12px"/> Users</a></li>
                            <li onclick="window.location='GQuestPreviewExam.jsp?exam_id=<%=request.getParameter("exam_id")%>'"><a><img src="../../images/preview.png" height="12px"/> Preview</a></li>

                 	</ul>

                         <div align="right" style="color:gray;margin-top:-5px;"><%@ include file="../../common/SemesterSwich.jsp" %></div>
			<div style="clear:both"></div>

		</div>

	</div>
	<div style="clear:both"></div>
</div>

<div id="content_wrapper">
<%@ include file="SidePanel.jsp" %>

    <div id="top_div" style="width: 680px;float: left">
<%
connection.close();
%>

            


<div id="content">
<h3>Exam User's List</h3>
<div id="prog"></div>
<div id="userlist"></div>
</div>
<div id="report" title="Report" ></div>

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
