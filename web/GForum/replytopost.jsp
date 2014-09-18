<%--
    Document   : replytopost
    Created on : Nov 28, 2008, 5:01:17 PM
    Author     : Ramkumar
--%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<jsp:directive.page import="java.sql.*"  errorPage="./exception.jsp" />
<%@ include file="./misc/connector.jsp" %>

<jsp:directive.page import="java.util.*" />
<%@ include file="BBList.jsp"%>

<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
<title>HOME</title>

<!--// SCRIPTS FOR DROPDOWN AND TABBED INTERFACE -->


<script type="text/javascript" src="js/jquery-1.2.6.min.js"></script>
<script type="text/javascript" src="js/jquery-ui-personalized-1.5.2.packed.js"></script>
<script type="text/javascript" src="js/sprinkle.js"></script>
<script type="text/javascript" src="js/js.js"></script>


<!--// FOLLOWING SCRIPT IS FOR PNG FIX IE5.5/IE6-->


<!--[if lt IE 7]>
<script defer type="text/javascript" src="js/pngfix.js"></script>
<![endif]-->


<link href="css/styles.css" rel="stylesheet" type="text/css" />
<link href="css/block.css" rel="stylesheet" type="text/css" />
</head>
<body>

<!--// Horisontal submenu edit starts -->

<div class="bodytext" id="submenu">
  <ul id="nav">
        <li><a href="main.jsp">HOME</a></li>
        <li><a href="forum.jsp">FORUM</a></li>
        <li><a href="post.jsp">POST</a></li>
        <li><a href="feedback.jsp">FEEDBACK</a></li>
    </ul>
</div>

<!--// Horisontal submenu edit ends -->
<!--// Logo edit starts -->

<div id="logo">
  <div align="center"><br />
    <img src="images/logo.png" alt="logo" width="116" height="34" /><br />
  </div>
</div>

<!--// logo edit ends -->
<!--// Arrows edit starts -->

<div id="arrows"></div>
<div class="bodytext" id="hello">Hello <a href="#"><%=session.getAttribute("name")%>, <img src="images/icons/user.png" alt="user_icon" width="22" height="25" border="0" /></a><br />
</div>



<!--// Logout edit starts -->

<div id="logout">
  <div align="center">
    <div id="logout_icon"><a href="logout.jsp"><img src="images/icons/big_logout.png" alt="big_logout" width="25" height="25" border="0" /></a></div>
<span class="toplinks"><br />
      <br />
      <a href="logout.jsp"><span class="toplinks">LOG OUT</span></a></span><br />
  </div>
</div>

<!--// logout edit ends --> 
<%
    ResultSet rs = null;
    Connection connection = null;
    Statement statement = null;
    Class.forName("org.gjt.mm.mysql.Driver");
    connection = DriverManager.getConnection(forum_conn);
    statement = connection.createStatement();
    //insert

    //still have to verify topic and post
     String verify = "select ft.topic_id, ft.topic_title,ft.major from forum_posts as fp left join forum_topics as ft on fp.topic_id = ft.topic_id where fp.post_id = "+request.getParameter("post_id");
     //out.print(verify);
    rs=statement.executeQuery(verify);
    if(!rs.next()){

       response.sendRedirect("showpost.jsp");
        return;
    }
    String topic_id=rs.getString(1);
    String topic_title=rs.getString(2);
    String name=session.getAttribute("name").toString();
    int major=rs.getInt(3);
      connection.close();
    %>

<div id="content">
    <div style="background-color:White;padding:10px;">
 <div id="menu">
            <div id="menu"><br/><a href="#" onclick="animateload('forum.jsp','0','0')">Forum </a> >> <a href="#" onclick="animateload('showpost.jsp','major','<%=major%>')"><%=BBList[major-1]%></a>>><%=topic_title%></div>
       </div>
        <h2>Post Your Reply in <%=topic_title%></h2>

    <form  METHOD="POST" ENCTYPE="multipart/form-data" action='UploadReply'>
        <p><strong>NAME: </strong></p>
            <input type="text" name="post_owner"  id="post_owner" size=40 maxlength=150 readonly value="<%=name%>">
            <p><strong>POST TEXT:</strong></p>
            <textarea name="post_text" id="post_text" rows=8 cols=40 wrap=virtual></textarea>
            <input type="hidden" name="post_id" id="post_id" value="<%=request.getParameter("post_id")%>">
            <input type="hidden" name="topic_id" id="topic_id" value="<%=topic_id%>">
            <p>Attachment<input type="file" name="file"/></p>
            <p><input type="submit" name="submit" value="Add Post" ></p>
     </form> 
    </div>

 </div>
	<!--// Buttons ends -->


<!--// Content ends -->
<!--// Searchbox starts -->



<!--// Searchbox ends -->


</body>
</html>
