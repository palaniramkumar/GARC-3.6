<%-- 
    Document   : post
    Created on : Oct 21, 2009, 3:09:34 PM
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
<div style="background-color:White;padding:10px;">

    <%
    ResultSet rs = null;
    Connection connection = null;
    Statement statement = null;
    Class.forName("org.gjt.mm.mysql.Driver");
    connection = DriverManager.getConnection(CONNECTION_URL,USER_NAME,PASSWORD);
    statement = connection.createStatement();
    //delete operation
    if(request.getParameter("post_id")!=null)
        statement.executeUpdate("delete from forum_posts where post_id="+request.getParameter("post_id"));
    if(request.getParameter("topic_id")!=null)
        statement.executeUpdate("delete from forum_topics where topic_id="+request.getParameter("topic_id"));
        statement.executeUpdate("delete from forum_posts where topic_id="+request.getParameter("topic_id"));

    //Verfication
    String display_block="<h2>Topics!</h2>";
    String get_topic="select t1.*,t2.post_text,t2.post_id,date_format(t1.topic_create_time, '%b %e %Y at %r') as fmt_topic_create_time from forum_topics t1  JOIN  forum_posts t2 on t1.topic_id = t2.topic_id and t1.topic_create_time=post_create_time where t2.user_id like '"+session.getAttribute("userid")+"' order by t1.topic_create_time ";
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
        display_block += "<table class='bblist'><tr class='title_table'><th>AUTHOR: "+topic_owner+"</th><th>POST: "+topic_create_time+"</th></tr><tr><td width=65% valign=top colspan=2><pre>"+post_text+"</pre></tr><tr><td width=65% valign=top colspan=2 align='right'><a  onclick=\"animateload('post.jsp','topic_id','"+topic_id+"')\"><strong>Delete</strong></a></td></tr></table><br>";

      }
    if(flag)
         display_block+="No Topics!";
     //gather the posts
     //String get_posts = "select t2.*,t1.topic_title,date_format(t2.post_create_time, '%b %e %Y at %r') as fmt_post_create_time from   forum_posts t2 JOIN  forum_topics t1  on (t1.topic_id not like t2.topic_id and t1.topic_create_time not like t2.post_create_time) where  t1.user_id like '"+session.getAttribute("id")+"' and t2.user_id like '"+session.getAttribute("id")+"' order by t2.post_create_time";
      String get_posts = "select t2.*,t1.topic_title,date_format(t2.post_create_time, '%b %e %Y at %r') as fmt_post_create_time from   forum_posts t2 JOIN  forum_topics t1  on (t1.topic_create_time not like t2.post_create_time) where  t2.topic_id=t1.topic_id and t2.user_id like '"+session.getAttribute("userid")+"' order by t2.post_create_time ";
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
         display_block += "<table class='bblist' ><tr><th>AUTHOR: "+post_owner+"</th><th>POST: "+post_create_time+"</th></tr><tr><td width=65% valign=top colspan=2><pre>"+post_text+"</pre></td></tr><tr><td width=65% valign=top colspan=2 align='right'><a  onclick=\"animateload('post.jsp','post_id','"+post_id+"')\"><strong>Delete</strong></a></td></tr></table><br>";
     }
     if(flag)
         display_block+="No Posts";
     connection.close();

 %>



        <%=display_block %>
    </div>