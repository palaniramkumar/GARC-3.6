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
    Document   : GQuestEditQuestion
    Created on : Jun 5, 2010, 11:15:32 PM
    Author     : Ram
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
   "http://www.w3.org/TR/html4/loose.dtd">

<%@ include file="/common/pageConfig.jsp" %>

<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
<link type="text/css" rel="stylesheet" href="../../css/style.css" />
<link type="text/css" rel="stylesheet" href="../../css/table-style.css" />
<link type="text/css" rel="stylesheet" href="../css/GQuest.css" />
<script src="../../js/nicEdit.js"></script>
<script src="../../js/jquery.js"></script>
<script src="../../js/garcEssentials.js"></script>
<script>
    $(document).ready( function() {
$("#login").hide();
 $('.status').hide();
$.getScript("../../common/servertime.jsp", function(){

});
$("#data").html("<center><img src='/images/preload.gif'/>Please Wait...</center>");
                loadTemplate();
 });
              function encodeMyHtml(url) {
                encodedHtml = escape(url);
                encodedHtml = encodedHtml.replace(/\//g,"%2F");
                encodedHtml = encodedHtml.replace(/\?/g,"%3F");
                encodedHtml = encodedHtml.replace(/=/g,"%3D");
                encodedHtml = encodedHtml.replace(/&/g,"%26");
                encodedHtml = encodedHtml.replace(/@/g,"%40");
                encodedHtml = encodedHtml.replace(/\+/g,"%2B");
  				encodedHtml = encodedHtml.replace(/\</g,"%3C");
				encodedHtml = encodedHtml.replace(/\>/g,"%3E");
                return encodedHtml;
            }

            function add(val){
                var qus=encodeMyHtml(nicEditors.findEditor("question").getContent());
                var cat=document.getElementById("category").value;
                var wt=document.getElementById("weight").value;
                var choice=""
                for (var i = 1; i <=5;i++){
                        choice+=encodeMyHtml(nicEditors.findEditor('c'+i).getContent())+"#";
                }
                var ans="";
                for (var i = 1; i <=5;i++){
                    if(document.getElementById("ans"+i).checked==true)
                        ans+=document.getElementById("ans"+i).value+"#";
                }
                //var ans=document.getElementById("ans1").value+"#"+document.getElementById("ans2").value+"#"+document.getElementById("ans3").value+"#"+document.getElementById("ans4").value+"#"+document.getElementById("ans5").value
		
                var exam_id="<%=request.getParameter("exam_id")%>";
                var url="qus="+qus+"&choice="+choice+"&ans="+ans+"&rand="+Math.random()+"&val="+val+"&exam_id="+exam_id+"&weight="+wt+"&category="+cat
                         $("#result").html("<center><img src='../../images/loading2.gif'/> Loading please wait ...</center>");
                        $.ajax({
                            type: "POST",
                            url: "addentryAjax.jsp",
                            data: url,
                            success: function(msg){
                                $('#result').html(msg);
                                if(val!=0){
                                    load(val)
                                }
                            }
                        });
                        if(val==0){
                            document.all.pat.reset();
                        }
            }
            function loadTemplate(){
                 var exam_id="<%=request.getParameter("exam_id")%>";
                //$("#result").html("<center><img src='/images/loading2.gif'/> Loading please wait ...</center>");
                $.ajax({
                            type: "POST",
                            url: "edittemplateAjax.jsp",
                            data:"rand="+Math.random()+"&exam_id="+exam_id,
                            success: function(msg){
                                $('#data').html(msg);
                                $("#result").html("");
                                nicEditors.allTextAreas({iconsPath : '../../js/nicEditorIcons.gif',buttonList : ['fontSize','bold','italic','underline','strikeThrough','subscript','superscript']})
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
<%           sql="select exam_name,DATE_FORMAT(`date`,'%d-%m-%Y') from exam_master where exam_id='"+request.getParameter("exam_id")+"'";
rs=statement.executeQuery(sql);
String exam_name="",date="";
if(rs.next()){
    exam_name=rs.getString(1);
    date=rs.getString(2);
    }
connection.close();
%>

            <h1><%=exam_name%> (<%=date%>)</h1>

<div id="content">
    <form>
      <div id="data"></div>
      <div id="result"></div>
    </form>


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
