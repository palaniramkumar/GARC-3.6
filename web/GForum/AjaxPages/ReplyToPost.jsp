<%-- 
    Document   : ReplyToPost
    Created on : Oct 21, 2009, 12:58:14 PM
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
<%@ include file="../../common/DBConfig.jsp" %>
<%@ page import="java.util.List" %>
<jsp:directive.page import="java.sql.*"  />
<%@ page import="java.util.Iterator" %>
<%@ page import="java.io.File,java.io.*" %>
<%@ page import="org.apache.commons.fileupload.servlet.ServletFileUpload"%>
<%@ page import="org.apache.commons.fileupload.disk.DiskFileItemFactory"%>
<%@ page import="org.apache.commons.fileupload.*"%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="../config/BBList.jsp" %>
<%

boolean isMultipart = ServletFileUpload.isMultipartContent(request);
 if (!isMultipart) {

    ResultSet rs = null;
    Connection connection = null;
    Statement statement = null;
    connection = DriverManager.getConnection(CONNECTION_URL,USER_NAME,PASSWORD);
    statement = connection.createStatement();
    //insert

    //still have to verify topic and post
     String verify = "select ft.topic_id, ft.topic_title,ft.major from forum_posts as fp left join forum_topics as ft on fp.topic_id = ft.topic_id where fp.post_id = "+request.getParameter("post_id");
     //out.print(verify);
    rs=statement.executeQuery(verify);
    if(!rs.next()){

       response.sendRedirect("./AjaxPages/ShowPost.jsp");
        return;
    }
    String topic_id=rs.getString(1);
    String topic_title=rs.getString(2);
    String name=session.getAttribute("name").toString();
    int major=rs.getInt(3);
      connection.close();

    %>


    <div style="background-color:White;padding:10px;">

            <div id="div_menu"><br/><a href="#" onclick="animateload('forum.jsp','0','0')">Forum </a> >> <a href="#" onclick="animateload('ShowPost.jsp','major','<%=major%>')"></a>>><%=topic_title%></div>

        <h2>Post Your Reply in <%=topic_title%></h2>

    <form id="form1" METHOD="POST" ENCTYPE="multipart/form-data" action='./AjaxPages/ReplyToPost.jsp'>
        <p><strong>NAME: </strong></p>
            <input type="text" name="post_owner"  id="post_owner" size=40 maxlength=150 readonly value="<%=name%>">
            <p><strong>POST TEXT:</strong></p>
            <textarea name="post_text" id="post_text" rows=8 cols=90 wrap=virtual></textarea>
            <input type="hidden" name="post_id" id="post_id" value="<%=request.getParameter("post_id")%>">
            <input type="hidden" name="topic_id" id="topic_id" value="<%=topic_id%>">
            <p>Attachment<input type="file" name="file"/></p>
            <p><input type="submit" name="submit" value="Add Post" ></p>
            <iframe id="inline" name="inline" src="" style="display:none"></iframe>
     </form>
    </div>
<%}
    else{

    String post_owner="",post_text="",post_id="",topic_id="",file="";//session.getAttribute("folder").toString();
    String rand="";
    FileItem attachment=null;
    File dir = new File(getServletContext().getRealPath("/")+"uploadedFiles/forum");
    if (! dir.exists()) dir.mkdirs();
    FileItemFactory factory = new DiskFileItemFactory();
       ServletFileUpload upload = new ServletFileUpload(factory);
       List items = null;
       try {
               items = upload.parseRequest(request);
       } catch (FileUploadException e) {
               e.printStackTrace();
       }
       Iterator itr = items.iterator();
       while (itr.hasNext()) {
       FileItem item = (FileItem) itr.next();
       if (item.isFormField()) {
             if(item.getFieldName().equals("post_owner"))
                post_owner=item.getString();
             if(item.getFieldName().equals("post_text"))
                post_text=item.getString();
             if(item.getFieldName().equals("post_id"))
                post_id=item.getString();
             if(item.getFieldName().equals("topic_id"))
                topic_id=item.getString();

       } else {
               try {
                        File cfile=new File(item.getName());
                         //out.print("filename:"+cfile);
                        if(cfile==null ||cfile.toString().equals(""))
                            throw new  FileNotFoundException();
                        rand=Math.random()+"";
                        File tosave=new File(getServletContext().getRealPath("/")+"uploadedFiles/forum/"+ rand+cfile.getName());
                        item.write(tosave);
                        file=cfile.getName();
                        //out.print(item.getString());
                          attachment=item;
               } catch (Exception e) {
                      //out.print( e.toString());
               }
       }
       }
        Connection connection=DriverManager.getConnection(CONNECTION_URL,USER_NAME,PASSWORD);
        Statement statement = connection.createStatement();
        statement = connection.createStatement();
        String add_post = "insert into forum_posts values (null, '"+topic_id+"','"+post_text.replace("'","''").replace("\\","\\\\")+"', now(), '"+post_owner+"','"+session.getAttribute("userid")+"','"+rand+file+"')";
        statement.executeUpdate(add_post);
        out.print("Post added sucessfully");
        connection.close();
        out.print("Success ...");


    }
%>
 <script>
         parent.document.forms[0].reset();
     </script>
