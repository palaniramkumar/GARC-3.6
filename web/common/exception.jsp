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
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
<link type="text/css" rel="stylesheet" href="/css/style.css" />
<link type="text/css" rel="stylesheet" href="/css/table-style.css" />
<%@ page isErrorPage = "true"%>
<title>Problem with your Request</title>
</head>
<body>

<div id="top_wrapper">
	<div id="banner">
	
	
	<div id="logo">
             <div class="logo1"><img src="/images/garc.png" height="80px" width="150px;"/></div>
        </div>
	<div id="Search_box"><center>SSN School Of Management & Computer Applications</center></div>
  
	</div>
	<div id="menu">
		<div id="hovermenu" class="hovermenu">
			<ul>
                            <li><a href="index.jsp">Home</a></li>

                 	</ul> 
                         

			<div style="clear:both"></div>
                         
		</div>
                 
	</div>
	<div style="clear:both"></div>
</div>

<div id="content_wrapper">
  <div id="top_div"><br/><br/><br/><br/><br/>
<center><h4>Oops! Server encountered a problem with your request. <br/>Please try after some time.</h4>
    <br/><br/><br/><br/>
    <span style="color: tomato;font-weight: bolder">
<%
  out.println("Exception Detail: " + exception);
%>
</span>
</center>
<br/><br/><br/><br/>
		</div>

  </div>
	<div id="bottom_div">
	 
	</div>
	<div style="clear:both"></div>


<div id="footer_div" class="footer">  
    <br />

   <span class="copyright">Copyright 2008-<%=new java.util.Date().getYear()-100%> GARC </span></div>

</body>
</html>

