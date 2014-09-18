<%-- 
    Document   : ShowPost
    Created on : Oct 21, 2009, 12:41:38 PM
    Author     : Ramkumar
--%>
<jsp:directive.page import="java.sql.*"  />
<jsp:directive.page import="Garc.ConnectionManager.*"  />
<%@ include file="../../common/DBConfig.jsp" %>
<%@ include file="../config/BBList.jsp" %>
<div style="background-color:White;padding:10px;">

  <%
    ResultSet rs = null;
    ConnectionPool pool = (ConnectionPool) application.getAttribute("pool");
    Connection connection = pool.getConnection();
    Statement statement = null;
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
    Connection conn =  pool.getConnection();
    Statement st = conn.createStatement();
    int major=Integer.parseInt(request.getParameter("major").toString());
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
         display_block += " <li onclick=\"animateload('ShowTopic.jsp','topic_id','"+topic_id+"')\"> <a href='#'></a> <table><td width='287'><h4>"+topic_title+"</h4><blockquote> <p align='justify'> Created on "+topic_create_time+" by "+topic_owner+"</p></blockquote></td> <td width='103' align=center>"+num_posts+"</td></table></li>";

    }
     display_block +=   "<li> <a onclick=animatepage('AddTopic.jsp','major','"+request.getParameter("major")+"')>NEW TOPIC</a></li>";
      display_block +=   "</ul>";


    connection.close();
    conn.close();

    %>

        <div id="nav_menu"><br><a href="#forum" onclick="animateload('forum.jsp','0','0')">Forum</a> >>  <%=BBList[major]%>  </div>
	  <p align="right">
	  <%
		for(int i=0;i<=(count-1)/5;i++){
			out.print("<td><a onclick=animatepage('ShowPost.jsp','major','"+major+"','"+(i+1)+"')>#"+(i+1)+"</a></td> ");
		}
	  %>
	  </p>
        <%=display_block%>

 </div>