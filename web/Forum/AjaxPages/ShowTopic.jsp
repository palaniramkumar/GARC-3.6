<%-- 
    Document   : ShowTopic
    Created on : Oct 21, 2009, 12:51:17 PM
    Author     : Ramkumar
--%>
<jsp:directive.page import="java.sql.*"  />
<jsp:directive.page import="Garc.ConnectionManager.*"  />
<%@ include file="../../common/DBConfig.jsp" %>
<jsp:directive.page import="java.util.*" />
<%@ include file="../config/BBList.jsp" %>
<%
    ResultSet rs = null;
    Connection connection = null;
    Statement statement = null;
    ConnectionPool pool = (ConnectionPool) application.getAttribute("pool");
    connection = pool.getConnection();
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
        display_block = "<P><em>You have selected an invalid topic. </em></p>";
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
         if( file==null || file.trim().equals("")|| file.trim().equals("null"))
            display_block += "<table style='width:800px;' width=680 border=0 cellpadding=3 cellspacing=1  ><tr class='title_table'><th>AUTHOR: "+post_owner+"</th><th>POST: "+post_create_time+"</th></tr><tr><td  valign=top colspan=2><pre>"+post_text+"</pre></td><tr><td valign=top  colspan=2 align='right'>  <a  href= '#' onclick=animatepage('ReplyToPost.jsp','post_id','"+post_id+"')><strong>REPLY TO POST</strong></a></td></tr></table><br>";
         else
            display_block += "<table style='width:800px;' border=0 cellpadding=3 cellspacing=1  ><tr class='title_table'><th>AUTHOR: "+post_owner+"</th><th>POST: "+post_create_time+"</th></tr><tr><td  valign=top colspan=2><pre>"+post_text+"</pre></td><tr><td valign=top  align='left'>   <a href='upload/"+file+"'>Attachment</a></td><td align='right'> <a  href= '#' onclick=animatepage('ReplyToPost.jsp','post_id','"+post_id+"',0)><strong>REPLY TO POST</strong></a></td></tr></table><br>";

     }
       connection.close();
 %>

    <div style="background-color:White;padding:10px;">

   <div id="nav_menu"><br/><a href="#" onclick="animateload('forum.jsp','0','0')">Forum </a> >> <a href="#" onclick="animateload('ShowPost.jsp','major','<%=major%>')"><%=BBList[major]%></a>>><%=topic_title%></div>
           <p align="right">Page(s):
	  <%
		for(int i=0;i<=count/5;i++){
			out.print("<td><a onclick=animatepage('ShowTopic.jsp','topic_id','"+topic_no+"','"+(i+1)+"')>#"+(i+1)+"</a></td> ");
		}
	  %>
	  </p>

        <%=display_block %>
    </div>