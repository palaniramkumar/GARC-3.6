<%--
    Document   : showtopic
    Created on : Nov 28, 2008, 3:15:49 PM
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
    //Verfication
    String topic_title="",display_block="",topic_no=request.getParameter("topic_id").toString();
    java.util.StringTokenizer token=new StringTokenizer(topic_no,"#");
    if(token.hasMoreElements())
        topic_no=token.nextElement().toString();
    String verify_topic = "select topic_title,major from forum_topics where topic_id = "+topic_no;
    int major=0,count=0,pageno=0;
    String file="";
    if(request.getParameter("page")!=null)
	pageno=Integer.parseInt(request.getParameter("page"))-1;
    rs=statement.executeQuery(verify_topic);
    if(!rs.next()){
        display_block = "<P><em>You have selected an invalid topic.    Please <a href=\"topiclist.php\">try again</a>.</em></p>";
        return;
        }
    else{
    //get the topic title
      topic_title =rs.getString(1);
      major=rs.getInt(2);

    }
	//count no of post
     String sql = "select count(*) from forum_posts where topic_id = '"+topic_no+"'";

     //gather the posts
     String get_posts = "select post_id, post_text, date_format(post_create_time,'%b%e %Y at %r') as fmt_post_create_time, post_owner,file from forum_posts where topic_id = '"+topic_no+"'  order by post_create_time asc limit "+pageno*5+" ,5";
  	rs = statement.executeQuery(sql);
	rs.next();count=rs.getInt(1);
     rs = statement.executeQuery(get_posts);

     //create the display string
      display_block = "<P>Showing posts for the <strong>"+topic_title+"</strong> topic:</p> ";
   %>
   <%
     while (rs.next()) {
         String post_id = rs.getString("post_id");
         String post_text = rs.getString("post_text");
         String post_create_time = rs.getString("fmt_post_create_time");
         String post_owner = rs.getString("post_owner");
         if(rs.getString(3)!=null)
           file=rs.getString("file");
         //add to display
         if( file==null || file.equals("")|| file.trim().equals("null"))
            display_block += "<table width=100% border=0 cellpadding=3 cellspacing=1  ><tr class='title_table'><th>AUTHOR: "+post_owner+"</th><th>POST: "+post_create_time+"</th></tr><tr><td width=65% valign=top colspan=2><pre>"+post_text+"</pre></td><tr><td width=65% valign=top  colspan=2 align='right'>  <a  href= '#' onclick=animatepage('replytopost.jsp','post_id','"+post_id+"')><strong>REPLY TO POST</strong></a></td></tr></table><br>";
         else
            display_block += "<table width=100% border=0 cellpadding=3 cellspacing=1  ><tr class='title_table'><th>AUTHOR: "+post_owner+"</th><th>POST: "+post_create_time+"</th></tr><tr><td width=65% valign=top colspan=2><pre>"+post_text+"</pre></td><tr><td width=65% valign=top  align='left'>   <a href='upload/"+file+"'>Attachment</a></td><td align='right'> <a  href= '#' onclick=animatepage('replytopost.jsp','post_id','"+post_id+"')><strong>REPLY TO POST</strong></a></td></tr></table><br>";

     }
       connection.close();
 %>

<div id="content">
    <div style="background-color:White;padding:10px;">

   <div id="menu"><br/><a href="#" onclick="animateload('forum.jsp','0','0')">Forum </a> >> <a href="#" onclick="animateload('showpost.jsp','major','<%=major%>')"><%=BBList[major-1]%></a>>><%=topic_title%></div>
           <p align="right">Page(s):
	  <%
		for(int i=0;i<=count/5;i++){
			out.print("<td><a onclick=animatepage('showtopic.jsp','topic_id','"+topic_no+"','"+(i+1)+"')>#"+(i+1)+"</a></td> ");
		}
	  %>
	  </p>

        <%=display_block %>
    </div>

 </div>
	<!--// Buttons ends -->


<!--// Content ends -->
<!--// Searchbox starts -->



<!--// Searchbox ends -->


</body>
</html>


          
 