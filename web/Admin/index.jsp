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
    Document   : index
    Created on : July 20, 2009, 10:12:04 PM
    Author     : Dinesh Kumar
--%>
<%

    if((session.getAttribute("usertype")==null) || (!session.getAttribute("usertype").toString().equalsIgnoreCase("admin"))){
        %>
        <script>
            alert("Session Expired");
            window.location="../";
        </script>
        <%
        return;
    }
 %>
<%@ include file="../common/pageConfig.jsp" %>
<%@ page errorPage="../common/errorPage.jsp"%>
<jsp:directive.page import="java.sql.*"  />
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
<link type="text/css" rel="stylesheet" href="../css/style.css" />
<script src="../js/jquery.js"></script>
<link type="text/css" rel="stylesheet" href="../css/FileBrowser.css" />
<script src="../js/FileBrowser.js"></script>
<script src="../js/garcEssentials.js"></script>
<script src="js/admin.js"></script>
<title>Welcome Administrator [ GARC ]</title>
<script>
   $(document).ready( function() {
        var url="../Faculty/AjaxPages/welcome.jsp";
        $('#status').show();
        $('#status').html("<center><img src='../images/loading.gif'/>Loading Welcome Page</center>");

        $.ajax({
                        type: "POST",
                        url: url,
                        success: function(msg){
                             $('#right').html(msg);
                             smartColumns(200,250);
                             loadSoftware();
                             $('#status').html("<center>Loaded Successfully</center>");
                             t=setTimeout("clearmsg()",3000);
                        }

        });
    });
</script>
</head>
<body>
    <div class="options" align="right">
       
        <a href="AdminProfile.jsp">Settings</a> |
        <a href="MyDocument.jsp">My Documents</a> |
        <a href="../common/logoutvalidation.jsp">SignOut</a>
        
    </div>
<div id="top_wrapper">
	<div id="banner">
	<div id="logo">
             <div class="logo1"><img src="../images/garc.png" height="80px" width="150px;"/></div>
        </div>
	<div id="Search_box"><center><%=college%></center></div>
    <div class="logo2" align="right"><%=dept%></div>
    <div id="servertime" align="right">Retriving Server Time...</div>
	</div>
	<div id="menu">
		<div id="hovermenu" class="hovermenu">
			<ul>
                            <li><a>Home</a></li>
                            <li><a href="DepartmentSettings.jsp">Course Details</a></li>
                            <li><a href="AddStaff.jsp">Staff Entry</a></li>
                            <li><a href="AddStudent.jsp">Student Entry</a></li>
                            <li><a href="AddSubject.jsp">Subject Entry</a></li>
                            <li><a href="ElectiveStudents.jsp">Elective</a></li>
                            <li><a href="SemesterPlanner.jsp">Semester Planner</a></li>
                            <li><a href="QuestionBank.jsp">Question Bank</a></li>
                            <li><a href="inbox.jsp">Inbox</a></li>
                        </ul>
			<div style="clear:both"></div>
		</div>
	</div>
	<div style="clear:both"></div>
</div>
<div id="status" class="status"></div>

<div id="content_wrapper">
    <p align="right"><a href="Browser.jsp" style="text-decoration: none;color: red;font-weight: bolder">File Explorer</a></p>
 	<div id="top_div">
		<div id="right">

			<h3>Welcome</h3>
			<div align="justify" style="border-bottom:1px dotted #C5CBCC; border-top:1px dotted #C5CBCC; padding-top:10px; padding-bottom: 10px; margin-bottom:5px;">Loading...
			</div>
			
		</div>

		<div style="clear:both"></div>
	</div>
	<div style="clear:both"></div>
</div>

                            <div id="footer_div" class="footer">
                                <a href="index.jsp">Home</a> |
                                <a href="DepartmentSettings.jsp">Course Details</a> |
                                <a href="AddStaff.jsp">Staff Entry</a> |
                                <a href="AddStudent.jsp">Student Entry</a> |
                                <a href="AddSubject.jsp">Subject Entry</a> |
                                <a href="ElectiveStudents.jsp">Elective</a> |
                                <a href="AdminProfile.jsp">Profile</a> |
                                <a href="MyDocument.jsp">My Documents</a> <br />
                                <br />
  <span class="copyright">Visitor Number:<%@ include file="../common/hitcount.jsp" %></span> |
  <span class="copyright">Copyright 2006-09 GARC </span></div>

</body>
</html>

