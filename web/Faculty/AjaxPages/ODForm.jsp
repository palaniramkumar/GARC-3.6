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
    Document   : ODForm
    Created on : Sep 18, 2009, 10:44:01 AM
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
 

<jsp:directive.page import="java.sql.*"  />
<%@ include file="../../common/pageConfig.jsp"%>

<%
    Connection connection = DriverManager.getConnection(CONNECTION_URL,USER_NAME,PASSWORD);
    Statement statement = connection.createStatement();
    String sql="select section,semester from classincharge where staff_id="+session.getAttribute("userid");
    ResultSet rs=statement.executeQuery(sql);
    
    if(request.getParameter("date").equals("")){
    %>
    

 <div id="tabs">
    <ul>

        <li id="li1"><a href="#tabs-1" onclick="">OD Form</a></li>

        <li id="li2"><a href="#tabs-2" onclick="">Leave Form</a></li>
        
        <li id="li3"><a href="#tabs-3" onclick="">Block Attendance</a></li>
    </ul>
 
     <div id="tabs-1">
         <h3>On Duty Form</h3>
         <p align="right" style="padding-right:10px">
          Class: <select id="incharge" onchange="getODForm()">
            <%
            while(rs.next()){
                %>
                <option <%=(request.getParameter("semester")!=null && request.getParameter("section")!=null && request.getParameter("semester").equals(rs.getString(2)) && request.getParameter("section").equals(rs.getString(1)))?"selected" :""%>   value="<%=rs.getString(2)%>-<%=rs.getString(1)%>"><%=(rs.getInt(2)+1)/2%> Year - <%=(char)(rs.getInt(1)+'A'-1)%></option>
                <%}
            %>
        </select>
             Date: <input type="text" size="8" id="date" value="<%=request.getParameter("date")%>"  onchange="getODForm()"/>
        </p>
        <div id="ODContainer"></div>
     </div>

     <div id="tabs-2">
         <h3>Leave Form</h3>
         <p align="right" style="padding-right:10px">
          Class: <select id="incharge_1" onchange="getLeaveForm()">
            <%
            if(rs.first())
            do{
                %>
                <option <%=(request.getParameter("semester")!=null && request.getParameter("section")!=null && request.getParameter("semester").equals(rs.getString(2)) && request.getParameter("section").equals(rs.getString(1)))?"selected" :""%>   value="<%=rs.getString(2)%>-<%=rs.getString(1)%>"><%=(rs.getInt(2)+1)/2%> Year - <%=(char)(rs.getInt(1)+'A'-1)%></option>
                <%}while(rs.next());
            %>
        </select>
             Date: <input type="text" size="8" id="date_1" value="<%=request.getParameter("date")%>"  onchange="getLeaveForm()"/>
        </p>
        <div id="LeaveContainer"></div>
     </div>
        
        <div id="tabs-3">
         <h3>Attendance Block Form</h3>
         <p align="right" style="padding-right:10px">
          Class: <select id="incharge_2" onchange="getBlockAttendanceForm()">
              <option>Please Select</option>
            <%
            if(rs.first())
            do{
                %>
                <option <%=(request.getParameter("semester")!=null && request.getParameter("section")!=null && request.getParameter("semester").equals(rs.getString(2)) && request.getParameter("section").equals(rs.getString(1)))?"selected" :""%>   value="<%=rs.getString(2)%>-<%=rs.getString(1)%>"><%=(rs.getInt(2)+1)/2%> Year - <%=(char)(rs.getInt(1)+'A'-1)%></option>
                <%}while(rs.next());
            %>
        </select>
            
        </p>
        <div id="BlockContainer"></div>
     </div>
 </div>

        <%
               }
    
	
	
    if(request.getParameter("action").equals("showLeave")){
        
    //sql="select student_id,student_name from students s where semester='"+request.getParameter("semester")+"' and section='"+request.getParameter("section")+"' ";
    
    sql="select c.student_id,c.student_name,group_concat(a.hour) hrs from students c left join leaveinfo a on c.student_id=a.student_id and date like  STR_TO_DATE('"+request.getParameter("date")+"', '%d/%m/%Y') where c.semester="+request.getParameter("semester")+" and c.section="+request.getParameter("section")+"  group by c.student_id";
    //out.print(sql);
     rs=statement.executeQuery(sql);
     if(!rs.first())
     {
         out.print("No students Assigned");
         connection.close();
         return;
     }
     out.print("<table>");
     out.print("<tr><td>ID</td><td>NAME</td>");
     %>
     
        <%     for(int i=1;i<=MAX_NO_OF_PERIODS;i++)
        out.print("<td>"+i+"</td>");
     out.print("</tr>");
     do{
         out.print("<tr><td>"+rs.getString(1)+"</td><td>"+rs.getString(2)+"</td>");
         for(int i=1;i<=MAX_NO_OF_PERIODS;i++){
            
             %>
            <td><input type="checkbox" id="<%=rs.getString(1)+"-"+i%>" <%=rs.getString(3)!=null?rs.getString(3).contains(i+"")?"checked":"":""%>/></td>
            <%         }
         out.print("</tr>");
     }while(rs.next());
     out.print("</table>");
     %>
            <input type="button" value="Mark Leave" onclick="markLeave()" />
            <%			}
			
    if(request.getParameter("action").equals("showList")){
     sql="select a.student_id,s.student_name,group_concat(hour order by hour)," +
             "group_concat(ab_type order by hour) from attendance a,students s " +
             "where a.student_id=s.student_id and a.semester='"+request.getParameter("semester")+"' and a.section='"+request.getParameter("section")+"' and date like  STR_TO_DATE('"+request.getParameter("date")+"', '%d/%m/%Y')  group by student_id";
     //out.print(sql);
     rs=statement.executeQuery(sql);
  
	 if(!rs.first())
     {
         out.print("Attendance Not Taken!");
         connection.close();
         return;
     }
	 
     out.print("<table>");
     out.print("<tr><td>ID</td><td>NAME</td>");
     String hrs[]=rs.getString(3).split(",");
     for(int i=0;i<hrs.length;i++)
        out.print("<td>"+hrs[i]+"</td>");
     out.print("</tr>");
     do{
         out.print("<tr><td>"+rs.getString(1)+"</td><td>"+rs.getString(2)+"</td>");
         String hour[]=rs.getString(3).split(",");
         String ab_type[]=rs.getString(4).split(",");
         for(int i=0;i<hour.length;i++){
             %>
            <td><input type="checkbox" id="<%=rs.getString(1)+"-"+hour[i]%>" <%=(ab_type[i].equals("P"))?"disabled":""%> <%=(ab_type[i].equals("O"))?"checked":""%>></td>
            <%
         }
         out.print("</tr>");
     }while(rs.next());
     out.print("</table>");
     %>
            <input type="button" value="Mark OD" onclick="markOD()" />
            <%
  }
  if(request.getParameter("action").equals("showBlockAttendance")){
        
    //sql="select student_id,student_name from students s where semester='"+request.getParameter("semester")+"' and section='"+request.getParameter("section")+"' ";
    sql="select s.student_id,s.student_name,date,a.student_id,count(date) total,DATE_FORMAT(CURDATE(), '%d/%m/%Y') min,DATE_FORMAT(CURDATE()-7, '%d/%m/%Y') max,isattend  from attendance a join students s on s.student_id=a.student_id and s.semester=a.semester where ab_type='A' and s.semester='"+request.getParameter("semester")+"'and s.section='"+request.getParameter("section")+"' and  date <= NOW() AND date >= DATE_SUB(now(), INTERVAL 7 DAY) group by date,a.student_id order by s.student_id";
    //sql="select c.student_id,c.student_name,group_concat(a.hour) hrs from students c left join leaveinfo a on c.student_id=a.student_id and date like  STR_TO_DATE('"+request.getParameter("date")+"', '%d/%m/%Y') where c.semester="+request.getParameter("semester")+" and c.section="+request.getParameter("section")+"  group by c.student_id";
    //out.print(sql);
     rs=statement.executeQuery(sql);
     if(!rs.first())
     {
         out.print("No students were absented in last one week");
         connection.close();
         return;
     }
     out.print("<table>");
     out.print("<tr><td>ID</td><td>NAME</td><td>Absent Count<td><td>Block Leave</td>");
     %>
     
        <%     
     out.print("</tr>");
     do{
         out.print("<tr><td>"+rs.getString(1)+"</td><td>"+rs.getString(2)+"</td><td>"+rs.getString("total")+"</td>");
                
             %>
             <td><input type="checkbox" id="<%=rs.getString(1)%>" <%=rs.getString("isattend").equalsIgnoreCase("1")?"checked":""%> onclick="blockStudent('<%=rs.getString(1)%>')" /></td>
            <%         
         out.print("</tr>");
     }while(rs.next());
     out.print("</table>");
     		}
  
    else if(request.getParameter("action").equals("add")){

        String studentlist[]=request.getParameter("student").toString().split("~");
        String []token=new String[3];
        for(int i=0;i<studentlist.length;i++){
            token=studentlist[i].split("-");
            //out.print(studentlist[i]);
            sql="update attendance set ab_type='"+token[2]+"'  where date like  STR_TO_DATE('"+request.getParameter("date")+"', '%d/%m/%Y') and student_id='"+token[0]+"' and hour='"+token[1]+"'";
            statement.executeUpdate(sql);
        }
        out.print("updated...");
    }
	
    else if(request.getParameter("action").equals("addLeave")){

        String studentlist[]=request.getParameter("student").toString().split("~");
        String []token=new String[3];
         //delete prev record
        sql="delete from leaveinfo where semester='"+request.getParameter("semester") +"' and section='"+request.getParameter("section") +"' and date like STR_TO_DATE('"+request.getParameter("date")+"', '%d/%m/%Y') ";
        statement.executeUpdate(sql);
        
        for(int i=0;i<studentlist.length;i++){
          token=studentlist[i].split("-");
            out.print(studentlist[i]);
            if(token[2].equals("L")){
			sql="insert into leaveinfo values("+token[0]+","+ session.getAttribute("userid") +","+token[1]+",STR_TO_DATE('"+request.getParameter("date")+"', '%d/%m/%Y'),"+request.getParameter("semester")+","+request.getParameter("section") +",NULL,'L')";
                statement.executeUpdate(sql);

            }
        }
        out.print("Updated");
    }
%>
<%connection.close();
%>