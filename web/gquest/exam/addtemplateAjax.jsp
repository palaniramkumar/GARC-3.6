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

    Document   : addtemplateAjax
    Created on : Mar 7, 2009, 4:54:07 PM
    Author     : Ramkumar
--%>
<script>
    $("#add").click(function() {
                add(0)
             });
</script>
<jsp:directive.page import="java.sql.*" />
<%@ include file="/common/pageConfig.jsp" %>
<%
    Connection connection = DriverManager.getConnection(CONNECTION_URL,USER_NAME,PASSWORD);
    Statement statement = connection.createStatement();
    String sql="select category from exam_master where exam_id='"+request.getParameter("exam_id")+"'";
    ResultSet rs=statement.executeQuery(sql);
    java.util.StringTokenizer token=null;
    if(rs.next())
        token=new java.util.StringTokenizer(rs.getString(1),",");
%>
 

    <table width="100%">

<tbody>
    <tr>
        <td class="title_table">Category</td>
        <td><select id="category">
            <%while(token.hasMoreElements()){
                String tmp=token.nextElement().toString();
                %>
        <option value="<%=tmp%>"><%=tmp%></option>
        <%}%>
        </select></td>
        <td class="title_table">Complexity</td>
        <td>
            <select id="weight">
                <option value="1">Eazy</option>
                <option value="3">Medium</option>
                <option value="5">Hard </option>
            </select>
       </td>
    </tr>
</tbody>
</table>
        <p align="right"><i>Question</i></p>
        <textarea name="question" id="question"   cols="81"></textarea>

        <p align="right"><input type="checkbox" name="ans" id="ans1" value="1" /><i>Choice 1</i></p>
        <textarea name="question" id="c1"   cols="81"></textarea>

        <p align="right"><input type="checkbox" name="ans" id="ans2" value="2" /><i>Choice 2</i></p>
        <textarea name="question" id="c2"   cols="81"></textarea>

        <p align="right"><input type="checkbox" name="ans" id="ans3" value="3" /><i>Choice 3</i></p>
        <textarea name="question" id="c3"   cols="81"></textarea>

        <p align="right"><input type="checkbox" name="ans" id="ans4" value="4" /><i>Choice 4</i></p>
        <textarea name="question" id="c4"  cols="81" ></textarea>

        <p align="right"><input type="checkbox" name="ans" id="ans5" value="5" /><i>Choice 5</i></p>
        <textarea name="question" id="c5"   cols="81"></textarea>

<center><input type="button" class="button" value="  Add   " name="add"  id="add" /></center>
