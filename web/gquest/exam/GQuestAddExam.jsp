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
    Document   : GQuestAddExam
    Created on : Jun 2, 2010, 11:26:46 PM
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
                            <li onclick="window.location='index.jsp'"><a ><img src="../../images/home.png" height="12px"/> Home</a></li>
                 	</ul>

                         <div align="right" style="color:gray;margin-top:-5px;"><%@ include file="../../common/SemesterSwich.jsp" %></div>
			<div style="clear:both"></div>

		</div>

	</div>
	<div style="clear:both"></div>
</div>
<%
int result=0;
Connection __connection=DriverManager.getConnection(CONNECTION_URL,USER_NAME,PASSWORD);
   try{
       if(request.getParameter("examname")!=null){
            String _sql="insert into exam_master (exam_name,category,`desc`,duration,`date`,facid) values('"+request.getParameter("examname").replace("'", "''").replace("\\", "\\\\")+"','"+request.getParameter("category").replace("'", "''").replace("\\", "\\\\")+"','"+request.getParameter("desc").replace("'", "''").replace("\\", "\\\\")+"','"+Integer.parseInt(request.getParameter("duration"))*60+"',CURDATE(),'"+session.getAttribute("userid")+"')";
            Statement __statement=__connection.createStatement();
            result=__statement.executeUpdate(_sql);
            
        }
   }
   catch(Exception e){
   %>
   <strong>Error Trace!</strong> <%=e.toString()%><br/>
       <%
   }
__connection.close();
%>

<div id="content_wrapper">
    
  <%@ include file="SidePanel.jsp" %>
    <div id="top_div" style="width: 680px;float: left">
<%

    
    sql="select exam_id,exam_name from exam_master where facid='"+sFacultyID+"'";
    %>
        <form>
            <h1>Create New Quest</h1>
            <div align="justify" style="border-bottom:1px dotted #D3D4D5; padding-bottom:10px;">
                <table width="520" border="0" >
    
    <tr>
      <td bgcolor="#FFFFFF">
<table width="470" cellpadding="5"  cellspacing="2" >
<tr>
<th>Exam Name</th>
<td><input type="text" size="25" name="examname" id="examname"/></td>
</tr>
<tr>
<th>Category</th>
<td><textarea name="category" cols="20" id="category"></textarea></td>
</tr>
<tr>
<th>Description</th>
<td><textarea cols="20" name="desc" id="desc"></textarea></td>
</tr>
<tr>
<th>Duration</th>
<td><input type="text" size="10" name="duration" id="duration"/> Min</td>
</tr>
</table>
      </td>
    </tr>
    <tr>
    <td colspan="2" align="center"><input type="button" class="button" value="Create"  onclick="submit()"/></td>
    </tr>
  </table>
                <%
                if(result==1 &&( request.getParameter("examname")!=null)){
                %>
<strong><%=request.getParameter("examname")%>!</strong> Has been created successfully<br />
               <%
                }
            else if(( request.getParameter("examname")!=null)){
                %>
                <strong>Error!</strong> Please try again<br/>
                <%
                }
    connection.close();
                %>

		</div>
        </form>
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
