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
    Created on : Sept 18, 2009, 12:05:52 AM
    Author     : RamKumar
--%>
<%

    if((session.getAttribute("usertype")==null) || (!session.getAttribute("usertype").toString().equalsIgnoreCase("student"))){
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

<jsp:directive.page import="java.sql.*"  />


    
 <div class="options" align="right">
		<a href="../common/logoutvalidation.jsp">SignOut </a> |
</div>
<div id="top_wrapper">
	<div id="banner">

	<div id="logo">
            <div class="logo1"><img src="../images/garc.png" height="80px" width="150px"/></div>


		</div>
	<div id="Search_box"><center><%=college%></center></div>
 <div class="logo2" align="right"><%=dept%></div>
    <div id="servertime" align="right">Retriving Server Time...</div>

	</div>
	<div id="menu">
		<div id="hovermenu" class="hovermenu">
			<ul id="nav">
			
			<li><a href="#" onclick="home()">Home</a></li>
                        <li><a href="#" onclick="getSubjectGrid()">Curriculum</a></li>
                        <li><a href="#" onclick="getStudentTimetable('<%=session.getAttribute("semester")%>','<%=session.getAttribute("section")%>')">TimeTable</a></li>
                        <li><a href="#" id="inboxmnu" onclick="loadInBox()">Inbox</a></li>
                    
                        <li><a href="#" onclick="window.open('../uploadedFiles/SemesterPlanner/<%=(Integer.parseInt( session.getAttribute("semester").toString() )+1)/2%>.htm')">Semester Planner</a></li>
                        <li><a href="#" onclick="Profile()">Profile</a></li>
                        <li><a href="#" onclick="QuestionBankView()">Question Bank</a></li>
                        <li><a href="../gquest/Student">GQuest</a></li>
                        <li><a href="../js/sudoku/index.html" onclick="$(this).modal({width:433, height:553}).open(); return false;" >Sudoku</a> </li>
                        </ul>
                        <div align="right" style="color:gray;margin-top:-5px;"><%@ include file="../common/SemesterSwich.jsp" %> </div>         
			<div style="clear:both"></div>
		</div>
	</div>
                       
	<div style="clear:both"></div>
        <div class="status" id="status"> Loading ... </div>
</div>
<div id="main">

 <div id="content_wrapper">
  <div id="top_div">
      <div id="report"></div>
      <div id="curriculam">Loading ...</div>
  </div>
     <div style="clear:both"></div>
</div>
</div>

<div id="footer_div" class="footer"><a href="#" onclick="home()">Home</a> | <a href="#" onclick="getSubjectGrid()">Curriculum</a> | <a href="#" onclick="getStudentTimetable('<%=session.getAttribute("semester")%>','<%=session.getAttribute("section")%>')">Time Table</a> | <a href="#" onclick="loadInBox()">Inbox</a> | <a href="#" onclick="window.open('../uploadedFiles/SemesterPlanner/<%=(Integer.parseInt( session.getAttribute("semester").toString() )+1)/2%>.htm')">Semester Planner</a> | <a href="#"  onclick="QuestionBankView()">Question Bank</a> | <a href="#" onclick="Profile()">Profile</a> | <a  href="/js/sudoku/index.html" onclick="$(this).modal({width:433, height:553}).open(); return false;" >sudoku</a>  <br />
    <br />
  <span class="copyright">Visitor Number:<%@ include file="/common/hitcount.jsp" %></span> |
  <span class="copyright">Copyright 2006-09 GARC </span></div>
                        <div id="dialog" title="Warning" style="display:none">
	<p><span class="ui-icon ui-icon-alert" style="float:left; margin:0 7px 20px 0;"></span> Are you sure you want to delete the record ?
         </p>
</div>








