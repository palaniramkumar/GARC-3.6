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
    Document   : GQuestSingleExamSettings
    Created on : Jun 6, 2010, 12:05:39 AM
    Author     : Ram
--%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ include file="/common/pageConfig.jsp" %>

<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
<link type="text/css" rel="stylesheet" href="../../css/style.css" />
<link type="text/css" rel="stylesheet" href="../../css/table-style.css" />
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
   function encodeMyHtml(url) {
                encodedHtml = escape(url);
                encodedHtml = encodedHtml.replace(/\//g,"%2F");
                encodedHtml = encodedHtml.replace(/\?/g,"%3F");
                encodedHtml = encodedHtml.replace(/=/g,"%3D");
                encodedHtml = encodedHtml.replace(/&/g,"%26");
                encodedHtml = encodedHtml.replace(/@/g,"%40");
		    encodedHtml = encodedHtml.replace(/\+/g,"%2B");
                return encodedHtml;
            }
    function update_exam(id) {
                
                var exam_id="<%=request.getParameter("exam_id")%>";
                var category=encodeMyHtml(document.getElementById("category").value);
                var exam_name=encodeMyHtml(document.getElementById("exam_name").value);
                var duration=encodeMyHtml(document.getElementById("duration").value);
                var desc=encodeMyHtml(document.getElementById("desc").value);
               // document.getElementById("duration").value="updateSingleExamSettingsAjax.jsp?rand="+Math.random()+"&exam_id="+exam_id+"&category="+category+"&exam_name="+exam_name+"&duration="+duration+"&desc="+desc;
               document.getElementById(id).value="please wait ..."
                url="rand="+Math.random()+"&exam_id="+exam_id+"&category="+category+"&exam_name="+exam_name+"&duration="+duration+"&desc="+desc;
                 $.ajax({
                            type: "POST",
                            url: "updateSingleExamSettingsAjax.jsp",
                            data: url,
                            success: function(msg){
                               // alert(msg)
                                $('#result').html(msg);
                            }
                        });

                
                document.getElementById(id).value="Update"
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
if(request.getParameter("delete")!=null){
    rs.close();
    sql="select count(*) from gquestresult where exam_id='"+request.getParameter("exam_id")+"'";
    rs=statement.executeQuery(sql);
    if(rs.next())
	if(rs.getInt(1)!=0){
        %>
        <strong>Oops! </strong> Exam has already taken by some other students<br />
        <%
        return;
        }
        sql="delete from exam_master where exam_id='"+request.getParameter("exam_id")+"'";
    	statement.executeUpdate(sql);
        %><strong>Deleted </strong>  successfully<br /><%
    }
sql="select exam_name,date from exam_master where exam_id='"+request.getParameter("exam_id")+"'";
rs=statement.executeQuery(sql);
String exam_name="",date="";
if(rs.next()){
    exam_name=rs.getString(1);
    date=rs.getString(2);
    }

%>

            <h1><%=exam_name%> (<%=date%>)</h1>
<%
sql="select * from exam_master where exam_id='"+request.getParameter("exam_id")+"'";
rs=statement.executeQuery(sql);
if(!rs.next()){
    connection.close();
    return;
}

%>
<div id="content">
    <form>
<table  bgcolor="white" style="margin:auto" width="500">
    <tr>
        <td  class="title_table">Exam Name</td>
        <td><input type="text" value="<%=rs.getString(2)%>" size="50" id="exam_name" /></td>
    </tr>
    <tr>
        <td class="title_table">Category</td>
        <td><textarea id="category" rows="4" cols="40"><%=rs.getString(3)%></textarea></td>
    </tr>
    <tr>
        <td class="title_table">Duration</td>
        <td><input type="text" value="<%=rs.getInt(5)/60%>" id="duration" size="50"/></td>
    </tr>
    <tr>
        <td class="title_table">Description</td>
        <td><textarea id="desc" rows="4" cols="40"><%=rs.getString(4)%></textarea></td>
    </tr>
    <tr>
        <td colspan="2" align="center"><input type="button" value="Update" class="button" id="update" onclick="update_exam(this.id)"/>
         <input type="submit" value="Delete" class="button" name="delete"/></td>
    </tr>
</table>
<input type="hidden" name="exam_id" value="<%=rs.getString(1)%>"/>
</form>
<div id="result"></div>
  </div>
    </div>
	<div id="bottom_div">

	</div>
	<div style="clear:both"></div>
</div>
<%connection.close();%>
<div id="footer_div" class="footer">
    <br />
  <span class="copyright">Visitor Number:<%@ include file="../../common/hitcount.jsp" %></span> |
   <span class="copyright">Copyright 2008-<%=new java.util.Date().getYear()-100%> GARC </span></div>

</body>
</html>
