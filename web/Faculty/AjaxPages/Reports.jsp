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
    Document   : Reports
    Created on : Aug 20, 2009, 11:49:F46 PM
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
 <script type="text/javascript" src="../js/jquery.tablescroll.js"></script>
<link rel="stylesheet" type="text/css" href="../css/jquery.tablescroll.css" />

<jsp:directive.page import="java.sql.*,java.util.*,java.text.*,org.joda.time.*"  />
<%@ include file="../../common/pageConfig.jsp" %>
<%
Connection connection = DriverManager.getConnection(CONNECTION_URL,USER_NAME,PASSWORD);
Connection connection1 = DriverManager.getConnection(CONNECTION_URL,USER_NAME,PASSWORD);
Statement statement = connection.createStatement();
Statement statement1 = connection1.createStatement();
String semester=request.getParameter("semester");
String section=request.getParameter("section");
if(section==null || section.equals("0"))section="%";
if(request.getParameter("action").equals("mark")){
    java.util.ArrayList tot_sub=new java.util.ArrayList();

    String m_subject = request.getParameter("msubject");
    ResultSet rs;
    rs = statement.executeQuery("SELECT s.subject_name,a.subject_id FROM assign_staff a,subject s where a.subject_id=s.subject_id and a.semester="+semester +" and a.subject_id not like 'X%' group by subject_id");
%>

    <div align="right">
    <label for="subject">Subject:</label>
        <select id="msubject" onchange="internalMarks()">
            <option value="overall">Overall</option>
        <%while(rs.next()){%>
        <option value="<%=rs.getString(2)%>" <%=(m_subject.equals(rs.getString(2)))?"selected":""%>><%=rs.getString(1)%></option>
        <%}%>
        </select> &nbsp;&nbsp;

    <button onclick="exportXL('tabs-3')">Export</button>
    <br/>
    </div>

<%
/*
    String sql="select s.subject_id,s.subject_name,count(distinct(examid)),group_concat(distinct(examname)) from assign_staff a,subject s "+
            "left join assessment_master m on s.subject_id=m.subject_id "+
            "where a.subject_id=s.subject_id and a.semester="+semester+" and a.section="+section+" group by subject_id order by subject_id";
*/
String sql = "";
    if (m_subject.equals("undefined") || m_subject.equals("overall")) {
        sql="select s.subject_id,s.subject_name,count(distinct(examname)),group_concat(distinct(examname) order by examid),group_concat( DATE_FORMAT(examdate,'%d-%m-%Y') order by examid)  , group_concat((max_marks) order by examid) from assign_staff a,subject s "+
            "left join assessment_master m on s.subject_id=m.subject_id "+
            "where a.subject_id=s.subject_id and a.semester="+semester+" and a.section like '"+section+"' and m.section=a.section group by subject_id order by subject_id,examid asc";
    } else {
        sql="select s.subject_id,s.subject_name,count(distinct(examname)),group_concat(distinct(examname) order by examid),group_concat( DATE_FORMAT(examdate,'%d-%m-%Y') order by examid)  , group_concat((max_marks) order by examid) from assign_staff a,subject s "+
            "left join assessment_master m on s.subject_id=m.subject_id "+
            "where a.subject_id=s.subject_id and a.subject_id = '" + m_subject + "' and a.semester="+semester+" and a.section like '"+section+"' and m.section=a.section group by subject_id order by subject_id,examid asc";
    }
//out.print(sql);





rs=statement.executeQuery(sql);
%>







<!--p align="right"><button onclick="exportXL('tabs-3')">Export</button></p-->
<%out.print("<h1 align='center' style=\"margin:0px;padding:0px;\">Internal Assessment Report</h1><h3 style=\"margin:0px;padding:0px;\">Year: "+((Integer.parseInt(semester)+1)/2) +"&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Section: "+(section.equals("%")?"":(char)(Integer.parseInt(section)+'A'-1))+"</h3><br/>");%>

 <div class="scrollTableContainer">
     <!--div class="scrollTableContainer"-->
        <!--table class="dataTable" cellspacing="0" -->
        <table  class="scrollTableContainer" cellspacing="0"  >
        <thead>
        <tr>

            <th rowspan="2" >Name</th>  <!--  ToDo: Add Register Number Here  -->


<%
int i=0;
while(rs.next()){
    out.print("<th colspan= "+rs.getString(3)+"><div title=\"" + rs.getString(2) + "\">"+rs.getString(1)+"</div></th>");
    tot_sub.add(rs.getString(1));
        i++;
    }
out.print("</tr><tr>");

if(!rs.first()){
    connection.close();
    connection1.close();
    return;

}

do{
    if(rs.getString(4)==null){
        out.print("<th></th>");
        continue;
    }
    String[] arr=rs.getString(4).split(",");
    String[] arr_day=rs.getString(5).split(",");
    String[] max_marks = rs.getString(6).split(",");
    int index=0;
    while(index!=arr.length){
        String temp=arr[index];
        String fulltemp = temp;
        if(temp.length()>5){
            temp=temp.substring(0,3);//+".."+temp.substring(temp.length()-1,temp.length());
        }
%>
<th><div title="<%=fulltemp%><%=(arr_day[index++].equals("00-00-0000")) ? "" : " on "+arr_day[index-1]%>"><%=temp%><br/><%=max_marks[index-1]%></div></th>
<%
    }
}while(rs.next());
out.print("</tr></thead><tbody>");
sql="select student_id,student_name,username from students where semester="+semester +" and section like '"+section+"' order by student_id";
rs=statement.executeQuery(sql);
ResultSet rs1=null;
while(rs.next()){
    %>
    <tr>
        <td title="<%=rs.getString(2)%> (<%=rs.getString("username")%>)" class="popup"><%=(m_subject.equals("undefined")||m_subject.equals("overall"))?rs.getString(2).substring(0, 5):rs.getString(2)%></td>
        <%
                                                                  // (m_subject.equals("undefined") || m_subject.equals("overall")) {
            for(i=0;i<tot_sub.size();i++){
                sql="select m.mark,a.examid from assign_staff f,assessment_master a "+
                "left join marks m on m.examid=a.examid and m.student_id='"+rs.getString(1)+"' "+
                "where a.subject_id=f.subject_id and a.section like '"+section+"' and a.subject_id='"+tot_sub.get(i)+"' group by a.examid order by a.examid";
/*
                sql="select m.mark from assign_staff f,assessment_master a "+
                "left join marks m on m.examid=a.examid and m.student_id='"+rs.getString(1)+"' "+
                "where a.subject_id=f.subject_id and a.section=f.section and a.subject_id='"+tot_sub.get(i)+"' group by a.examid order by a.examid";
*/
  //              out.print("---"+sql);

                rs1=statement1.executeQuery(sql);
                if(!rs1.next()){
                    out.print("<td>-</td>");
                    continue;
                }
                do{
                    if(rs1.getString(1)==null)
                        out.print("<td>-</td>");
                    else
                        out.print("<td>"+rs1.getString(1)+"</td>");
                }while(rs1.next());
            }
        %>
        </tr>

<%
}
//Code for Total Starts

    %>
    <tr>
          <td title="Average" class="popup">Average</td>  <!-- Average is temporarily diabled -->
   <%

if (m_subject.equals("undefined") || m_subject.equals("overall")) {
        sql="select round(sum(mrk.mark)/count(m.examid),2) from assign_staff a";
        sql+=" left join assessment_master m on m.section like '"+section+"'";
        sql+=" left join marks mrk on mrk.examid=m.examid ";
        sql+=" where a.subject_id=m.subject_id and a.semester="+semester +" and a.section like '"+section+"' group by m.examid order by m.subject_id,m.examid";

} else {
        sql="select round(sum(mrk.mark)/count(m.examid),2) from assign_staff a";
        sql+="  left join assessment_master m on m.section like '"+section+"'";
        sql+=" left join marks mrk on mrk.examid=m.examid ";
        sql+=" where a.subject_id=m.subject_id and a.subject_id='"+m_subject+"' and a.semester="+semester +" and a.section like '"+section+"' v group by m.examid order by m.subject_id,m.examid";

}

        //out.print(sql);
        rs=statement.executeQuery(sql);
        while(rs.next()) {%>
            <td> <%=rs.getString(1)==null?"-":rs.getString(1) %></td>
        <%}
        %>
    </tr>

<%

//Code for Total Ends
out.print("</tbody></table></div>");
%>
<br/>
 <table class="clienttable">  <!--  Legend  -->
         <thead>
             <tr>
                 <th>SUBJECT ID</th>
                 <th>SUBJECT NAME</th>
                 <th>FACULTY NAME</th>
             </tr>
         </thead>
<%
sql="select a.subject_id,group_concat(s.staff_name),t.subject_name from assign_staff a,staff s,`subject` t where a.semester="+semester+" and a.section like '"+section+"' and s.staff_id=a.staff_id and t.subject_id=a.subject_id group by subject_id;";
rs=statement.executeQuery(sql);
while(rs.next()){
    %>
    <tr>
        <td><%=rs.getString(1)%></td>
        <td><%=rs.getString(3)%></td>
        <td><%=rs.getString(2)%></td>
    </tr>
    <%
}
%>
            </table>
<%
connection.close();
connection1.close();
return;

}
else if(request.getParameter("action").equals("absentee")){
    String sql="select student_id,student_name from students where semester="+semester +" and section like '"+section+"' order by student_id";
    ResultSet rs=statement.executeQuery(sql);
    //get number of days
    Calendar calendar = Calendar.getInstance();
      int year = 2008;
      int month = Integer.parseInt(request.getParameter("month").toString())-1;
      int date = 1;
      calendar.set(year, month, date);
      int days = calendar.getActualMaximum(Calendar.DAY_OF_MONTH);
      System.out.println("Number of Days: " + days);
      %>

      <table class="scrollTableContainer" cellspacing="0" >
          <thead >
              <tr>
                  <th >Name</th>
              
          
      <%
    for(int i=1;i<=days;i++){
        out.println("<th>"+i+"</th>");
    }
      %>
      </tr>
          </thead>
          <tbody>
              
          <%
          while(rs.next()){
              //sql="select student_id,count(*) total, day(date) `day` from attendance  where semester = "+semester+" and section like '"+section+"' and ab_type='A'  and  student_id="+rs.getString("student_id")+ " and month(date)="+request.getParameter("month")+" group by date ";
               sql="select student_id,count(*) total, day(date) `day`,(select count(*) from leaveinfo where semester = a.semester and section =a.section and status='L'  and  student_id=a.student_id and date=a.date)  L  from attendance a where semester = "+semester+" and section ="+section+" and ab_type='A'  and  student_id="+rs.getString("student_id")+ " and month(date)="+request.getParameter("month")+" group by date ";
              ResultSet rs1=statement1.executeQuery(sql);
              out.print("<tr ><td title='"+rs.getString(1)+"'  class='popup'>"+rs.getString("student_name")+"</td>");
              
              for(int i=1;i<=days;i++){
                if(rs1.next()){
                    if(rs1.getInt(3)==i){
                        //out.println("<td>"+rs1.getString("total")+"</td>");
                        out.println("<td>"+((rs1.getInt("total") - rs1.getInt("L") )< 0 ? 0 : (rs1.getInt("total")-rs1.getInt("L"))) +"</td>");
                    }
                                       else{
                        if(rs1.previous());
                        out.println("<td>-</td>");
                                               }
                }
                else
                    out.println("<td>-</td>");
                
              }
              out.println("</tr>");
                           }
        %>
        </tbody>
      </table>
          <%
      connection.close();
    connection1.close();

    return;
}
else if(request.getParameter("action").equals("day")){
    int [] tot_ab =new int[MAX_NO_OF_PERIODS*6];
    String sql="select student_id,student_name,username from students where semester="+semester +" and section like '"+section+"' order by student_id";
    ResultSet rs=statement.executeQuery(sql);
    java.util.Calendar date=java.util.Calendar.getInstance();
    //DateFormat df=DateFormat.getDateInstance(DateFormat.,Locale.UK);
    SimpleDateFormat df=new SimpleDateFormat("dd/MM/yyyy");
    SimpleDateFormat dbf=new SimpleDateFormat("yyyy-MM-dd");

    if(!request.getParameter("date").equals("none")){
    String tmp=request.getParameter("date");
    String[] day=tmp.split("/");
    //java.util.Date date=new java.util.Date(Integer.parseInt(day[2]),Integer.parseInt(day[1]),Integer.parseInt(day[0]));
    date.set(Integer.parseInt(day[2]),Integer.parseInt(day[1])-1,Integer.parseInt(day[0]));
    }
    else
    //out.print(date.getTime());
    date.add(java.util.Calendar.DAY_OF_YEAR, -6);
    %>

    <p align="right">
        Date: <button onclick="nav_dayAttendance('prev')"><<</button> |
         <input type="text" id="date1" value="<%=df.format(date.getTime())%>" onchange="dayAttendance()">
         | <button onclick="nav_dayAttendance('next')">>></button> 
    <button onclick="exportXL('tabs-2')">Export</button>
    </p>
    <%out.print("<h1 align='center' style=\"margin:0px;padding:0px;\">Daywise Attendance Report</h1><h3 style=\"margin:0px;padding:0px;\">Year: "+((Integer.parseInt(semester)+1)/2) +"&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Section: "+(section.equals("%")?"ALL":(char)(Integer.parseInt(section)+'A'-1))+"</h3><br/>");%>
     
        <table class="scrollTableContainer" cellspacing="0" >
            <thead >
        <tr>

            <th>Date</th>

            <%for(int j=0;j<7;j++){

                if(date.get(date.DAY_OF_WEEK)==1){
                    date.add(java.util.Calendar.DAY_OF_YEAR, 1);
                    continue;
                }
                String [] strDay={"Sun","Mon","Tue","Wed","Thu","Fri","Sat"};
                %>
                <th colspan="<%=MAX_NO_OF_PERIODS%>"><%=df.format(date.getTime())%><br/><%=strDay[date.get(Calendar.DAY_OF_WEEK)-1]%> </th>
            <%date.add(java.util.Calendar.DAY_OF_YEAR, 1);}date.add(java.util.Calendar.DAY_OF_YEAR, -7);%>
            
        </tr>
        <tr>
 <th>Name \ Period</th>
    <%
    for(int j=0;j<6;j++)

    for(int i=1;i<=MAX_NO_OF_PERIODS;i++){
        %>
        <th><%=i%></th>
        <%
    }

    %>
    
        </tr>
    </thead>
    <tbody>
            <%
                ResultSet rs1=null;
                while(rs.next()){
                        int listindex=0;
                    %>
                    <tr>

                        <td title="<%=rs.getString(1)%>"  class="popup"><%=rs.getString(2)%></td>
                        <%

                       // out.print(dbf.format(date.getTime()));
                            for(int j=0;j<7;j++){
                                 if(date.get(date.DAY_OF_WEEK)==1){
                                    date.add(java.util.Calendar.DAY_OF_YEAR, 1);
                                    continue;
                                }
                            for(int i=1;i<=MAX_NO_OF_PERIODS;i++){
                               //sql="select ab_type,subject_id from attendance where date='"+dbf.format(date.getTime()) +"' and student_id='"+rs.getString(1)+"' and hour="+i;
                                sql="SELECT `status`,hour subject_id FROM leaveinfo  where student_id='"+rs.getString(1)+"' and hour="+i+" and date='"+dbf.format(date.getTime()) +"' union " + 
								"select ab_type,subject_id from attendance where date='"+dbf.format(date.getTime()) +"' and student_id='"+rs.getString(1)+"' and hour="+i +
                                " union "+
                                "select if (type=0,'H','*') ab_type,text subject_id from voidhours where day='"+dbf.format(date.getTime()) +"' and semester='"+semester+"' and section like '"+section+"' and hour="+i ;
                               //out.print(sql);
                               rs1=statement1.executeQuery(sql);

                               if(rs1.next()){%>
                                   
                               <td title='<%=rs1.getString("subject_id")%>' <%=rs1.getString(1).equalsIgnoreCase("A")?"bgcolor='#ffeedd'":rs1.getString(1).equalsIgnoreCase("O")?"bgcolor='#eeffdd'":rs1.getString(1).equalsIgnoreCase("L")?"bgcolor='#ddccdd'":""%>><%=rs1.getString(2).startsWith("X")? rs1.getString(1).toLowerCase():rs1.getString(1)%></td>
                                   <%
                                   if(rs1.getString(1).equalsIgnoreCase("A"))
                                       ++ tot_ab[listindex] ;


                               }
                               else{
                                   out.print("<td>-</td>");
                               }    
                               listindex++;
                            }
                            date.add(java.util.Calendar.DAY_OF_YEAR, 1);
                            }
                            date.add(java.util.Calendar.DAY_OF_YEAR, -7);

                        %>
                        <td> </td>
                    </tr>
                    <%
                }
                %>
                <tr>
                        <th>Absentees</th>
                    <%
                    for(int i=0;i<MAX_NO_OF_PERIODS*6;i++)
                                out.print("<td>"+tot_ab[i]+"</td>");

            %>
                    </tr>

        </tbody>
    </table>


                    <br/>
     <table class="clienttable">
         <thead>
             <tr>
                 <th>SUBJECT ID</th>
                 <th>SUBJECT NAME</th>
                 <th>FACULTY NAME</th>
             </tr>
         </thead>
<%
sql="select a.subject_id,group_concat(s.staff_name),t.subject_name from assign_staff a,staff s,`subject` t where a.semester="+semester+" and a.section like '"+section+"' and s.staff_id=a.staff_id and t.subject_id=a.subject_id group by subject_id;";
rs=statement.executeQuery(sql);
while(rs.next()){
    %>
    <tr>
        <td><%=rs.getString(1)%></td>
        <td><%=rs.getString(3)%></td>
        <td><%=rs.getString(2)%></td>
    </tr>
    <%
}
%>
            </table>
    <%
connection.close();
connection1.close();
return;

}

else if(request.getParameter("action").equals("courseprogress")){
    String sql="SELECT s.subject_name,a.subject_id FROM assign_staff a,subject s where a.subject_id=s.subject_id and a.semester="+semester +" and a.subject_id not like 'X%' group by subject_id";
    ResultSet rs=statement.executeQuery(sql);
    rs.next();
    String subj_id="";
    if(!request.getParameter("subject_id").equals("none"))
        subj_id = request.getParameter("subject_id");
    else
        subj_id= rs.getString(2);
    rs.beforeFirst();
    %>

    <div align="right">
    <label for="subject">Subject:</label>
        <select id="subject" onchange="CourseProgressReport()">
        <%while(rs.next()){%>
        <option value="<%=rs.getString(2)%>" <%=(subj_id.equals(rs.getString(2)))?"selected":""%>><%=rs.getString(1)%></option>
        <%}%>
        </select> &nbsp;&nbsp;
       
   
    <button onclick="exportXL('tabs-5')">Export</button>
    <br/>
    </div>
 <div class="scrollTableContainer">
     <%out.print("<h1 align='center' style=\"margin:0px;padding:0px;\">Course Progress Report</h1><h3 style=\"margin:0px;padding:0px;\">Subject Id : "+subj_id+"&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Year: "+((Integer.parseInt(semester)+1)/2) +"&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Section: "+(section.equals("%")?"ALL":(char)(Integer.parseInt(section)+'A'-1))+"</h3><br/>");%>

 <table class="scrollTableContainer" >
            <thead >
            <tr>
                <th>Category</th>
                <th>Topic</th>
                <th>Pln Hrs</th>
                <th>Act Hrs</th>
		    <th>Classes Taken</th>
                <th>Finished Date</th>

            </tr>
            </thead>
            <tbody>
            <%
            sql="select c.category,c.topic,c.planned_hrs,count(distinct(concat(a.date,a.hour))),DATE_FORMAT(max(date),'%d/%m/%Y'),group_concat(distinct(DATE_FORMAT(date,'%d/%m/%Y'))) from course_planner c left join attendance a on c.sno=a.topic where c.subject_id='"+subj_id+"' and c.section like '"+section+"' group by c.topic order by c.category,c.sno asc ";
           // sql="select * from course_planner where subject_id='"+subj_id+"' and section='"+section+"' order by category,sno asc";
            rs=statement.executeQuery(sql);
            while(rs.next()){
            %>
            <tr >
                <td><%=rs.getString(1)%></td>
                <td><%=rs.getString(2)%></td>
                <td><%=rs.getString(3)%></td>
                <td><%=(rs.getString(4)==null)?"-":rs.getString(4)%></td>
		    <td><%=(rs.getString(5)==null)?"-":rs.getString(6).replace(",","<br>")%></td>
                <td><%=(rs.getString(5)==null)?"-":rs.getString(5)%></td>

            </tr>
 <%}%>
            </tbody>


        </table>
 </div>

    <%
connection.close();
connection1.close();
return;

}else if(request.getParameter("action").equals("coursecoverage")){
    String sql="SELECT s.subject_name,a.subject_id FROM assign_staff a,subject s where a.subject_id=s.subject_id and a.semester="+semester +" and a.subject_id not like 'X%'  group by subject_id";
    ResultSet rs=statement.executeQuery(sql);
    rs.next();
    String subj_id="";
    if(!request.getParameter("subjectid").equals("none"))
        subj_id = request.getParameter("subjectid");
    else
        subj_id= rs.getString(2);
    rs.beforeFirst();
    %>
    <p align="right">Subject:
        <select id="subjid" onchange="CourseCoverageReport()">
        <%while(rs.next()){%>
        <option value="<%=rs.getString(2)%>" <%=(subj_id.equals(rs.getString(2)))?"selected":""%>><%=rs.getString(1)%></option>
        <%}%>
    </select>

    </p>
 <div class="scrollTableContainer">
 <%out.print("<h1 align='center' style=\"margin:0px;padding:0px;\">Course Coverage Report</h1><h3 style=\"margin:0px;padding:0px;\">Code : "+subj_id+"&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Year: "+((Integer.parseInt(semester)+1)/2) +"&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Section: "+(section.equals("%")?"ALL":(char)(Integer.parseInt(section)+'A'-1))+"</h3><br/>");%>
     <%
            sql="select data from coursecoverage where subject_id='"+subj_id+"' and sec like '"+section+"'";
            rs=statement.executeQuery(sql);
            if(rs.next()){
            %>
<%=java.net.URLDecoder.decode(rs.getString(1),"UTF-8").trim()%>            <%}%>
 </div>

    <%
connection.close();
connection1.close();
return;

}else if(request.getParameter("action").equals("courseoutline")){
String sql="SELECT s.subject_name,a.subject_id FROM assign_staff a,subject s where a.subject_id=s.subject_id and a.semester="+semester +" and a.subject_id not like 'X%' group by subject_id";
    ResultSet rs=statement.executeQuery(sql);
    rs.next();
    String subj_id="";
    if(!request.getParameter("subjectid").equals("none"))
        subj_id = request.getParameter("subjectid");
    else
        subj_id= rs.getString(2);
    rs.beforeFirst();
    %>
    <p align="right">Subject:
        <select id="subjectid" onchange="CourseOutlineReport()">
        <%while(rs.next()){%>
        <option value="<%=rs.getString(2)%>" <%=(subj_id.equals(rs.getString(2)))?"selected":""%>><%=rs.getString(1)%></option>
        <%}%>
    </select>

    </p>
 <div class="scrollTableContainer">
      <%out.print("<h1 align='center' style=\"margin:0px;padding:0px;\">Course Outline Report</h1><h3 style=\"margin:0px;padding:0px;\">Subject Id : "+subj_id+"&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Year: "+((Integer.parseInt(semester)+1)/2) +"&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Section: "+(section.equals("%")?"ALL":(char)(Integer.parseInt(section)+'A'-1))+"</h3><br/>");%>
            <%
            sql="select data from courseoutline where subject_id='"+subj_id+"' and sec like '"+section+"'";
            rs=statement.executeQuery(sql);
            if(rs.next()){
            %>
            <%=rs.getString(1)%>
            <%}%>
 </div>

    <%
connection.close();
connection1.close();
return;
}
else if(request.getParameter("action").equals("subjectAttendance")){
String sql="SELECT s.subject_name,a.subject_id FROM assign_staff a,subject s where a.subject_id=s.subject_id and a.semester="+semester +" group by subject_id";
    ResultSet rs=statement.executeQuery(sql);
    rs.next();
    String subj_id="";
    if(!request.getParameter("subjectid").equals("none"))
        subj_id = request.getParameter("subjectid");
    else
        subj_id= rs.getString(2);
      session.setAttribute("subject_id", request.getParameter("subjectid"));
      session.setAttribute("section", request.getParameter("section"));
         
    rs.beforeFirst();
    %>
    <p align="right">Subject:
        <select id="subjectid" onchange="cumulativeReport(this.value,$('#section').val())">
            <option>Select Subject</option>
        <%while(rs.next()){%>
        <option value="<%=rs.getString(2)%>" <%=(subj_id.equals(rs.getString(2)))?"selected":""%>><%=rs.getString(1)%></option>
        <%}%>
    </select>
    
    </p>
 <div class="scrollTableContainer">
      <h1 align='center' style="margin:0px;padding:0px;">Subject Attendance Report</h1>
      <div id="studentlist"> Kindly select the subject</div>
 </div>
    <script>cumulativeReport("<%=subj_id%>",$('#section').val())</script>
    <%
connection.close();
connection1.close();
return;
}
else if(request.getParameter("action").equals("cumulative")){
    //removed export button
    %>

    <%

//out.print(sql);
String monthsubstr="";
int t=0;
if(!request.getParameter("month").equals("0"))
    monthsubstr=" and month(`date`)="+request.getParameter("month");

String sql="select a.subject_id,count(distinct(concat(date,hour))) from assign_staff a left join attendance at "+
            "on  a.semester=at.semester and a.section=at.section and a.subject_id=at.subject_id "+monthsubstr+
            " where  a.section like '"+section+"' and  a.semester="+semester+" and a. subject_id not like 'X%' group by subject_id" ;
//out.print(sql);
ResultSet rs=statement.executeQuery(sql);
if(Integer.parseInt(request.getParameter("month"))>0) {

        out.print("<h1 align='center'  style=\"margin:0px;padding:0px;\">Monthly Attendance Report for ");
        String mont[]={"January","Febraury","March","April","May","June","July","August","September","October","November","December"} ;
        out.print(mont[Integer.parseInt(request.getParameter("month"))-1]) ;
        out.print("</h1><h3  style=\"margin:0px;padding:0px;\">Year: " +((Integer.parseInt(request.getParameter("semester"))+1)/2) +"&nbsp;&nbsp;&nbsp;&nbsp;Section: "+((char)(Integer.parseInt(request.getParameter("section"))+'A'-1))+"</h3><br/>");
     }
else
        out.print("<h1 align='center' style=\"margin:0px;padding:0px;\">Cumulative Attendance Report </h1><h3 style=\"margin:0px;padding:0px;\">Year: " +((Integer.parseInt(semester)+1)/2) +"&nbsp;&nbsp;&nbsp;&nbsp;Section: "+section+"</h3><br/>");
%>

  <div align="right">
        <table class="clienttable" cellspacing="0">
            <tr align="center" >
                <th colspan="6"> Legend </th>
            </tr>
            <tr>
                 <th>P</th><td>Number of Hours Present</td>
                 <th>O</th><td>Number of Hours On Duty</td>
                 <th>%</th><td>Attendance Percentage</td>
             </tr>
         </table>
        </div><br/>

        <table class="scrollTableContainer" cellspacing="0" >
            <thead >
            <tr>

                <th rowspan="2">ID #</th> <th rowspan="2">Name</th>

<%
int i=0;
while(rs.next()){
    out.print("<th colspan=3 >"+rs.getString(1)+" ("+rs.getString(2)+") </th>");
    i++;
    t+=rs.getInt(2);
    }

out.print("<th colspan=2>Without OD</th><th colspan=2>With OD</th></tr><tr>");
for(int k=0;k<i;k++)
    out.print("<th>P</th><th>O</th><th>%</th>");
out.print("<th>Total</th><th>%</th><th>O</th><th>%</th><th></th></tr></thead><tbody>");
sql="select student_id,student_name,username from students where semester="+semester +" and section like '"+section+"' order by student_id";
rs=statement.executeQuery(sql);
    int altcss=0;
while(rs.next()){
    int p,o;
    int tot=0;
    p=o=0;
++altcss;
  /*  String innersql="SELECT s.subject_id,sum(if(ab_type='A' and student_id='"+rs.getString(1)+"' "+monthsubstr+",1,0)),(if( student_id='"+rs.getString(1)+"' "+monthsubstr+",1,0)) WITHOUTOD, " +
                    "sum(if(ab_type<>'A' and student_id='"+rs.getString(1)+"' "+monthsubstr+",1,0)),sum(if( student_id='"+rs.getString(1)+"'  "+monthsubstr+",1,0)) WITHOD FROM "+
                    "assign_staff a inner join subject s using(subject_id) left join (attendance at inner join students st using(student_id)) using(subject_id,staff_id)  " +
                    "where  a.semester="+semester+" and a.section="+section+"  group by s.subject_id order by s.subject_id;";
   */
        String innersql="SELECT s.subject_id,sum(if(ab_type='O' and student_id='"+rs.getString(1)+"' "+monthsubstr+",1,0)),(if( student_id='"+rs.getString(1)+"' "+monthsubstr+",1,0)) WITHOUTOD, " +
                    "sum(if(ab_type='P' and student_id='"+rs.getString(1)+"' "+monthsubstr+",1,0)),sum(if( student_id='"+rs.getString(1)+"'  "+monthsubstr+",1,0)) WITHOD FROM "+
                    "assign_staff a inner join subject s using(subject_id) left join (attendance at inner join students st using(student_id,semester)) using(subject_id,staff_id)  " +
                    "where  st.semester="+semester+" and st.section like '"+section+"' and  a. subject_id not like 'X%' and a.section=st.section group by s.subject_id order by s.subject_id;";


    //out.print(innersql);
    ResultSet innerrs=statement1.executeQuery(innersql);
    %>
    <tr style="background:<%if (altcss%2==0) out.print("#E8E8E8");%>">
        <td><%=rs.getString("student_id").substring(rs.getString("student_id").length()-3)%> </td>   <!--Reg. Number in Cumulative Report -->
        <td class="popup" title="<%=rs.getString(3)%>"><%=rs.getString(2)%></td>
        <%while(innerrs.next()){
                int sp=0;
		if(innerrs.getInt(5)==0){%>
			<td>-</td>
			<td>-</td>
                        <td>-</td>
                        <%
			continue;
		}
                tot+=innerrs.getInt(5);
                p+=innerrs.getInt(4);
                //sp=innerrs.getInt(5)-innerrs.getInt(2);
                o+=innerrs.getInt(2);

	   %>

        <td><%=(innerrs.getString(2)==null)?"-":innerrs.getInt(4)%></td>
        <td><%=innerrs.getInt(2)%></td>
        <td style="<%=(innerrs.getInt(4)+innerrs.getInt(2))*100/innerrs.getInt(5)<=75?"color:red":"color:green"%>" title="<%=(innerrs.getString(3)==null)?"-":innerrs.getInt(4)+"/"+innerrs.getInt(5)%>"><%=(innerrs.getInt(4)+innerrs.getInt(2))*100/innerrs.getInt(5)%></td>
        <%}%>
        <td><b><%=p+"/"+tot%></b></td>
        <td  title="<%=(p==0)?"N/A":p+"/"+tot%>"><b><%=(tot!=0)?p*100/tot:"N/A"%></b></td>
        <td><b><%=o%></b></td>
        <td  title="<%=(p==0)?"N/A":p+"/"+tot%>"><b><%=(tot!=0)?(p+o)*100/tot:"N/A"%></b></td>
        
    </tr>
<%
}
out.print("</tbody></table>");
%>
 <br/>
            <table class="clienttable">
         <thead>
             <tr>
                 <th>SUBJECT ID</th>
                 <th>SUBJECT NAME</th>
                 <th>FACULTY NAME</th>
             </tr>
         </thead>
<%
sql="select a.subject_id,group_concat(s.staff_name),t.subject_name from assign_staff a,staff s,`subject` t where a.semester="+semester+" and a.section like '"+section+"' and s.staff_id=a.staff_id and t.subject_id=a.subject_id group by subject_id;";
rs=statement.executeQuery(sql);
while(rs.next()){
    %>
    <tr>
        <td><%=rs.getString(1)%></td>
        <td><%=rs.getString(3)%></td>
        <td><%=rs.getString(2)%></td>
    </tr>
    <%
}
%>
            </table>
    <%
connection.close();
connection1.close();
return;
}
else if(request.getParameter("action").equals("timetable")){
    /*select t.data,a.subject_id from timetable_data t left join attendance a on t.header_id=a.hour
and t.semester=a.semester and t.section=a.section and t.date=a.date
where day='1'  and t.semester='1' and t.section='1'
and t.date =(select max(date) from timetable_data
where date <= STR_TO_DATE('10/11/2009', '%d/%m/%Y')) order by header_id
 */
    DateTime dt=new DateTime();
    dt=dt.minusDays(6);
    if(!request.getParameter("date").trim().equals("none")){
        String date=request.getParameter("date");
        String[] day=date.split("/");
        dt = new DateTime(Integer.parseInt(day[2]),Integer.parseInt(day[1]),Integer.parseInt(day[0]),0,0,0,0);
    }
   %>
   <p align="right">Date:<input type="text" id="date2" size="8" onchange="timetablereport()" value="<%=dt.toString("dd/MM/yyyy")%>"/>

   </p>

   <%out.print("<h1 align='center' style=\"margin:0px;padding:0px;\">Time Table Report</h1><h3 style=\"margin:0px;padding:0px;\">Year: "+((Integer.parseInt(semester)+1)/2) +"&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Section: "+(section.equals("%")?"ALL":(char)(Integer.parseInt(section)+'A'-1))+"</h3><br/>");

    //int weekday=dt.dayOfWeek().get();
    /*select t.data,a.subject_id from timetable_data t left join attendance a on t.header_id=a.hour
and t.semester=a.semester and t.section=a.section and t.date=a.date
where day='1'  and t.semester='1' and t.section='1'
and t.date =(select max(date) from timetable_data
where date <= STR_TO_DATE('10/11/2009', '%d/%m/%Y')) order by header_id*/
//select  * from timetable_data where day='"+weekday+"' and semester='"+semester+"' and section='"+section+"' and date =(select  max(date) from timetable_data where date <= STR_TO_DATE('"+date+"', '%d/%m/%Y')) order by header_id "

    int i=0;
    out.print("<table id='hor-minimalist-b'");
    do
    {
       int weekday=dt.plusDays(i).dayOfWeek().get()-1;
/*    String sql="select distinct t.data,a.subject_id,if(a.date=STR_TO_DATE('"+ dt.plusDays(i).toString("dd/MM/yyyy")+"', '%d/%m/%Y'),true,false)  from timetable_data t left join attendance a " +
            "on t.header_id=(a.hour-1) and t.semester=a.semester and t.section=a.section  " +
            "where t.day='"+weekday+"' and t.semester='"+semester+"' and t.section='"+section+"' and " +
            "t.date =(select  max(date) from timetable_data where date <= STR_TO_DATE('"+ dt.plusDays(i).toString("dd/MM/yyyy")+"', '%d/%m/%Y')) order by header_id ";
*/
    String sql="select distinct t.data,group_concat(distinct(a.subject_id) SEPARATOR '/ ') subject_id,t.header_id  from timetable_data t left join attendance a " +
            "on t.header_id=(a.hour-1) and t.semester=a.semester and t.section=a.section  and a.date=STR_TO_DATE('"+ dt.plusDays(i).toString("dd/MM/yyyy")+"', '%d/%m/%Y')" +
            "where t.day='"+weekday+"' and t.semester='"+semester+"' and t.section like '"+section+"' and " +
            "t.date =(select  max(date) from timetable_data where date <= STR_TO_DATE('"+ dt.plusDays(i).toString("dd/MM/yyyy")+"', '%d/%m/%Y')) group by header_id order by header_id ";

   // out.println(sql);

    ResultSet rs=statement.executeQuery(sql);
    //out.print(sql+"<br>");
    out.print("<tr>");
    //if(i%2==0)
        out.print("<td rowspan='2'>"+ dt.plusDays(i).toString("dd/MM/yyyy")+"<br/>"+dt.plusDays(i).dayOfWeek().getAsText()+"</td>");

    while(rs.next()){
        %>
        <td><%=rs.getString("data")%></td>
        <%

    }
    out.print("</tr><tr>");
    i++;
    if(!rs.first()){
        out.print("<td>HOLIDAY</td>");
        continue;
    }

    do{


        if(rs.getString(2)!=null)
            out.print("<td>"+rs.getString("subject_id")+"</td>");
        else
            out.print("<td>-</td>");
    }while(rs.next());
    out.print("</tr>");

    rs.close();
    }while(i<7);
    out.print("</table>");
    //out.print(sql);
    connection.close();
    connection1.close();
    return;
}
else if(request.getParameter("action").equals("nonacademic")){
    //removed export button
    %>

    <%

//out.print(sql);
String monthsubstr="";
int t=0;
if(!request.getParameter("month").equals("0"))
    monthsubstr=" and month(`date`)="+request.getParameter("month");

String sql="select a.subject_id,count(distinct(concat(date,hour))) from assign_staff a left join attendance at "+
            "on a.section=at.section and a.semester=at.semester and a.subject_id=at.subject_id "+monthsubstr+
            " where a.section like '"+section+"' and a.semester="+semester+" and a. subject_id  like 'X%' group by subject_id" ;

ResultSet rs=statement.executeQuery(sql);
if(Integer.parseInt(request.getParameter("month"))>0) {

        out.print("<h1 align='center'>Monthly Attendance Report for ");
        String mont[]={"January","Febraury","March","April","May","June","July","August","September","October","November","December"} ;
        out.print(mont[Integer.parseInt(request.getParameter("month"))-1]) ;
        out.print("</h1><br/><h3>Year: " +((Integer.parseInt(request.getParameter("semester"))+1)/2) +"&nbsp;&nbsp;&nbsp;&nbsp;Section: "+((char)(Integer.parseInt(request.getParameter("section"))+'A'-1))+"</h3><br/>");
     }
else
        out.print("<h1 align='center'>Cumulative Attendance Report </h1><br/><h3>Year: " +((Integer.parseInt(semester)+1)/2) +"&nbsp;&nbsp;&nbsp;&nbsp;Section: "+(section.equals("%")?"ALL":(char)(Integer.parseInt(section)+'A'-1))+"</h3><br/>");
%>

  <div align="right">
        <table class="clienttable" cellspacing="0">
            <tr align="center" >
                <th colspan="6"> Legend </th>
            </tr>
            <tr>
                 <th>P</th><td>Number of Hours Present</td>
                 <th>O</th><td>Number of Hours On Duty</td>
                 <th>%</th><td>Attendance Percentage</td>
             </tr>
         </table>
        </div><br/>
<div class="scrollTableContainer">
        <table class="scrollTableContainer" cellspacing="0">
            <thead >
            <tr>

                <th rowspan="2">Reg. No.</th> <th rowspan="2">Name</th>

<%
int i=0;
while(rs.next()){
    out.print("<th colspan=3 >"+rs.getString(1)+" ("+rs.getString(2)+") </th>");
    i++;
    t+=rs.getInt(2);
    }

out.print("<th colspan=2>Without OD</th><th colspan=2>With OD</th><th></th></tr><tr>");
for(int k=0;k<i;k++)
    out.print("<th>P</th><th>O</th><th>%</th>");
out.print("<th>Total</th><th>%</th><th>O</th><th>%</th></tr></thead><tbody>");
sql="select student_id,student_name,username from students where semester="+semester +" and section like '"+section+"' order by student_id";
rs=statement.executeQuery(sql);
    int altcss=0;
while(rs.next()){
    int p,o;
    int tot=0;
    p=o=0;
++altcss;
  /*  String innersql="SELECT s.subject_id,sum(if(ab_type='A' and student_id='"+rs.getString(1)+"' "+monthsubstr+",1,0)),(if( student_id='"+rs.getString(1)+"' "+monthsubstr+",1,0)) WITHOUTOD, " +
                    "sum(if(ab_type<>'A' and student_id='"+rs.getString(1)+"' "+monthsubstr+",1,0)),sum(if( student_id='"+rs.getString(1)+"'  "+monthsubstr+",1,0)) WITHOD FROM "+
                    "assign_staff a inner join subject s using(subject_id) left join (attendance at inner join students st using(student_id)) using(subject_id,staff_id)  " +
                    "where  a.semester="+semester+" and a.section="+section+"  group by s.subject_id order by s.subject_id;";
   */
        String innersql="SELECT s.subject_id,sum(if(ab_type='O' and student_id='"+rs.getString(1)+"' "+monthsubstr+",1,0)),(if( student_id='"+rs.getString(1)+"' "+monthsubstr+",1,0)) WITHOUTOD, " +
                    "sum(if(ab_type='P' and student_id='"+rs.getString(1)+"' "+monthsubstr+",1,0)),sum(if( student_id='"+rs.getString(1)+"'  "+monthsubstr+",1,0)) WITHOD FROM "+
                    "assign_staff a inner join subject s using(subject_id) left join (attendance at inner join students st using(student_id)) using(subject_id,staff_id)  " +
                    "where  a.semester="+semester+" and a.section like '"+section+"' and a. subject_id like 'X%' group by s.subject_id order by s.subject_id;";


    //out.print(innersql);
    ResultSet innerrs=statement1.executeQuery(innersql);
    %>
    
         <tr style="background:<%if (altcss%2==0) out.print("#E8E8E8");%>">
        <td><%=rs.getString("username")%></td>   <!--Reg. Number in Cumulative Report -->
        <td class='popup' title="<%=rs.getString(1)%>"><%=rs.getString(2)%></td>
        <%while(innerrs.next()){
                int sp=0;
		if(innerrs.getInt(5)==0){%>
			<td>-</td>
			<td>-</td>
                        <td>-</td>
                        <%
			continue;
		}
                tot+=innerrs.getInt(5);
                p+=innerrs.getInt(4);
                //sp=innerrs.getInt(5)-innerrs.getInt(2);
                o+=innerrs.getInt(2);

	   %>

        <td><%=(innerrs.getString(2)==null)?"-":innerrs.getInt(4)%></td>
        <td><%=innerrs.getInt(2)%></td>
        <td style="<%=(innerrs.getInt(4)+innerrs.getInt(2))*100/innerrs.getInt(5)<=75?"color:red":"color:green"%>" title="<%=(innerrs.getString(3)==null)?"-":innerrs.getInt(4)+"/"+innerrs.getInt(5)%>"><%=(innerrs.getInt(4)+innerrs.getInt(2))*100/innerrs.getInt(5)%></td>
        <%}%>
        <td><b><%=p+"/"+tot%></b></td>
        <td  title="<%=(p==0)?"N/A":p+"/"+tot%>"><b><%=(tot!=0)?p*100/tot:"N/A"%></b></td>
        <td><b><%=o%></b></td>
        <td  title="<%=(p==0)?"N/A":p+"/"+tot%>"><b><%=(tot!=0)?(p+o)*100/tot:"N/A"%></b></td>
       
    </tr>
<%
}
out.print("</tbody></table></div>");
%>
<br/>
 <table class="clienttable">
         <thead>
             <tr>
                 <th>SUBJECT ID</th>
                 <th>SUBJECT NAME</th>
                 <th>FACULTY NAME</th>
             </tr>
         </thead>
<%
sql="select a.subject_id,group_concat(s.staff_name),t.subject_name from assign_staff a,staff s,`subject` t where a.semester="+semester+" and a.section like '"+section+"' and s.staff_id=a.staff_id and t.subject_id=a.subject_id group by subject_id;";
rs=statement.executeQuery(sql);
while(rs.next()){
    %>
    <tr>
        <td><%=rs.getString(1)%></td>
        <td><%=rs.getString(3)%></td>
        <td><%=rs.getString(2)%></td>
    </tr>
    <%
}
%>
            </table>
    <%
connection.close();
connection1.close();
return;
}

else if(request.getParameter("action").equals("getreportdetail")){

        String sql="SELECT group_concat(report) FROM staff_permissions where staff_id="+session.getAttribute("userid")+" group by staff_id";
        
        ResultSet rs=statement.executeQuery(sql);
        if(rs.next())
            out.print(rs.getString(1));
        connection.close();
        connection1.close();
        return;
}
//blockstudent
else if(request.getParameter("action").equals("blockstudent")){
    String blockCode;
    if(request.getParameter("blockCode")==null){
        blockCode="1";
    }
    else{
        blockCode=request.getParameter("blockCode").toString();
    }
    //validate class incharge
        String sql="SELECT staff_id FROM `classincharge` c , students s  where  student_id = '"+request.getParameter("studentid")+"' and c.section = s.section and c.semester = s.semester and staff_id="+session.getAttribute("userid");
        //out.print(sql);
        ResultSet rs=statement.executeQuery(sql);
        if(!rs.next()){
            out.print("Permission Denied");
        }
        else
                   {
            sql="update students set isattend="+blockCode+" where student_id="+request.getParameter("studentid");
             statement.executeUpdate(sql);
            out.print(blockCode=="1"?"Blocked":"0");

             }
        connection.close();
        connection1.close();
        return;
}
String sql="SELECT year,semester FROM section;";
ResultSet rs=statement.executeQuery(sql);
%>
<table width="50%" >
    <tr>
    <td>Year
        <select id="semester" onchange="curreport()">
            <%while(rs.next()){%>
            <option value="<%=rs.getString(2)%>"><%=rs.getString(1)%></option>
            <%}%>
        </select>
    </td>
    <td align="right" >Section
        <select id="section" onchange="curreport()">
            <%for(int i=0;i<NO_OF_SECTIONS;i++){%>
            <option value="<%=i+1%>"><%=(char)( i+'A') %></option>
            <%}%>
            <option value="0">All</option>
        </select>
    </td>
    </tr>
</table>

<div id="tabs">
    <ul>

        <li id="li1" style="font-size: x-small"><a href="#tabs-1" onclick="cumulativeAttendance()">Cumulative<br/>Attendance</a></li>

            <li id="li2" style="font-size: x-small"><a href="#tabs-2" onclick="dayAttendance()">Day<br/>Attendance</a></li>

            <li id="li8" style="font-size: x-small"><a href="#tabs-8" onclick="SubjectAttendanceReport()">Subject<br/> Attendance</a></li>
            
            <li id="li9" style="font-size: x-small"><a href="#tabs-9" onclick="nonacademic()">NonAcademic<br/>Attendance</a></li>
            
            <li id="li10" style="font-size: x-small"><a href="#tabs-10" onclick="AbsenteeReport()">Absentees<br/>Report</a></li>
        
            <li id="li3" style="font-size: x-small"><a href="#tabs-3" onclick="internalMarks()">Internal<br/>Mark</a></li>

            <li id="li4" style="font-size: x-small"><a href="#tabs-4" onclick="timetablereport()">Time<br/>Table</a></li>

            <li id="li5" style="font-size: x-small"><a href="#tabs-5" onclick="CourseProgressReport()">Course <br/>Progress</a></li>

            <li id="li6" style="font-size: x-small"><a href="#tabs-6" onclick="CourseOutlineReport()">Course<br/>Outline</a></li>

            <li id="li7" style="font-size: x-small"><a href="#tabs-7" onclick="CourseCoverageReport()">Course<br/>Coverage</a></li>
            
            
            

    </ul>
    <div id="tabs-1">
        <p align="right">Month:
        <select id="month" onchange="cumulativeAttendance()">
            <option value="0">Overall</option>
            <option value="1">January</option>
            <option value="2">February</option>
            <option value="3">March</option>
            <option value="4">April</option>
            <option value="5">May</option>
            <option value="6">June</option>
            <option value="7">July</option>
            <option value="8">August</option>
            <option value="9">September</option>
            <option value="10">October</option>
            <option value="11">November</option>
            <option value="12">December</option>

        </select>
<button onclick="exportXL('tabs-1')">Export</button> 
    </p>

    <div id="cumulative">
        <img src="../images/loading2.gif"/> Please wait this may take long time ...
        </div>
    </div>
    <div id="tabs-2"><img src="../images/loading2.gif"/> Please wait ...</div>
    <div id="tabs-3"><img src="../images/loading2.gif"/> Please wait ...</div>
    <div id="tabs-4"><img src="../images/loading2.gif"/> Please wait ...</div>
    <div id="tabs-5"><img src="../images/loading2.gif"/> Please wait ...</div>
    <div id="tabs-6"><img src="../images/loading2.gif"/> Please wait ...</div>
     <div id="tabs-7"><img src="../images/loading2.gif"/> Please wait ...</div>
     <div id="tabs-8"><img src="../images/loading2.gif"/> Please wait ... </div>
     <div id="tabs-9">
     <p align="right">Month:
        <select id="month_1" onchange="nonacademic()">
            <option value="0">Overall</option>
            <option value="1">January</option>
            <option value="2">February</option>
            <option value="3">March</option>
            <option value="4">April</option>
            <option value="5">May</option>
            <option value="6">June</option>
            <option value="7">July</option>
            <option value="8">August</option>
            <option value="9">September</option>
            <option value="10">October</option>
            <option value="11">November</option>
            <option value="12">December</option>

        </select>
<button onclick="exportXL('tabs-9')">Export</button> 
    </p>
    <div id="nonacademic">
        <img src="../images/loading2.gif"/> Please wait this may take long time ...
        </div>
     </div>
     <div id="tabs-10">
    
         <p align="right">Month:
        <select id="ab_month" onchange="AbsenteeReport()">
            
            <option value="1">January</option>
            <option value="2">February</option>
            <option value="3">March</option>
            <option value="4">April</option>
            <option value="5">May</option>
            <option value="6">June</option>
            <option value="7">July</option>
            <option value="8">August</option>
            <option value="9">September</option>
            <option value="10">October</option>
            <option value="11">November</option>
            <option value="12">December</option>

        </select>
             <button onclick="exportXL('tabs-10')">Export</button> </p>
        <div id="div_absentee">
        <img src="../images/loading2.gif"/> Please wait this may take long time ...
        </div>
    </div>
    
</div>
    
    

<%
connection.close();
connection1.close();
%>