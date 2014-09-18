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
    Author     : Ramkumar
--%>
<%    if ((session.getAttribute("usertype") == null) || (!session.getAttribute("usertype").toString().equalsIgnoreCase("admin"))) {
%>
<script>
    alert("Session Expired");
    window.location = "../";
</script>
<%
        return;
    }
%>
<%@ include file="../common/pageConfig.jsp"%>
<jsp:directive.page import="java.sql.*"  />
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
        <link type="text/css" rel="stylesheet" href="../css/style.css" />
        <link rel="stylesheet" href="../js/transform/jqtransformplugin/jqtransform.css" type="text/css" media="all" />
        <script src="../js/jquery.js"></script>
        <script type="text/javascript" src="../js/transform/jqtransformplugin/jquery.jqtransform.js" ></script>
        <script src="js/admin.js"></script>

        <!-- jQuery UI -->
        <link type="text/css" href="../css/redmond/jquery-ui.css" rel="stylesheet" />
        <script type="text/javascript" src="../js/jquery-ui.js"></script>
        <script src="js/ElectiveStudent.js"></script>

        <style type="text/css">

            #selected {  width: 100%;list-style: none;  }
            #selected li { margin: 2px; padding: 0.3em; font-size: .8em; height: 18px;width:25%; float: left;display: block;}

        </style>

        <title>Index</title>
    </head>

    <body>
        <div class="options" align="right">

            <a href="AdminProfile.jsp">Settings</a> |
            <a href="MyDocument.jsp">My Documents</a> |
            <a href="../common/logoutvalidation.jsp">SignOut</a>

        </div>
        <div id="status" class="status"><b>Loading...</b></div>
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
                        <li><a href="index.jsp">Home</a></li>
                        <li><a href="DepartmentSettings.jsp">Course Details</a></li>
                        <li><a href="AddStaff.jsp">Staff Entry</a></li>
                        <li><a href="AddStudent.jsp">Student Entry</a></li>
                        <li><a href="AddSubject.jsp">Subject Entry</a></li>
                        <li><a>Elective</a></li>
                        <li><a href="SemesterPlanner.jsp">Semester Planner</a></li>
                        <li><a href="QuestionBank.jsp">Question Bank</a></li>
                        <li><a href="inbox.jsp">Inbox</a></li>
                    </ul>
                    <div style="clear:both"></div>
                </div>
            </div>
            <div style="clear:both"></div>
        </div>

        <div id="content_wrapper">
            <div id="top_div">
                <div id="right">
                    <div align="right" style="color:gray;margin-top:-5px;"><%@ include file="../common/SemesterSwich.jsp" %></div>         
                    <h3>Elective Students</h3>
                    <div align="justify" style="border-bottom:1px dotted #C5CBCC; border-top:1px dotted #C5CBCC; padding-top:10px; padding-bottom: 10px; margin-bottom:5px;">

                        <table width="100%"  cellpadding="2" cellspacing="2" >
                            <tr>
                                <th width="10%" >Year</th>
                                <td width="40%">
                                    <select name="year" id="year" onchange="loadElective(this.value)" class="required">
                                        <option value="selectone">Please Select ...</option>
                                        <% for (int i = 1; i <= NO_OF_YEARS; i++) {%>
                                        <option value="<%=i%>"><%=i%></option>
                                        <%}%>

                                    </select>
                                </td>

                                <th width="10%">Subject</th>
                                <td align="left">
                                    <div id="elective">
                                        <select name="subject_id" id="subject_id" class="required">
                                            <option value="selectone">Please Select ...</option>
                                        </select>
                                    </div>
                                </td>
                            </tr>


                            <tr><td colspan="4">
                                    <ol id="selected">                                
                                        <li  class="ui-widget-content" style="margin-left:33%;text-align:center">No Students</li>
                                    </ol></td>
                            </tr>
                        </table>
                        <p align="center">[ <input type="button" value="Add All" onclick="disableAll()"/> ] [ <input type="button" value="Add Selected" onclick="addStudent()"/> ] [ <input type="button" value="Preview" onclick="showSelectedStudent()"/> ]</p>
                    </div>



                </div>

                <div style="clear:both"></div>
            </div>
            <div style="clear:both"></div>
        </div>
<div id="dialog" title="Basic dialog">
  <p>This is the default dialog which is useful for displaying information. The dialog window can be moved, resized and closed with the 'x' icon.</p>
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
            <span class="copyright">Visitor Count: <%@ include file="../common/hitcount.jsp" %></span> |
            <span class="copyright">Copyright 2008-<%=new java.util.Date().getYear() - 100%> GARC </span></div>

    </body>
</html>

