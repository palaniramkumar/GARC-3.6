<%-- 
    Document   : index
    Created on : Oct 20, 2009, 4:09:31 PM
    Author     : Ramkumar
--%>

<%@ include file="/common/pageConfig.jsp" %>
<jsp:directive.page import="java.sql.*"  />
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
<link type="text/css" rel="stylesheet" href="../css/table-style.css" />
<link type="text/css" rel="stylesheet" href="../css/style.css" />
<link type="text/css" rel="stylesheet" href="../css/ingrid.css" />
<link type="text/css" rel="stylesheet" href="../css/jquery.autocomplete.css" />
<script src="../js/jquery-1.3.2.min.js"></script>
<script src="../js/jquery.ingrid.js"></script>
<link type="text/css" href="../css/redmond/jquery-ui-1.7.1.custom.css" rel="stylesheet" />
<script type="text/javascript" src="../js/jquery-ui-1.7.1.custom.min.js"></script>
<script src="../js/nicEdit.js"></script>
<script src="../js/garcEssentials.js" type="text/javascript"></script>
<style>
  #floatmnu{
                position:absolute;
                border:1px dotted #FFFFFF;
                display:none;
                background-color:#4F5557;
                z-index:9999;
            }
            #floatmnu ul{
                list-style:none;
                min-width:80px;
                padding:0px;
                margin:0px;
            }
            #floatmnu ul li:hover{
                background-color:gray;
            }
            #floatmnu ul li{
                padding:5px 5px 5px 5px;
            }
            #floatmnu ul li a{
                color:white;
                font-weight:bolder;
                text-decoration:none;
            }



</style>
<script type="text/javascript" src="./js/main.js"></script>
<title>Index</title>
</head>

<body>
    <div class="status" id="status"> Loading ... </div>
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
                        <li><a href="#" onclick="forum()" >Forum</a></li>
                        <li><a href="#" onclick="post()">Post</a></li>
                        <li><a href="#" onclick="feedback()">Feedback</a></li>
                        <li><a href="#">Garc Desk</a></li>
                        </ul>

			<div style="clear:both"></div>
		</div>
	</div>
                        
	<div style="clear:both"></div>
</div>
<div id="main">
 <div id="content_wrapper">
  <div id="top_div">
      
      
  </div>
     <div style="clear:both"></div>
</div>
</div>

<div id="footer_div" class="footer"><a href="#">Home</a> | <a href="#">Attendance</a> | <a href="#">Resources</a> | <a href="#">Assesment</a> | <a href="#">Time Table</a> | <a href="#">Announcement</a> | <a href="#">Semester Planner</a> | <a href="#">My Documents</a> <br />
    <br />
  <span class="copyright">Visitor Number:<%@ include file="/common/hitcount.jsp" %></span> |
  <span class="copyright">Copyright 2006-09 GARC </span></div>
                       
</body>
</html>