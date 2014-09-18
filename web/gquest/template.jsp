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
    Document   : template
    Created on : Jun 2, 2010, 11:23:04 PM
    Author     : Ram
--%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ include file="/common/pageConfig.jsp" %>

<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
<link type="text/css" rel="stylesheet" href="/css/style.css" />
<link type="text/css" rel="stylesheet" href="/css/table-style.css" />
<script src="/js/jquery.js"></script>
<script src="/js/garcEssentials.js"></script>
<script>
    $(document).ready( function() {
$("#login").hide();
 $('.status').hide();
$.getScript("/common/servertime.jsp", function(){

});
 });
  </script>
<style type="text/css">
    @import url(css/scrolling_table.css);
    @import url(css/credit-styles.css);
</style>
<!--[if IE]>
    <style type="text/css">
        @import url(css/scrolling_table.ie.css);
    </style>
<![endif]-->

<title>Garc - Quest</title>
</head>
<body>
    <div id="status" class="status">Loading ...</div>

        <div class="options" align="right">
		<a href="#" >Logout </a> |
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
                            <li><a href="index.jsp">Home</a></li>
                 	</ul>

                         <div align="right" style="color:gray;margin-top:-5px;"><%@ include file="/common/SemesterSwich.jsp" %></div>
			<div style="clear:both"></div>

		</div>

	</div>
	<div style="clear:both"></div>
</div>

<div id="content_wrapper">
  <div id="left" style="height: auto">
        <h2>Main Navigation</h2>
        <p>Add Quest</p>
        <p>Settings</p>
        <h3>Latest Quest</h3>
    </div>

    <div id="top_div" style="width: 680px;float: left">


            <h1>Welcome to GARC</h1>
            <div align="justify" style="border-bottom:1px dotted #D3D4D5; padding-bottom:10px;">
            <p align="justify" class="style1" id="plaintext">Recognizing   that currently multiple dissimilar repositories exist at SoMCA to share,   transfer and maintain academic information, course material, course management   review and realizing the need to use IT based solution to deal with this   situation, GARC has evolved. </p>
            <p align="justify" class="style1" id="plaintext">The   system is meant to create and maintain academic information with a view to assisting students &nbsp; - &nbsp; <strong id="website">Graduate   Academic Resource Center (GARC). </strong></p>
            <p id="plaintext"><strong>GARC Users </strong></p>
            <p  id="plaintext"><strong>Administrator: </strong>Creates users and sets privileges.</p>
            <p  id="plaintext"><strong>Head of the Department: </strong>Sets timetable, schedules   internal tests, allocates subjects.</p>
            <p  id="plaintext"><strong>Faculty Members: </strong>Manage courses, update attendance   and internal marks.</p>
            <p  id="plaintext"><strong>Students: </strong>Can view announcements, attendance,   internal marks and download course materials.</p>

		</div>

  </div>
	<div id="bottom_div">

	</div>
	<div style="clear:both"></div>
</div>

<div id="footer_div" class="footer"><a href="index.jsp">Home</a> | <a href="#" onclick="ResourceSearch()">Resources</a> | <a href="#"  onclick="ArticleSearch()">Article</a>| <a href="#" onclick="FacultyProfile()">Faculty Profile</a> | <a href="#" onclick="guidlines()">Guidelines</a> | <a href="#" onclick="StudentProfile()">Student Profile</a>  <br />
    <br />
  <span class="copyright">Visitor Number:<%@ include file="../../common/hitcount.jsp" %></span> |
   <span class="copyright">Copyright 2008-<%=new java.util.Date().getYear()-100%> GARC </span></div>

</body>
</html>
