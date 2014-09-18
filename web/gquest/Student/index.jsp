<%-- 
    Document   : index
    Created on : Jun 6, 2010, 3:24:53 AM
    Author     : Ram
--%>
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
<%@ include file="/common/pageConfig.jsp" %>

<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
<link type="text/css" rel="stylesheet" href="../../css/style.css" />
<link type="text/css" rel="stylesheet" href="../../css/table-style.css" />
<link type="text/css" rel="stylesheet" href="../css/GQuest.css" />
<script src="../../js/jquery.js"></script>
<link type="text/css" rel="stylesheet" href="../../css/redmond/jquery-ui.css" />
<script src="../../js/jquery-ui.js"></script>

<script src="/js/garcEssentials.js"></script>
<script>
    $(document).ready( function() {
$("#login").hide();
 $('.status').hide();
$.getScript("../../common/servertime.jsp", function(){

});
 });
  </script>
<%String sStudentid=session.getAttribute("userid").toString();%>
<script>
     function takeQuest(exam_id) {
                $("#top_div").html("<center><img src='../../images/preload.gif'/>Loading Please wait ...</center>");
                $("#top_div").load("agreeAjax.jsp?rand="+Math.random()+"&exam_id="+exam_id);
             }
function openwindow(url) {
    var options = 'scrollbars=yes,resizable=yes,status=no,toolbar=no,menubar=no,location=no';
    options += ',width=' + screen.availWidth + ',height=' + screen.availHeight;
    options += ',screenX=0,screenY=0,top=0,left=0';
    var win = window.open(url, 'GQuest', options);
    win.focus();
    win.moveTo(0, 0);
    win.resizeTo(screen.availWidth, screen.availHeight);
}
     function loadExam(exam_id){
         var user_id="<%=sStudentid%>";
         //window.open("GQuestClientExam.jsp?exam_id="+exam_id+"&user_id="+user_id, "GQuest","status=1,width=1024,height=768,top=0,left=0,scrollbars=1")
         openwindow("GQuestClientExam.jsp?exam_id="+exam_id+"&user_id="+user_id);
     }
     function loadReport(){
         $("#top_div").html("<center><img src='../../images/preload.gif'/> Please Wait ...</center>");

          $.ajax({
                            type: "POST",
                            url: "clientReportAjax.jsp",
                            data: "rand="+Math.random(),
                            success: function(msg){
                                $("#top_div").html("<h1>Performance</h1>"+msg)
                            }
                        });
     }

     function takeSummery(exam_id){
         $("#report").html("<center><img src='../../images/preload.gif'/> Please wait ...</center>");
                 $('#report').dialog({
                        height: 440,
                        width : 600,
			modal: true
                    });

         user_id="<%=sStudentid%>";
                url="exam_id="+exam_id+"&user_id="+user_id+"&rand="+Math.random();
                $.ajax({
                            type: "POST",
                            url: "summeryAjax.jsp",
                            data: url,
                            success: function(msg){
                                $("#report").html(msg)
                            }
                        });
     }
     
     function fullReport(exam_id){

                $("#report").html("<center><img src='../../images/preload.gif'/> Please wait ...</center>");
                                 $('#report').dialog({
                        height: 440,
                        width : 600,
			modal: true
                    });

                 url="rand="+Math.random()+"&exam_id="+exam_id
                 $.ajax({
                            type: "POST",
                            url: "../exam/singleexamsummeryAjax.jsp",
                            data: url,
                            success: function(msg){
                                $('#report').html(msg);
                            }
                        });
    }
</script>
<title>Garc - Quest</title>
</head>
<body>
    <div id="status" class="status">Loading ...</div>

        <div class="options" align="right">
            <a href="../../Student" > Student Login </a> | <a href="../../common/logoutvalidation.jsp" >Logout </a>
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
                            <li id="timer"><a href="index.jsp"><img src="../../images/home.png" alt="home" width="16" border="0" />Home</a></li>
                 	</ul>

                         <div align="right" style="color:gray;margin-top:-5px;"><%@ include file="/common/SemesterSwich.jsp" %></div>
			<div style="clear:both"></div>

		</div>

	</div>
	<div style="clear:both"></div>
</div>

<div id="content_wrapper">
  <div id="left" style="height: auto">
      <h2 >Report</h2>
        <p><a href="#" onclick="loadReport()"><img src="../../images/statistic.png" alt="edit" width="18" height="18" border="0" /> Performance</a></p>
        <br/>
        <h3>Latest Quest</h3>
              <table>

<%
    Connection connection = DriverManager.getConnection(CONNECTION_URL,USER_NAME,PASSWORD);
    Statement statement=connection.createStatement();
    String sql="select exam_id,exam_name from exam_master where active=1";
    ResultSet rs=statement.executeQuery(sql);
    int i=1;
    while(rs.next()){
%>
        <tr>
            <td align="center"><a href="#"><img src="../../images/edit.png" alt="edit" width="18" height="18" border="0" /></a></td>
            <td ><a href="#" onclick="takeQuest('<%=rs.getString(1)%>')" ><%=rs.getString(2)%> #<%=i++%></a></td> <!--// ...Article #7 -->
        </tr>

        <%}connection.close();%>
      </table>
 
    </div>

    <div id="top_div" style="width: 680px;float: left">



<h1>GQUEST!</h1>

<table bgcolor='white' width=80% style="margin:auto">
<td class="title_table">
<p>GQuest is a web based online exam software designed with a view to refresh the participant's knowledge in various fields of computer science and General Aptitude.</p>
<p>GQuest enables the faculties to set up the test for a specified time period by uploading the multiple choice questions with the correct answer.</p>
<p>GQuest allows the participants to take up the test in their field of interest and get their results immediately.</p>
<br>
    <br>
        <p>Download your user manual <a href="../../common/fileDownload.jsp?filename=Student_GQuest.pdf&type=MANUAL" class="error">Here</a></p>
</td>
</table>

  </div>
      <div id="report" title="Report" style="display:none;"></div>
      <div id="result" ></div>
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
