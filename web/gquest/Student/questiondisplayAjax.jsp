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
    Document   : questiondisplayAjax
    Created on : Mar 9, 2009, 12:23:04 AM
    Author     : Ramkumar
--%>
<jsp:directive.page import="java.sql.*" />
<%@ include file="/common/pageConfig.jsp" %>
<script>
    function end(){
       if(confirm("Do u want to submit ur results?"))
           window.location="GQuestEndExam.jsp?exam_id=<%=request.getParameter("exam_id")%>";
       else
           return
    }
</script>

<%
if(session.getAttribute("userid")==null){
	out.print("Oops! session Expired. Login Again");
	return;
}

    Connection connection = DriverManager.getConnection(CONNECTION_URL,USER_NAME,PASSWORD);
    Statement statement = connection.createStatement();
    String client_id=session.getAttribute("userid").toString();
    ResultSet rs=statement.executeQuery("select count(*) from questionset where exam_id='"+request.getParameter("exam_id")+"'");
    rs.next();
    int tot_qus=rs.getInt(1);
    int cur_qno=Integer.parseInt(request.getParameter("no"));
    int i=0;
    rs=statement.executeQuery("select * from  questionset where exam_id='"+request.getParameter("exam_id")+"'");
    if(!rs.next())return;
         %>


         <div id="options"><table class="theme"><td width="100px">
	 <%if(Integer.parseInt(request.getParameter("no"))<=tot_qus){%>
        Question # <%=request.getParameter("no")%>/<%=tot_qus%>
		<%}%>
</td><td>  Switch To Question: <select name='no' id='no' onchange="qdisplay(no.value)" >
                <%do{
                %>
                <option value="<%=++i%>" <%=((i+"").equals(request.getParameter("no")))?"selected":""%>><%=i%></option>
                <%
                }while(rs.next());%>
        </select>
        </td>
        <td width="300px"><input type="button" class="ui-state-default ui-corner-all" onclick="qdisplay(1)" value="&lt;&lt;First"/>
            <input type="button" class="ui-state-default ui-corner-all"  onclick="qdisplay('<%=cur_qno-1%>')" <%=cur_qno!=1?"":"Disabled"%> value="&lt;Previous">
         <input type="button" class="ui-state-default ui-corner-all"  onclick="qdisplay('<%=cur_qno+1%>')" value="Next&gt;" <%=(cur_qno!=tot_qus)?"":"Disabled"%>/>
         <input type="button" class="ui-state-default ui-corner-all" onclick="qdisplay(<%=tot_qus%>)" value="Last&gt;&gt;"/></td>
    </table>


        </div>
        <!--End of Question Reached...-->
        <%if(cur_qno-1==tot_qus){
            %>
            <br> <center><input type="button" value="Submit Answers" class="ui-state-default ui-corner-all" onclick="end()" /></center>
            <%
            return;}/*here the end of question block xecute*/
            rs=statement.executeQuery("select * from questionset where qid="+request.getParameter("actno"));
            rs.first();
            int qno=rs.getInt(1);

            String []complex={"","Easy","","Medium","","Difficult"};
        %>
            <br><table class="theme">
    <tr>
        <td valign="top" width="50%">Category: <%=rs.getString("category")%></td>
        <td  valign="top" align="right"><div style="text-align: right">Complexity: <%=complex[rs.getInt("weight")]%></div></td>
    </tr>
</table>
        <table class="theme">

            <tr>
                <th valign="top">Question</th>
                <th valign="top">Answer</th>
            </tr>
            <tr>
        <td width="60%" valign="top"><pre><%=rs.getString(3)%></pre></td>
        <td width="40%" valign="top">
            <%
                int arr[]={0,0,0,0,0,0};
                java.util.StringTokenizer choice=new java.util.StringTokenizer(rs.getString(6),"#");
                java.util.StringTokenizer ans=new java.util.StringTokenizer(rs.getString(7),"#");
                int cnt=ans.countTokens();
                String type="radio";
                if(cnt>1)type="checkbox";
                cnt=0;
                rs=statement.executeQuery("select user_ans from user_answer where qno="+qno+" and user_id='"+client_id+"' and exam_id='"+request.getParameter("exam_id")+"'");
               // out.print("select user_ans from user_answer where qno="+qno+" and user_id='"+client_id+"' and exam_id='"+request.getParameter("exam_id")+"'");
                if(rs.next()){
                     ans=new java.util.StringTokenizer(rs.getString(1),"#");
                     for(i=ans.countTokens();i>0;i--){
                         arr[Integer.parseInt(ans.nextElement().toString())]=1;
                     }
                }
                %>
			<table>
			<%
                        //checking empty data
                while(choice.hasMoreElements()){
                    String tk_ans=choice.nextElement().toString();
                    if(tk_ans.replaceAll("\\<.*?>","").trim().equals(""))
                        continue;
                    
                    cnt++;

                    %>
                    <tr><td valign="top"><input type="<%=type%>" id='<%=cnt%>' name="choice" value="<%=cnt%>" <%=(arr[cnt]==1)?"checked":""%> /></td><td valign="top"><label for="<%=cnt%>"><%=tk_ans%></label></td><tr>
                    
                    <%
                }
            %>
		</table>
            <p align="right" id='change'><input type="button" class="ui-state-default ui-corner-all" value="Submit" onclick="clientanswer('<%=cnt%>','<%=request.getParameter("no")%>')" /></p>
            </td>
            </tr>

        </table>
        <%connection.close();%>
        
