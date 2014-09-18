<%-- 
    Document   : AddTopic
    Created on : Oct 21, 2009, 12:51:27 PM
    Author     : Ramkumar
--%>
<jsp:directive.page import="Garc.ConnectionManager.*"  />
<%@ include file="../../common/DBConfig.jsp" %>
<%@ page import="java.util.List" %>
<jsp:directive.page import="java.sql.*"  />
<%@ page import="java.util.Iterator" %>
<%@ page import="java.io.File,java.io.*" %>
<%@ page import="org.apache.commons.fileupload.servlet.ServletFileUpload"%>
<%@ page import="org.apache.commons.fileupload.disk.DiskFileItemFactory"%>
<%@ page import="org.apache.commons.fileupload.*"%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<%

boolean isMultipart = ServletFileUpload.isMultipartContent(request);
 if (!isMultipart) {
%>
<div style="background-color:White;padding:10px;">

   <FORM METHOD="POST" ENCTYPE="multipart/form-data" ACTION="./AjaxPages/AddTopic.jsp">
    <p><strong>NAME:</strong></p>
    <input type="text" name="topic_owner"  id="topic_owner" readonly size=40 maxlength=150 value="<%=session.getAttribute("name")%>">
    <p><strong>TOPIC TITLE:</strong></p>
    <input type="text" name="topic_title" id="topic_title" size=40 maxlength=150>
    <input type=hidden name="major" id="major"  value="<%=request.getParameter("major").replace("content","").replace("#","")%>"/>

    <p><strong>POST TEXT:</strong></p>
    <textarea name="topic_text" id="topic_text" rows=8 cols=40 wrap=virtual></textarea>
     <p><strong>ATTACHMENT:</strong></p>
    <input type="file" name="file" id="file" size=40 maxlength=150>
    <p><input type="submit"  value="Add Topic"></p>
    </form>

    </div>
<%
 } else {
           String  topic_owner="",topic_title="",topic_text="",major="",file="";//session.getAttribute("folder").toString();
           FileItem attachment=null;
           String rand="";
	   FileItemFactory factory = new DiskFileItemFactory();
	   ServletFileUpload upload = new ServletFileUpload(factory);
	   List items = null;
	   try {
		   items = upload.parseRequest(request);
	   } catch (FileUploadException e) {
		   e.printStackTrace();
	   }
           new File(getServletContext().getRealPath("/") +"uploadedFiles/forum/").mkdirs();
	   Iterator itr = items.iterator();
	   while (itr.hasNext()) {
	   FileItem item = (FileItem) itr.next();
	   if (item.isFormField()) {
              if(item.getFieldName().equals("topic_owner"))
                topic_owner=item.getString();
             if(item.getFieldName().equals("topic_title"))
                topic_title=item.getString();
             if(item.getFieldName().equals("topic_text"))
                topic_text=item.getString();
             if(item.getFieldName().equals("major"))
                major=item.getString();


	   } else {
		   try {
                           File cfile=new File(item.getName());
                            if(cfile==null ||cfile.toString().equals(""))
                                throw new  FileNotFoundException();
                            //out.print("filename:"+cfile);
                            rand=Math.random()+"";
                            File tosave=new File(getServletContext().getRealPath("/") +"uploadedFiles/forum/"+rand +cfile.getName());
                            item.write(tosave);
                            file=cfile.getName();
                            //out.print(item.getString());
                            /*if(session.getValue("filename")!=null)
                                session.putValue("filename",session.getValue("filename")+","+cfile.getName());
                            else
                                session.putValue("filename",cfile.getName());
                              */
                              attachment=item;


//"C:\
		   } catch (Exception e) {
			  //out.print( e.toString());
		   }
	   }
	   }
            ConnectionPool pool=(ConnectionPool)application.getAttribute("pool");
            Connection connection=pool.getConnection();
            Statement statement = connection.createStatement();
            String  add_topic="insert into forum_topics values (null, '"+topic_title.replace("'","''").replace("\\","\\\\")+"', now(), '"+topic_owner+"','"+major.replace("#content","")+"','"+session.getAttribute("userid")+"')";
            statement.executeUpdate(add_topic);
            ResultSet rs=statement.executeQuery("select max(last_insert_id(topic_id)) from forum_topics");
            rs.next();
            int id=rs.getInt(1);
            String add_post="insert into forum_posts values (null, "+id+", '"+topic_text.replace("'","''").replace("\\","\\\\")+"', now(), '"+topic_owner+"','"+session.getAttribute("userid")+"','"+rand+file+"')";
            //out.println(add_topic+"<br>"+add_post);
              // statement.
            statement.executeUpdate(add_post);
            out.print("Topic added ");
            connection.close();
            pool.free(connection);
            out.print("Success ...");

   }
   %>
    </table>
   </center>
     <script>
         parent.document.forms[0].reset();
     </script>
