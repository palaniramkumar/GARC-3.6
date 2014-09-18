   <%--
    Copyright (C) 2010  GARC

    This program is free software: you can redistribute it and/or modify
    it under the terms of the GNU General Public License as published by
    the Free Software Foundation, either version 3 of the License, or
    (at your option) any later version.

    This program is distributed in the hope that it will be useful,
    but WITHOUT ANY WARRANTY; without even the implied warranty of
    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
    GNU General Public License for more details.

    You should have received a copy of the GNU General Public License
    along with this program.  If not, see <http://www.gnu.org/licenses/>.
  --%>
<%-- 
    Document   : edittemplateAjax
    Created on : Mar 7, 2009, 9:48:50 PM
    Author     : Ramkumar
--%>

<script>
    function load(qno){
        //alert("hi")
        
        $.ajax({
                            type: "POST",
                            url: "edittemplateAjax.jsp?rand="+Math.random(),
                            data: 'no='+qno+"&exam_id=<%=request.getParameter("exam_id")%>",
                            success: function(msg){
                                $('#data').html(msg);
                                $("#result").html("");
                                nicEditors.allTextAreas({iconsPath : '/js/nicEditorIcons.gif',buttonList : ['fontSize','bold','italic','underline','strikeThrough','subscript','superscript']})
                            }
                        });
    }
    function remove(no,begin){
        $("#result").html("<center><img src='/images/preload.gif'/> Loading please wait ...</center>");
        $.ajax({
                            type: "POST",
                            url: "deleteentryAjax.jsp",
                            data: 'qid='+no,
                            success: function(msg){
                                $('#result').html(msg);
                                load(begin);
                            }
                        });

    }

</script>
<jsp:directive.page import="java.sql.*" />
<%@ include file="/common/pageConfig.jsp" %>
<%
    Connection connection = DriverManager.getConnection(CONNECTION_URL,USER_NAME,PASSWORD);
    Statement statement = connection.createStatement();
    ResultSet rs=null;
    rs=statement.executeQuery("select qid from questionset where exam_id='"+request.getParameter("exam_id")+"'");
    if(!rs.next()){connection.close();return;}
    String url_param_no="";
    if(request.getParameter("no")!=null)
        url_param_no=request.getParameter("no").toString();
    else
        url_param_no=rs.getString(1);
    rs.first();
%>
<table width="100%" >
    <tr align="left">
    <th >
<span>Question Switcher: <select name="no" id='no' onchange="load(no.value)">
<%
int i=0;
    do{
%>
<option value="<%=rs.getString(1)%>" <%=(url_param_no.equals(rs.getString(1)))?"selected":""%>><%=++i%></option>
<%    }while(rs.next());%>
</select></span></th>
<%
    int first=1;
    int no=1;
    rs.first();
    first=rs.getInt(1);
    if(request.getParameter("no")==null){
    no=rs.getInt(1);
    }
    else{
        no=Integer.parseInt(request.getParameter("no"));
        while(rs.getInt(1)!=no)rs.next();
    }
    %>
    <th ><input type="button" value="First"  class="button" onclick="load('<%=first%>')" /></th>
    <th><%if (rs.previous()) {%><input type="button" class="button" value="Prev" onclick="load('<%=rs.getInt(1)%>')"/><%}%></th>
    <th><%if (rs.next() && rs.next()) {%><input type="button" class="button" value="Next" onclick="load('<%=rs.getInt(1)%>')"/><%}%></th>
    <th><%rs.last();%><input type="button" value="Last" class="button" onclick="load('<%=rs.getInt(1)%>')"/></th>
     <%
    try{
        String sql="select category from exam_master where exam_id='"+request.getParameter("exam_id")+"'";
        rs=statement.executeQuery(sql);
        java.util.StringTokenizer token=null;
        if(rs.next())
            token=new java.util.StringTokenizer(rs.getString(1),",");
        rs=statement.executeQuery("select qid,replace(question,'&','&amp;'),choice,ans,weight,category from questionset where qid="+no);
        //out.println("select qid,replace(question,'&','&amp;'),choice,ans,weight,category from questionset where qid="+no);
        if(rs.next()){
%>
    <td >Category <select id="category">
            <%while(token.hasMoreElements()){
                String tmp=token.nextElement().toString();
                %>
        <option value="<%=tmp%>" <%=(tmp.equals(rs.getString(6)))?"selected":""%>><%=tmp%></option>
        <%}%>
        </select></td>

        <td class="title_table">Complexity</td>
        <td>
            <select id="weight">
                <option value="1" <%=rs.getString(5).equals("1")? "selected" :""%> >Eazy</option>
                <option value="3" <%=rs.getString(5).equals("3")? "selected" :""%>>Medium</option>
                <option value="5" <%=rs.getString(5).equals("5")? "selected" :""%>>Hard</option>
            </select>
        </td>
    </tr>
</table>
   

<p align="right"><i>Question ID:<span id="<%=rs.getString(1)%>"><%=rs.getString(1)%></span></i></p>
<textarea name="question" id="question" cols="81"><%=rs.getString(2)%></textarea>
<br>

<%
java.util.StringTokenizer choice=new java.util.StringTokenizer(rs.getString(3),"#");
java.util.StringTokenizer ans=new java.util.StringTokenizer(rs.getString(4),"#");
int arr[]={0,0,0,0,0};
int count=ans.countTokens();
for(i=0;i<count;i++)
    arr[Integer.parseInt(ans.nextElement().toString())-1]=1;
%>
<p align="right"><input type="checkbox"  name="ans" id="ans1" value="1" <%=(arr[0]==1)?"checked":"" %> /><i>Choice 1</i></p>
<textarea name="c1"  id="c1" cols="81"><%=(choice.hasMoreElements())?choice.nextElement():""%></textarea>


<p align="right"><input type="checkbox" name="ans" id="ans2" value="2" <%=(arr[1]==1)?"checked":"" %> /><i>Choice 2</i></p>
<textarea  name="c2" id="c2" cols="81" ><%=(choice.hasMoreElements())?choice.nextElement():""%></textarea>


<p align="right"><input type="checkbox" name="ans" id="ans3" value="3" <%=(arr[2]==1)?"checked":"" %>/><i>Choice 3</i></p>
<textarea  name="c3" id="c3" cols="81" ><%=(choice.hasMoreElements())?choice.nextElement():""%></textarea>

<p align="right"><input type="checkbox" name="ans" id="ans4" value="4" <%=(arr[3]==1)?"checked":"" %> /><i>Choice 4</i></p>
<textarea  name="c4" id="c4" cols="81" ><%=(choice.hasMoreElements())?choice.nextElement():""%></textarea>

<p align="right"><input type="checkbox" name="ans"  id="ans5" value="5" <%=(arr[4]==1)?"checked":"" %> /><i>Choice 5</i></p>
<textarea  name="c5"  id="c5" cols="81"><%=(choice.hasMoreElements())?choice.nextElement():""%></textarea>


<p align="center">
<input type="button" class="button" value="  +  Add      " onclick="add('<%=no%>')"/>
<input type="button" class="button" value="  -  Delete   " onclick="remove('<%=no%>','<%=first%>')" />
</p>
<%}
    }
    catch(Exception e){
        out.print("Updation Failed: "+e.toString());
    }
    connection.close();
 %>



