<%--
    Document   : Add Staff
    Created on : July 20, 2009, 10:12:04 PM
    Author     : Dinesh Kumar
--%>  <%
                 try{
                 if(request.getParameter("action")!=null && request.getParameter("action").toString().equals("show")){
                 Connection connection = DriverManager.getConnection(CONNECTION_URL,USER_NAME,PASSWORD);
                 Statement st=connection.createStatement();
                 int i=0;
                 ResultSet rs=st.executeQuery("SELECT * FROM semesterinfo.semester_students_info where semester="+request.getParameter("semester")+" and batch="+request.getParameter("batch")+" group by section");  %>
                 <div id="Section">
                 <ul>
                  <%while(rs.next()){%>
                  <li id="<%=i%>" ><a href="#" onclick="SemesterResult('<%=request.getParameter("semester")%>','<%=request.getParameter("batch")%>','<%=++i%>')">Section-<%=(char)(i+'A'-1)%></a>
                  <%}%>
                 </ul>
                 </div>
                 <font style="font-weight:bolder" color="red">Report :</font>
                 <div id="Report">
                     <ul>
                         <li id="report1"> <a href="#" onclick="SemesterClassReport()">Class Report</a>
                         <li id="report2"> <a href="#" onclick="SemesterSubjectReport()">Subject Report</a>
                         <li id="report3"> <a href="#" onclick="OverallReport()">Overall Report</a>
                         
                     </ul>
                 </div>
                  <%
                  connection.close();
                  return;
                 }
             }catch(Exception e){
              out.print("<span class=error>"+e.toString()+"</span>");}

%>
<%@ include file="../common/pageConfig.jsp" %>
<jsp:directive.page import="java.sql.*"  />
<jsp:directive.page import="Garc.ConnectionManager.*"  />
<%@ include file="../common/DBConfig.jsp" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
<link type="text/css" rel="stylesheet" href="../css/style.css" />
<link type="text/css" rel="stylesheet" href="../css/table.css" />
<link rel="stylesheet" href="../js/transform/jqtransformplugin/jqtransform.css" type="text/css" media="all" />
<script src="../js/jquery-1.3.2.min.js"></script>
<script type="text/javascript" src="../js/transform/jqtransformplugin/jquery.jqtransform.js" ></script>
<link type="text/css" href="../css/redmond/jquery-ui-1.7.1.custom.css" rel="stylesheet" />
<script type="text/javascript" src="../js/jquery-ui-1.7.1.custom.min.js"></script>
<link href='../css/skin/ui.dynatree.css' rel='stylesheet' type='text/css'/>
<script src='../js/jquery.dynatree.js' type='text/javascript'></script>


<script src="js/SemesterResult.js"></script>

<script type='text/javascript'>
  
  $(function(){
    $("#Batch").dynatree({
      fx: { height: "toggle", duration: 200 },
      autoCollapse: true,
      onActivate: function(dtnode) {
        $("#echoActive").text(dtnode.data.title);
      },
      onDeactivate: function(dtnode) {
        $("#echoActive").text("-");
      }
    });
     });
</script>
<style>
    #right{
        width:640px;
        }
</style>
<title>Semester Result</title>
</head>

<body>
     <div class="options" align="right">

        <a href="AdminProfile.jsp">Settings</a> |
        <a href="MyDocument.jsp">My Documents</a> |
        <a href="../common/logoutvalidation.jsp">SignOut</a>

    </div>
  <div id="status" class="status"><b>Loading ...</b></div>
<div id="top_wrapper">
	<div id="banner">
	<div id="logo">
			<div class="logo1">GARC</div>
			<div class="logo2">Graduate Academic Resource Center</div>
		</div>
	<div id="Search_box"><%=college%></div>
    <div id="servertime" align="right"></div>
	</div>
	<div id="menu">
		<div id="hovermenu" class="hovermenu">
			<ul>
                            <li><a href="index.jsp">Home</a></li>
                            <li><a href="DepartmentSettings.jsp">Course Details</a></li>
                            <li><a>Staff Entry</a></li>
                            <li><a href="AddStudent.jsp">Student Entry</a></li>
                            <li><a href="AddSubject.jsp">Subject Entry</a></li>
                            <li><a href="ElectiveStudents.jsp">Elective</a></li>
                        </ul>
			<div style="clear:both"></div>
		</div>
	</div>
	<div style="clear:both"></div>
</div>





<div id="content_wrapper">
 	
            <div id="left">
                <div id="Batch">
                    <ul style="display:none">
                <%
                int year = java.util.Calendar.getInstance().get(java.util.Calendar.YEAR);
                year-=NO_OF_YEARS;
                for(int i=year;i<=year+NO_OF_YEARS;i++){%>
                <li id="<%=i%>" class="folder">Batch(<%=i%>)
                    <ul>
                      <%for(int j=1;j<=NO_OF_YEARS*2;j++){%>
                      <li id="<%=j%>"><a href="#" onclick="GetSection('<%=i%>','<%=j%>')" >Semester-<%=j%></a>
                      <%}%>
                    </ul>
               <%}%>
               
               </ul>
              </div>
               <font style="font-weight:bolder" color="red">Section :</font>
              <div id="subSection">
                 
              </div>
            </div>
	    <div id="right"> 
                  <div id=studentList style="float:left;"></div>
                  <div id=studentMark style="float:left;padding-left:10px;" ></div>
            </div>
	
	
</div>

<div style="clear:both"></div>
<div style="clear:both"></div>
<div id="footer_div" class="footer"><a href="index.jsp">Home</a> | <a href="DepartmentSettings.jsp">Course Details</a> | <a href="#">Staff Entry</a> | <a href="AddStudent.jsp">Student Entry</a> | <a href="AddSubject.jsp">Subject Entry</a> | <a href="#">Elective</a> | <a href="AdminProfile.jsp">Profile</a> | <a href="#">My Documents</a> <br />
    <br />
  <span class="copyright">Visitor Count:0</span> |
  <span class="copyright">Copyright 2006-09 GARC </span></div>
</body>
</html>

