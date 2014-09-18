<%--
    Document   : posts
    Created on : Dec 9, 2008, 4:06:44 PM
    Author     : Ramkumar
--%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<jsp:directive.page import="java.sql.*"  errorPage="./exception.jsp" />
<%@ include file="./misc/connector.jsp" %>

<jsp:directive.page import="java.util.*" />
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

<div id="content">
    <div style="background-color:White;padding:10px;">

    <%
    ResultSet rs = null;
    Connection connection = null;
    Statement statement = null;
    Class.forName("org.gjt.mm.mysql.Driver");
    connection = DriverManager.getConnection(forum_conn);
    statement = connection.createStatement();
    //delete operation
    if(request.getParameter("post_id")!=null)
        statement.executeUpdate("delete from forum_posts where post_id="+request.getParameter("post_id"));
    if(request.getParameter("topic_id")!=null)
        statement.executeUpdate("delete from forum_topics where topic_id="+request.getParameter("topic_id"));
        statement.executeUpdate("delete from forum_posts where topic_id="+request.getParameter("topic_id"));

    //Verfication
    String display_block="<h2>Topics!</h2>";
    String get_topic="select t1.*,t2.post_text,t2.post_id,date_format(t1.topic_create_time, '%b %e %Y at %r') as fmt_topic_create_time from forum_topics t1  JOIN  forum_posts t2 on t1.topic_id = t2.topic_id and t1.topic_create_time=post_create_time where t2.user_id like '"+session.getAttribute("id")+"' order by t1.topic_create_time ";
   // out.print(get_topic);
    rs=statement.executeQuery(get_topic);
    boolean flag=true;
   while(rs.next()){
        flag=false;
        String post_id = rs.getString("post_id");
        String post_text = rs.getString("post_text");
        String topic_id = rs.getString("topic_id");
        String topic_title =  rs.getString("topic_title");
        String topic_create_time =  rs.getString("fmt_topic_create_time");
        String topic_owner =  rs.getString("topic_owner");
        display_block += "<table width=100% cellpadding=3 cellspacing=1 ><tr class='title_table'><th>AUTHOR: "+topic_owner+"</th><th>POST: "+topic_create_time+"</th></tr><tr><td width=65% valign=top colspan=2><pre>"+post_text+"</pre></tr><tr><td width=65% valign=top colspan=2 align='right'><a  onclick=\"animateload('post.jsp','topic_id','"+topic_id+"')\"><strong>Delete</strong></a></td></tr></table><br>";

      }
    if(flag)
         display_block+="No Topics!";
     //gather the posts
     //String get_posts = "select t2.*,t1.topic_title,date_format(t2.post_create_time, '%b %e %Y at %r') as fmt_post_create_time from   forum_posts t2 JOIN  forum_topics t1  on (t1.topic_id not like t2.topic_id and t1.topic_create_time not like t2.post_create_time) where  t1.user_id like '"+session.getAttribute("id")+"' and t2.user_id like '"+session.getAttribute("id")+"' order by t2.post_create_time";
      String get_posts = "select t2.*,t1.topic_title,date_format(t2.post_create_time, '%b %e %Y at %r') as fmt_post_create_time from   forum_posts t2 JOIN  forum_topics t1  on (t1.topic_create_time not like t2.post_create_time) where  t2.topic_id=t1.topic_id and t2.user_id like '"+session.getAttribute("id")+"' order by t2.post_create_time ";
  //out.print(get_posts);
     rs = statement.executeQuery(get_posts);

     //create the display string
      display_block += "<h2>Posts!</h2>";
     flag=true;
     while (rs.next()) {
         flag=false;
         String post_id = rs.getString("post_id");
         String post_text = rs.getString("post_text");
         String post_create_time = rs.getString("fmt_post_create_time");
         String post_owner = rs.getString("post_owner");

         //add to display
         display_block += "<table width=100% cellpadding=3 cellspacing=1 ><tr class='title_table'><th>AUTHOR: "+post_owner+"</th><th>POST: "+post_create_time+"</th></tr><tr><td width=65% valign=top colspan=2><pre>"+post_text+"</pre></td></tr><tr><td width=65% valign=top colspan=2 align='right'><a  onclick=\"animateload('post.jsp','post_id','"+post_id+"')\"><strong>Delete</strong></a></td></tr></table><br>";
     }
     if(flag)
         display_block+="No Posts";
     connection.close();

 %>



        <%=display_block %>
    </div>
 </div>
	<!--// Buttons ends -->


<!--// Content ends -->
<!--// Searchbox starts -->



<!--// Searchbox ends -->


</body>
</html>
 