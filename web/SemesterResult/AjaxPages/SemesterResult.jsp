<%--
    Document   : ShowStaff
    Created on : July 20, 2009, 5:53:04 PM
    Author     : Dinesh Kumar
--%>


<%@ include file="../../common/DBConfig.jsp" %>
<%@ include file="../../common/pageConfig.jsp" %>
<jsp:directive.page import="java.sql.*"  />
<%
  try{
        Connection connection = DriverManager.getConnection(CONNECTION_URL,USER_NAME,PASSWORD);
        Statement st=connection.createStatement();

        if(request.getParameter("action").toString().equals("show")){

            String sql="SELECT * FROM semesterinfo.semester_students_info where semester="+request.getParameter("semester")+" and section="+request.getParameter("section")+"  and batch="+request.getParameter("batch")+"";
            //out.print(sql);
            ResultSet rs=st.executeQuery(sql);
            %>
            <table>
                <tr>
                <th>Reg N0</th>
                <th>Name</th>
                <th>Action</th>
                </tr><%
            while(rs.next()){
            %>
            <tr>
                <td><%=rs.getString(1).substring(rs.getString(1).length()-2)%></td>
                <td><%=rs.getString(2)%></td>
                <td><ul class="action">
                <li class="edit"><a onclick="EditSemesterResult('<%=rs.getString(1)%>','<%=request.getParameter("semester")%>','<%=request.getParameter("section")%>','<%=request.getParameter("batch")%>')">Edit</a></li>
                </ul>
            </tr>
            <%
            }%>
            </table><%
        }else if(request.getParameter("action").toString().equals("edit")){
            String student_id=request.getParameter("student_id").toString();
            int sem=Integer.parseInt(request.getParameter("semester").toString());
            int batch=Integer.parseInt(request.getParameter("batch").toString());
            int section=Integer.parseInt(request.getParameter("section").toString());
            String moe=exam_months[sem%2];
            int yoe=batch+(sem/2);
            Connection con = DriverManager.getConnection(CONNECTION_URL,USER_NAME,PASSWORD);
            Statement statement=con.createStatement();
            ResultSet rset1=null;
            //out.print("SELECT subject_name,subject_id,yoe,moe,examid,grade FROM semesterinfo.semester_subject_info where semester="+sem+" and section="+section+" and batch="+batch+" and elective = 'null'");
            ResultSet rs=st.executeQuery("SELECT subject_name,subject_id,yoe,moe,examid,grade FROM semesterinfo.semester_subject_info where semester="+sem+" and section="+section+" and batch="+batch+" and elective = 'null'");
                    if(rs.next())
                    {%>

                    <table class='clienttable' cellspacing="0">
                        <thead>
                            <tr>
                              <td style="font-weight:bolder">ID  :</td><td><%=student_id%>&nbsp;&nbsp;&nbsp; </td>
                              <td style="font-weight:bolder">Date :</td><td><%=rs.getString(4)+"-"+rs.getString(3)%>&nbsp;&nbsp;&nbsp; </td>
                              <td style="font-weight:bolder">Batch :</td> <td><%=batch%>&nbsp;&nbsp;&nbsp;</td>
                           </tr>
                        </thead>
                    </table>

                    <table class="clienttable" cellspacing="0">
                        <thead>
                            <tr>
                                <th>Subject Code</th>
                                <th>Subject Name</th>
                                <th><%=(rs.getString("grade").equals("YES"))?"Credit":"Int"%></th>
                                <th><%=(rs.getString("grade").equals("YES"))?"Grade":"Ext"%></th>

                                <th>Result</th>
                            </tr>
                        </thead>
                        <tbody>
                            <%do{%>
                            <tr>
                                <td><%=rs.getString(2)%></td>
                                <td><%=rs.getString(1)%></td>
                                 <%rset1=statement.executeQuery("SELECT internal,external,result from semesterinfo.semester_mark_info where student_id='"+student_id+"' and examid='"+rs.getString("examid")+"' and moe='"+moe+"' and yoe='"+yoe+"'");
                                   String internal="",external="",result="";
                                  if(rset1.next()){internal=rset1.getString(1);external=rset1.getString(2);result=rset1.getString(3);}
                                 %>
                                <td><input type="text" id="int<%=rs.getString(5)%>" value="<%=internal%>" size="3"></td>
                                <td><input type="text" id="ext<%=rs.getString(5)%>" value="<%=external%>" size="3"></td>
                                <td><select id="res<%=rs.getString(5)%>" name="result" title="Choose the Result">
                                        <option <%=(result.equals("Pass"))?"selected":""%> value="Pass">Pass</option>
                                        <option <%=(result.equals("Fail"))?"selected":""%> value="Fail">Fail</option>
                                    </select>
                                </td>
                            </tr>
                            <%  }while(rs.next());
                            }
                            rs = st.executeQuery("SELECT s.examid,s.subject_name,s.subject_id FROM semesterinfo.semester_subject_info s where semester="+sem+" and section="+section+" and batch="+batch+" and elective='YES' and examid IN (Select examid from semesterinfo.semester_elective_students where student_id='"+student_id+"')");
                             while(rs.next())
                             {%>
                             <tr>
                                <td><%=rs.getString(3)%></td>
                                <td><%=rs.getString(2)%></td>
                               <%rset1=statement.executeQuery("SELECT internal,external,result from semesterinfo.semester_mark_info where student_id='"+student_id+"' and examid='"+rs.getString("examid")+"' and moe='"+moe+"' and yoe='"+yoe+"'");
                                   String internal="",external="",result="";
                                  if(rset1.next()){internal=rset1.getString(1);external=rset1.getString(2);result=rset1.getString(3);}
                                 %>
                                <td><input type="text" id="int<%=rs.getString(1)%>" value="<%=internal%>" size="3"></td>
                                <td><input type="text" id="ext<%=rs.getString(1)%>" value="<%=external%>" size="3"></td>
                                <td><select id="res<%=rs.getString(1)%>" name="result" title="Choose the Result">
                                        <option <%=(result.equals("Pass"))?"selected":""%> value="Pass">Pass</option>
                                        <option <%=(result.equals("Fail"))?"selected":""%> value="Fail">Fail</option>
                                    </select>
                                </td>
                            </tr>
                            <%}
                             rs = statement.executeQuery("SELECT examid,subject_name,subject_id FROM semesterinfo.semester_subject_info WHERE semester < "+sem+" and (examid) IN (SELECT DISTINCT examid FROM semesterinfo.semester_mark_info where student_id="+student_id+" and result='Fail' and (examid)NOT IN (SELECT examid FROM semesterinfo.semester_mark_info where student_id="+student_id+" and result='Pass'))");
                             while(rs.next())
                             {%>
                             <tr>
                                <td><%=rs.getString(3)%></td>
                                <td><%=rs.getString(2)%></td>
                                <%rset1=st.executeQuery("SELECT internal,external,result from semesterinfo.semester_mark_info where student_id='"+student_id+"' and examid='"+rs.getString("examid")+"' and moe='"+moe+"' and yoe='"+yoe+"'");
                                   String internal="",external="",result="";
                                  if(rset1.next()){internal=rset1.getString(1);external=rset1.getString(2);result=rset1.getString(3);}
                                 %>
                                <td><input type="text" id="int<%=rs.getString(1)%>" value="<%=internal%>" size="3"></td>
                                <td><input type="text" id="ext<%=rs.getString(1)%>" value="<%=external%>" size="3"></td>
                                <td><select id="res<%=rs.getString(1)%>" name="result" title="Choose the Result">
                                        <option <%=(result.equals("Pass"))?"selected":""%> value="Pass">Pass</option>
                                        <option <%=(result.equals("Fail"))?"selected":""%> value="Fail">Fail</option>
                                    </select>
                                </td>
                            </tr>
                            <%}%>
                        </tbody>
                    </table>
                        <center><input type="button" onclick="AddSemesterResult('<%=sem%>','<%=batch%>','<%=section%>','<%=student_id%>')" value="Update"></center>


                   <%
                        connection.close();
                        con.close();
                        return;
        } else if(request.getParameter("action").toString().equals("add"))
        {
        String student_id=request.getParameter("student_id").toString();
        int sem=Integer.parseInt(request.getParameter("semester").toString());
        int batch=Integer.parseInt(request.getParameter("batch").toString());
        int section=Integer.parseInt(request.getParameter("section").toString());
        String moe=exam_months[sem%2];
        int yoe=batch+(sem/2);
        ResultSet rs=st.executeQuery("SELECT yoe,moe,examid FROM semesterinfo.semester_subject_info where semester="+sem+" and section="+section+" and batch="+batch+" and elective='null'");
        Connection con = DriverManager.getConnection(CONNECTION_URL,USER_NAME,PASSWORD);
        Statement stmt=con.createStatement();
        Connection conn = DriverManager.getConnection(CONNECTION_URL,USER_NAME,PASSWORD);
        Statement statement=conn.createStatement();
        if(rs.next())
        {
        yoe=Integer.parseInt(rs.getString(1));
        moe=rs.getString(2);
        do{
             //out.print("<br>1.)insert into semesterinfo.semester_mark_info(student_id,examid,internal,external,result,moe,yoe) values('"+student_id+"','"+rs.getString("examid")+"','"+request.getParameter("int"+rs.getString("examid"))+"','"+request.getParameter("ext"+rs.getString("examid"))+"','"+request.getParameter("res"+rs.getString("examid"))+"','"+moe+"',"+yoe+")");
             statement.executeUpdate("delete from semesterinfo.semester_mark_info where student_id='"+student_id+"' and examid='"+rs.getString("examid")+"' and moe='"+moe+"' and yoe='"+yoe+"'");
             stmt.executeUpdate("insert into semesterinfo.semester_mark_info(student_id,examid,internal,external,result,moe,yoe) values('"+student_id+"','"+rs.getString("examid")+"','"+request.getParameter("int"+rs.getString("examid"))+"','"+request.getParameter("ext"+rs.getString("examid"))+"','"+request.getParameter("res"+rs.getString("examid"))+"','"+moe+"',"+yoe+")");
        }while(rs.next());
        }
        rs=st.executeQuery("SELECT examid FROM semesterinfo.semester_subject_info WHERE semester < "+sem+" and (examid) IN (SELECT DISTINCT examid FROM semesterinfo.semester_mark_info where student_id="+student_id+" and result='Fail' and (examid)NOT IN (SELECT examid FROM semesterinfo.semester_mark_info where student_id="+student_id+" and result='Pass'))");
        while(rs.next()){
            //out.print("<br>2.insert into semesterinfo.semester_mark_info(student_id,examid,internal,external,result,moe,yoe) values('"+student_id+"','"+rs.getString("examid")+"','"+request.getParameter("int"+rs.getString("examid"))+"','"+request.getParameter("ext"+rs.getString("examid"))+"','"+request.getParameter("res"+rs.getString("examid"))+"','"+moe+"',"+yoe+")");
             statement.executeUpdate("delete from semesterinfo.semester_mark_info where student_id='"+student_id+"' and examid='"+rs.getString("examid")+"' and moe='"+moe+"' and yoe='"+yoe+"'");
             stmt.executeUpdate("insert into semesterinfo.semester_mark_info(student_id,examid,internal,external,result,moe,yoe) values('"+student_id+"','"+rs.getString("examid")+"','"+request.getParameter("int"+rs.getString("examid"))+"','"+request.getParameter("ext"+rs.getString("examid"))+"','"+request.getParameter("res"+rs.getString("examid"))+"','"+moe+"',"+yoe+")");
        }
       //out.println("SELECT examid FROM semesterinfo.semester_subject_info where semester="+sem+" and section="+section+" and batch="+batch+" and elective='YES' and examid IN (Select examid from semesterinfo.semester_elective_students where student_id='"+student_id+"')");
        rs=st.executeQuery("SELECT examid FROM semesterinfo.semester_subject_info where semester="+sem+" and section="+section+" and batch="+batch+" and elective='YES' and examid IN (Select examid from semesterinfo.semester_elective_students where student_id='"+student_id+"')");
        while(rs.next()){
            //out.print("<br>3.insert into semesterinfo.semester_mark_info(student_id,examid,internal,external,result,moe,yoe) values('"+student_id+"','"+rs.getString("examid")+"','"+request.getParameter("int"+rs.getString("examid"))+"','"+request.getParameter("ext"+rs.getString("examid"))+"','"+request.getParameter("res"+rs.getString("examid"))+"','"+moe+"',"+yoe+")");
             statement.executeUpdate("delete from semesterinfo.semester_mark_info where student_id='"+student_id+"' and examid='"+rs.getString("examid")+"' and moe='"+moe+"' and yoe='"+yoe+"'");
             stmt.executeUpdate("insert into semesterinfo.semester_mark_info(student_id,examid,internal,external,result,moe,yoe) values('"+student_id+"','"+rs.getString("examid")+"','"+request.getParameter("int"+rs.getString("examid"))+"','"+request.getParameter("ext"+rs.getString("examid"))+"','"+request.getParameter("res"+rs.getString("examid"))+"','"+moe+"',"+yoe+")");
        }



        //out.print(sql);
        conn.close();
        con.close();
        connection.close();
        return;
        }else if(request.getParameter("action").toString().equals("showclassreport")){
            int sem = 0,batch = 0,section=0;
            if(request.getParameter("section").equals("undefined")){
                connection.close();
                out.print("<span class=error>Please Select a Section</span>");
                return;
            }else{
            section=Integer.parseInt(request.getParameter("section").toString());
            sem=Integer.parseInt(request.getParameter("semester").toString());
            batch=Integer.parseInt(request.getParameter("batch").toString());
            String Grade="";
            Connection con = DriverManager.getConnection(CONNECTION_URL,USER_NAME,PASSWORD);
            Statement stmt=con.createStatement();
            Connection conn = DriverManager.getConnection(CONNECTION_URL,USER_NAME,PASSWORD);
            Statement statement=conn.createStatement();
            ResultSet rs=st.executeQuery("SELECT subject_id,grade FROM semesterinfo.semester_subject_info where batch="+batch+" and semester="+sem+" and section="+section+"");
            %>

            <table id="classReport">
                  <tr>
                      <th rowspan="2">ID</th>
                      <th rowspan="2">Name</th>
                        <%while(rs.next()){
                            Grade=rs.getString("grade");%>
                        <th <%=(rs.getString("grade").equals("YES"))?"colspan='3'":"colspan='4'"%>><%=rs.getString(1)%></th>
                         <%}%>
                        <th  rowspan='2'><%=(Grade.equals("YES"))?"GPA":"Total"%></th>
                        <th  rowspan='2'>Percent</th>
                        <th  rowspan="2">Rank</th>
                    </tr>

                    <tr>
                        <%rs.first();
                        do{%>
                        <th><%=(Grade.equals("YES"))?"Cr":"It"%></th>
                        <th><%=(Grade.equals("YES"))?"Gr":"Et"%></th>
                        <%=(Grade.equals("YES"))?"":"<th>Tot</th>"%>
                        <th>P/F</th>
                        <%}while(rs.next());%>
                    </tr>

               <% 
               ResultSet rset=stmt.executeQuery("SELECT student_id,student_name FROM semesterinfo.semester_students_info where batch="+batch+" and semester="+sem+" and section="+section+"");
               while(rset.next()){
                int total=0,no_subj=0,credit=0;
               double percent=0,gpa=0;%>
                 <tr>
                    <td><%=rset.getString(1).substring(rset.getString(1).length()-2)%></td>
                    <td><%=rset.getString(2)%></td>
                    <%
                rs=st.executeQuery("SELECT subject_id,examid,grade FROM semesterinfo.semester_subject_info where batch="+batch+" and semester="+sem+" and section="+section+"");
                 while(rs.next()){
                     no_subj++;
                     ResultSet rset1=statement.executeQuery("SELECT internal,external,result FROM semesterinfo.semester_mark_info where student_id='"+rset.getString("student_id")+"' and examid="+rs.getString("examid")+"");
                    if(rset1.next()){
                    Grade= rs.getString("grade");
                    if(Grade.equals("YES")){
                        credit+=rset1.getInt(2);
                        int i=0;
                        for(i=0;i<=GRADE_LETTER.length;i++)
                            if(GRADE_LETTER[i].equals(rset1.getString(1)))
                                break;
                        total+=rset1.getInt(2)*GRADE_POINT[i];
                        //out.print(i+""+rset1.getString(2)+""+rset.getString(2)+""+total);
                    }else{
                        total+=rset1.getInt(1)+rset1.getInt(2);
                    }
                        %>
                    <td align="center"><%=rset1.getString(1)%></td>
                    <td align="center"><%=rset1.getString(2)%></td>
                    <%=(rs.getString("grade").equals("YES"))?"":"<td align='center'>"+(rset1.getInt(1)+rset1.getInt(2))+"</td>"%>
                    <td align="center"><%=rset1.getString(3).substring(0,1)%></td>
                    <%}else{%>
                    <td>-</td>
                    <td>-</td>
                    <%=(rs.getString("grade").equals("YES"))?"":"<td>-</td>"%>
                    <td>-</td>
                    <%}
                    }java.util.Formatter fmt_gpa=new java.util.Formatter();
                     java.util.Formatter fmt_percent=new java.util.Formatter();
                      if(Grade.equals("YES")){
                      gpa=((double)total/credit);
                      percent=(double)gpa*10;
                      fmt_gpa.format("%.2f", gpa);
                      fmt_percent.format("%.2f", percent);
                     }else{
                      percent=((double)total/no_subj*100)/100;
                      fmt_percent.format("%.2f", percent);
                     }
                    %>
                     <td><%=(Grade.equals("YES"))?fmt_gpa:total%></td>
                     <td><%=fmt_percent%></td>
                   <td>1</td>
                </tr>
             <%}%>

             </table>
                        <%
            con.close();
            conn.close();
            }
        }else if(request.getParameter("action").toString().equals("showsubjectreport")){
            int sem = 0,batch = 0,section=0;
            if(request.getParameter("section").equals("undefined")){
                connection.close();
                out.print("<span class=error>Please Select a Section</span>");
                return;
            }else{
            section=Integer.parseInt(request.getParameter("section").toString());
            sem=Integer.parseInt(request.getParameter("semester").toString());
            batch=Integer.parseInt(request.getParameter("batch").toString());
            Connection con = DriverManager.getConnection(CONNECTION_URL,USER_NAME,PASSWORD);
            Statement stmt=con.createStatement();
           
            %>

            <table id="classReport">
                  <tr>
                      <th>Code</th>
                      <th>Subject</th>
                      <th>Faculty</th>
                      <th>#App</th>
                      <th>#Pass</th>
                      <th>#Fail</th>
                      <th>Pass%</th>
                      <th>#Dist</th>
                      <th>Cls Avg</th>
                    </tr>
              <%ResultSet rs=st.executeQuery("SELECT subject_name,subject_id,faculty_name,examid,grade FROM semesterinfo.semester_subject_info where batch="+batch+" and semester="+sem+" and section="+section+" and elective ='null'");
              while(rs.next()){
                  int appeared=0,pass=0,fail=0,dist=0,cls_avg=0;
                    double pass_pct=0;%>
                 <tr>
                    <td><%=rs.getString("subject_id")%></td>
                    <td><%=rs.getString("subject_name")%></td>
                    <td><%=rs.getString("faculty_name")%></td>
                    <%java.util.Formatter fmt_percent=new java.util.Formatter();
                    ResultSet rset=stmt.executeQuery("SELECT concat(count(student_id),'-1') FROM semesterinfo.semester_students_info where batch="+batch+" and semester="+sem+" and section="+section+" union SELECT concat(count(student_id),'-2') FROM semesterinfo.semester_mark_info where examid="+rs.getString("examid")+" and result like 'Pass' union SELECT concat(count(student_id),'-3') FROM semesterinfo.semester_mark_info where examid="+rs.getString("examid")+" and result like 'Fail'");
                    if(rset.next()){
                    appeared=Integer.parseInt(rset.getString(1).split("-")[0]);
                    if(rset.next())
                    pass=Integer.parseInt(rset.getString(1).split("-")[0]);
                    if(rset.next())
                    fail=Integer.parseInt(rset.getString(1).split("-")[0]);
                    pass_pct=((double)pass/appeared)*100;
                    fmt_percent.format("%.2f", pass_pct);}
                    %>
                    <td><%=appeared%></td>
                    <td><%=pass%></td>
                    <td><%=fail%></td>
                    <td><%=fmt_percent%></td>
                    <td><%=dist%></td>
                    <td><%=cls_avg%></td>
                 </tr>
                    <%}%>
                 <%rs=st.executeQuery("SELECT subject_name,subject_id,faculty_name,examid,grade FROM semesterinfo.semester_subject_info where batch="+batch+" and semester="+sem+" and section="+section+" and elective ='YES'");
              while(rs.next()){
                  int appeared=0,pass=0,fail=0,dist=0,cls_avg=0;
                  double pass_pct=0;  %>
                 <tr>
                    <td><%=rs.getString("subject_id")%></td>
                    <td><%=rs.getString("subject_name")%></td>
                    <td><%=rs.getString("faculty_name")%></td>
                    <%
                    java.util.Formatter fmt_percent=new java.util.Formatter();
                    ResultSet rset=stmt.executeQuery("SELECT concat(count(student_id),'-1') FROM semesterinfo.semester_elective_students where examid="+rs.getString("examid")+" union SELECT concat(count(student_id),'-2') FROM semesterinfo.semester_mark_info where examid="+rs.getString("examid")+" and result like 'Pass' union SELECT concat(count(student_id),'-3') FROM semesterinfo.semester_mark_info where examid="+rs.getString("examid")+" and result like 'Fail'");
                    if(rset.next()){
                    appeared=Integer.parseInt(rset.getString(1).split("-")[0]);
                    if(rset.next())
                    pass=Integer.parseInt(rset.getString(1).split("-")[0]);
                    if(rset.next())
                    fail=Integer.parseInt(rset.getString(1).split("-")[0]);
                    pass_pct=((double)pass/appeared)*100;
                    fmt_percent.format("%.2f", pass_pct);}
                    %>
                    <td><%=appeared%></td>
                    <td><%=pass%></td>
                    <td><%=fail%></td>
                    <td><%=fmt_percent%></td>
                    <td><%=dist%></td>
                    <td><%=cls_avg%></td>
                 </tr>
                    <%}%>
                     </table>
            <%
            con.close();
            
            }
        }else if(request.getParameter("action").toString().equals("overallreport")){
            int sem = 0,batch = 0,section=0;
            int total=0,no_subj=0,credit=0,grand_total=0,grand_subj_total=0,grand_credit_total=0,arrears=0;
            double percent=0,gpa=0;
            String Grade="";
            if(request.getParameter("section").equals("undefined")){
                connection.close();
                out.print("<span class=error>Please Select a Section</span>");
                return;
            }else{
            section=Integer.parseInt(request.getParameter("section").toString());
            batch=Integer.parseInt(request.getParameter("batch").toString());
            Connection con = DriverManager.getConnection(CONNECTION_URL,USER_NAME,PASSWORD);
            Statement stmt=con.createStatement();
            Connection conn = DriverManager.getConnection(CONNECTION_URL,USER_NAME,PASSWORD);
            Statement statement=conn.createStatement();
            ResultSet rs=st.executeQuery("SELECT grade FROM semesterinfo.semester_subject_info where batch="+batch+" group by grade");
             if(rs.next())
                 Grade=rs.getString(1);
            rs=st.executeQuery("SELECT max(semester) FROM semesterinfo.semester_subject_info where batch="+batch+"");
             if(rs.next())
                 sem=rs.getInt(1);
             %>
            <table id="classReport">
                  <tr>
                      <th>ID</th>
                      <th>Name</th>
                        <%for(int i=1;i<=sem;i++){%>
                        <th><%=(Grade.equals("YES"))?"SGPA-"+i+"":"Sem-"+i+"%"%></th>
                        <%}%>
                      <th><%=(Grade.equals("YES"))?"CGPA":"Overall-%"%></th>
                      <th>Arrears</th>
                      <th>Rank</th>
                    </tr>
              <%ResultSet rset=stmt.executeQuery("SELECT DISTINCT student_id,student_name FROM semesterinfo.semester_students_info where batch="+batch+" and section="+section+" order by student_name");
               while(rset.next()){
                grand_total=0;
                grand_subj_total=0;
                grand_credit_total=0;
                arrears=0;%>
                 <tr>
                    <td><%=rset.getString(1).substring(rset.getString(1).length()-2)%></td>
                    <td><%=rset.getString(2)%></td>
                    <%for(int i=1;i<=sem;i++){
                        total=0;no_subj=0;credit=0;percent=0;gpa=0;
                        rs=st.executeQuery("SELECT internal,external FROM semesterinfo.semester_mark_info where student_id="+rset.getString(1)+" and result='Pass' and examid in (SELECT examid FROM semesterinfo.semester_subject_info where semester="+i+" and batch="+batch+")");
                         while(rs.next()){
                             if(Grade.equals("YES"))
                             {credit+=rs.getInt(2);
                                 int j=0;
                                 for(j=0;j<=GRADE_LETTER.length;j++)
                                    if(GRADE_LETTER[j].equals(rs.getString(1)))
                                        break;
                                 total+=rs.getInt(2)*GRADE_POINT[j];
                             }else if(Grade.equals("null")){
                                 no_subj++;
                                 total+=rs.getInt(1)+rs.getInt(2);
                             }
                             //out.print(total+"-"+credit+" -");
                             }
                        rs=st.executeQuery("SELECT examid FROM semesterinfo.semester_subject_info WHERE semester ="+i+" and section="+section+" and (examid) IN (SELECT DISTINCT examid FROM semesterinfo.semester_mark_info where student_id="+rset.getString(1)+" and result='Fail' and (examid)NOT IN (SELECT examid FROM semesterinfo.semester_mark_info where student_id="+rset.getString(1)+" and result='Pass'))");
                         while(rs.next()){
                           // out.print("SELECT internal,external FROM semesterinfo.semester_mark_info where student_id='"+rset.getString(1)+"' and examid="+rs.getString("examid")+" order by yoe desc,moe desc limit 1");
                             ResultSet rset1=statement.executeQuery("SELECT internal,external FROM semesterinfo.semester_mark_info where student_id='"+rset.getString(1)+"' and examid="+rs.getString("examid")+" order by yoe desc,moe desc limit 1");
                                if(rset1.next()){
                                    arrears++;
                                    if(Grade.equals("YES"))
                                     {
                                         credit+=rset1.getInt(2);
                                         int j=0;
                                         for(j=0;j<=GRADE_LETTER.length;j++)
                                            if(GRADE_LETTER[j].equals(rset1.getString(1)))
                                                break;
                                         //out.print(rset1.getInt(1)*GRADE_POINT[j]+" -"+rset1.getString(2));
                                         total+=rset1.getInt(2)*GRADE_POINT[j];
                                     }else if(Grade.equals("null")){
                                         no_subj++;
                                         total+=rset1.getInt(1)+rset1.getInt(2);
                                     }
                                }
                             //out.print(total+"-f"+credit+" -");
                             }
                             java.util.Formatter fmt_gpa=new java.util.Formatter();
                             java.util.Formatter fmt_percent=new java.util.Formatter();
                               if(Grade.equals("YES")){
                                  if(credit==0)
                                    gpa=0;
                                  else{
                                    grand_total+=total;
                                    grand_credit_total+=credit;
                                    gpa=(double)total/credit;
                                    }
                                 fmt_gpa.format("%.2f", gpa);
                                }else if(Grade.equals("null")){
                                  if(no_subj==0)
                                      percent=0;
                                  else{
                                      grand_total+=total;
                                      grand_subj_total+=no_subj;
                                      percent=((double)total/no_subj);
                                      }
                                  fmt_percent.format("%.2f", percent);
                                }
                                %>
                                <td align="center"><%=Grade.equals("YES")?fmt_gpa:fmt_percent+"-%"%></td>
                                <%} 
                             java.util.Formatter fmt_sgpa=new java.util.Formatter();
                             java.util.Formatter fmt_ovr_percent=new java.util.Formatter();
                             double sgpa=0,ovr_percent=0;
                             if(Grade.equals("YES")){
                              if(grand_credit_total==0)
                                sgpa=0;
                              else
                                sgpa=(double)grand_total/grand_credit_total;
                              fmt_sgpa.format("%.2f", sgpa);
                             }else if(Grade.equals("null")){
                               if(grand_subj_total==0)
                                   ovr_percent=0;
                               else
                                   ovr_percent=((double)grand_total/grand_subj_total);
                               fmt_ovr_percent.format("%.2f", ovr_percent);
                            }   
                             %>
                                <td><%=Grade.equals("YES")?fmt_sgpa:fmt_ovr_percent+"-%"%></td>
                                <td><%=arrears%></td>
                                <td>to be calculated</td>
                </tr>
             <%}%>

             </table>
                        <%
            con.close();
            conn.close();
            }
        }connection.close();

  }catch(Exception e){
        out.print("<span class=error>"+e.toString()+"</span>");
    }

%>