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
    Document   : AssignedSubjects
    Created on : Jul 30, 2009, 10:30:57 PM
    Author     : Ramkumar
--%>
<%

    if((session.getAttribute("usertype")==null) || (session.getAttribute("usertype").toString().equalsIgnoreCase("student"))){
        %>
        <script>
            alert("Session Expired");
            window.location="../";
        </script>
        <%
        return;
    }
 %>
 <div align="right" onclick="$('#sub_mnu').toggle()" style="cursor:hand">Show / Hide</div>
    <div id="sub_mnu">
	<ul class="clear">
<%
   
    sql="SELECT x.subject_name,y.subject_id,y.section,if(x.elective='YES','yes','no') elective ,y.semester,z.sectioncount FROM `subject` x, assign_staff y,section z where x.subject_id=y.subject_id and y.semester=z.semester and y.staff_id="+session.getAttribute("userid")+" order by lab,elective";
    //out.print(sql);
    rs= statement.executeQuery(sql);
    int i=0;
    while(rs.next()){
        if(i==0 && session.getAttribute("subject_id")==null)
        {
            session.setAttribute("subject_id", rs.getString(2));
            session.setAttribute("elective",  rs.getString(4));
            session.setAttribute("section",  rs.getString(3));
            session.setAttribute("semester", rs.getString(5));
            session.setAttribute("subject_name",  rs.getString(1));
            session.setAttribute("sectioncount", rs.getString("sectioncount"));
        }
        %>
        <li <%=(session.getAttribute("subject_id").equals(rs.getString(2)) && session.getAttribute("section").equals(rs.getString(3))?" class='current'":"class='notselect'")%> ><a href="#"   onclick="CreateSubjectSession('<%=rs.getString(2)%>','<%=rs.getString(3)%>','<%=rs.getString(4)%>','<%=rs.getString(5)%>','<%=rs.getString(1)%>')"> <%=rs.getString(1)%> <%=(rs.getInt("sectioncount")>1)?"["+(char)(rs.getInt(3)-1+'A')+"]":""%> </a> | </li>
        <%
        i++;
    }
    if(i==0)
        out.print("<center>No Subject(s) Assigned</center>");
    
    
    connection.close();

%>
        <li class="notselect"><a href='#' onclick="voidhour()" >Block Hour</a> | </li>
        <!--li class="notselect"><a href='#' onclick="voidhour(1,'Seminar')" >Seminar</a> | </li>
        <li class="notselect"><a href='#'onclick="voidhour(2,'Guest Lecturer')">Guest Lecturer</a> | </li>
        <li class="notselect"><a href='#' onclick="voidhour(3,'Library')">Library</a> | </li-->
</ul>
  </div>