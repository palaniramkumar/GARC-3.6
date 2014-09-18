<%--
    Document   : showpost
    Created on : Nov 28, 2008, 2:41:44 PM
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

<div id="content">
    <div style="background-color:White;padding:10px;">

  <%
 ResultSet rs = null;
    Connection connection = null;
    Statement statement = null;
     Class.forName("org.gjt.mm.mysql.Driver");
    connection = DriverManager.getConnection(forum_conn);
    statement = connection.createStatement();
    int count=0,pageno=0;
    if(request.getParameter("page")!=null)
	pageno=Integer.parseInt(request.getParameter("page").trim())-1;
    String sql="select  count(*) from forum_topics where major="+request.getParameter("major").replace("#content", "");
    
    rs=statement.executeQuery(sql);
    rs.next();count=rs.getInt(1);
    String  get_topics = "select  topic_id, topic_title,date_format(topic_create_time, '%b %e %Y at %r') as fmt_topic_create_time,topic_owner,major from forum_topics where major="+request.getParameter("major").replace("#content", "")+" order by topic_create_time desc limit "+pageno*5+" ,5";
    //out.print(get_topics);
    rs=statement.executeQuery(get_topics);
    String display_block = " <ul id='pane-list'> ";

    ResultSet rs1 = null;
    Connection conn = DriverManager.getConnection(forum_conn);
    Statement st = conn.createStatement();
    int major=7;
    while(rs.next()){

        String topic_id = rs.getString("topic_id");
        String topic_title =  rs.getString("topic_title");
        String topic_create_time =  rs.getString("fmt_topic_create_time");
        String topic_owner =  rs.getString("topic_owner");
        major=rs.getInt("major");
        //get number of posts
         String get_num_posts = "select count(post_id) from forum_posts  where topic_id = " + topic_id;

         rs1 = st.executeQuery(get_num_posts);
         rs1.next();
         int num_posts = rs1.getInt(1);
         if(num_posts==0){
             st.executeUpdate("delete from forum_topics where topic_id = " + topic_id);
             }
         //add to display
         display_block += " <li onclick=\"animateload('showtopic.jsp','topic_id','"+topic_id+"')\"> <a href='#'></a> <table><td width='287'><h4>"+topic_title+"</h4><blockquote> <p align='justify'> Created on "+topic_create_time+" by "+topic_owner+"</p></blockquote></td> <td width='103' align=center>"+num_posts+"</td></table></li>";

    }
     display_block +=   "<li> <a onclick=animatepage('addtopic.jsp','major','"+request.getParameter("major")+"')>NEW TOPIC</a></li>";
      display_block +=   "</ul>";


    connection.close();
    conn.close();

    %>

        <div id="menu"><br><a href="#forum" onclick="animateload('forum.jsp','0','0')">Forum</a> >>  <%=BBList[major-1]%> >></div>
	  <p align="right">
	  <%
		for(int i=0;i<=(count-1)/5;i++){
			out.print("<td><a onclick=animatepage('showpost.jsp','major','"+major+"','"+(i+1)+"')>#"+(i+1)+"</a></td> ");
		}
	  %>
	  </p>
        <%=display_block%>

 </div>
	<!--// Buttons ends -->


<!--// Content ends -->
<!--// Searchbox starts -->



<!--// Searchbox ends -->


</body>
</html>
