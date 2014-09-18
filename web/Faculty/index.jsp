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
    Document   : Index.jsp
    Author     : Ramkumar
--%>
<%
    if(request.getParameter("cursemester")!=null)
        session.setAttribute("DB_Name", request.getParameter("cursemester"));

    if((session.getAttribute("usertype")==null) || (session.getAttribute("usertype").toString().equalsIgnoreCase("student"))){
        %>
        <script>
            alert("Session Expired");
            window.location="../";
        </script>
        <%
        return;
    }
 %>
<%@page contentType="text/html"%>
<%@page pageEncoding="UTF-8"%>


<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
   "http://www.w3.org/TR/html4/loose.dtd">
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <script src="../js/garcEssentials.js" type="text/javascript"></script>
<!--[if IE]>
    <style type="text/css">
        @import url(../css/scrolling_table.ie.css);
    </style>
<![endif]-->
        <style type="text/css">
          
		.progress-bar-background {
                        -webkit-border-radius: 5px;
			background-color: white;
			width: 100%;
			position: relative;
			overflow:hidden;
			top: 0;
			left: 0;
		}

		.progress-bar-complete {
			background-color: #3399CC;
			width: 50%;
			position: relative;
			overflow:hidden;
			top: -12px;
			left: 0;
		}

		#progress-bar {

                        -webkit-border-radius: 5px;
			width: 200px;
			height: 15px;
			overflow:hidden;
			border: 1px black solid;
		}
	</style>
<script type="text/javascript" src="js/loading.js"></script>

        <title>GARC- Faculty</title>
    </head>
    <body>
        
        <div align="right" style="color:gray;margin-top:10px;"><%@ include file="../common/SemesterSwich.jsp" %> </div>   
        <div style="margin-top:20%;margin-left:40%">
         <div id="mainload"></div>
         <div id="progress-bar"></div>
        </div>
        
         </body>
</html>
