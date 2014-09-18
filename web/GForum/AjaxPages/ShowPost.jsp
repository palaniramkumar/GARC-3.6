<%-- 
    Document   : ShowPost
    Created on : Oct 21, 2009, 12:41:38 PM
    Author     : Ramkumar
--%>
<%

    if(session.getAttribute("userid")==null){
        %>
        <script>
            alert("Session Expired");
            window.location="../";
        </script>
        <%
        return;
    }
 %>
<jsp:directive.page import="java.sql.*"  />
<%@ include file="../../common/DBConfig.jsp" %>
<%@ include file="../config/BBList.jsp" %>
<div style="background-color:White;padding:10px;">

  <%
    ResultSet rs = null;
    Connection connection = DriverManager.getConnection(CONNECTION_URL,USER_NAME,PASSWORD);
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
    String display_block = " <ul class='bblist'> ";

    ResultSet rs1 = null;
    Connection conn =  DriverManager.getConnection(CONNECTION_URL,USER_NAME,PASSWORD);
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
         display_block += " <li onclick=\"animateload('ShowTopic.jsp','topic_id','"+topic_id+"')\"> <a href='#'></a> <table><td width='500'><h3>"+topic_title+"</h3><blockquote> <p align='justify'> Created on "+topic_create_time+" by "+topic_owner+"</p></blockquote></td> <td width='100' align=center>"+num_posts+"</td></table></li>";

    }
     display_block +=   "<li onclick=animatepage('AddTopic.jsp','major','"+request.getParameter("major")+"')><b> NEW TOPIC</b></li>";
      display_block +=   "</ul>";


    connection.close();
    conn.close();
    %>

        <div id="nav_menu"><a href="#forum" onclick="animateload('forum.jsp','0','0')">Forum</a> >>  <%=BBList[major]%>  </div>
	  <ul class="pages">
               <li>Page(s)</li>
	  <%
		for(int i=0;i<=(count-1)/5;i++){
			out.print("<li onclick=animatepage('ShowPost.jsp','major','"+major+"','"+(i+1)+"')><a >#"+(i+1)+"</a></li> ");
		}
	  %>
	  </ul>
        <%=display_block%>

 </div>