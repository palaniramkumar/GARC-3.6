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
<jsp:directive.page import="java.sql.*" />
<%@ include file="/common/pageConfig.jsp" %>
<%
Connection connection = DriverManager.getConnection(CONNECTION_URL,USER_NAME,PASSWORD);
   Statement statement = connection.createStatement();
    int i=0;
     String client_id=session.getAttribute("userid").toString();
    String sql="select exam_name,duration from exam_master where exam_id='"+request.getParameter("exam_id")+"'";
    ResultSet rs=statement.executeQuery(sql);
    if(!rs.next())
        return;
    int time=rs.getInt(2);
    String exam_name=rs.getString(1);

    /* delete previous client result (enable-reappear)*/
    sql="delete from user_answer where exam_id='"+request.getParameter("exam_id")+"' and user_id='"+client_id+"'";
    statement.executeUpdate(sql);
    /*--- end of deletion--*/
    
    sql="select count(*) from questionset where exam_id='"+request.getParameter("exam_id")+"'";
    rs=statement.executeQuery(sql);
    if(!rs.next())
        return;
    int total_question=rs.getInt(1);
    sql="select qid from questionset where exam_id='"+request.getParameter("exam_id")+"'";
    rs=statement.executeQuery(sql);
%>
            var arr;
            var qset;
            var exam_id="<%=request.getParameter("exam_id")%>";
            function randomize(){
                arr=new Array()
                
                for(var i=1;i<=<%=total_question%>;i++){// 30 is no of questions
                    var no=Math.round(Math.random()*(<%=total_question%>))
                    for(var j=1;j<=i;j++)
                        if((arr[j]==no) || (no==0) || (no==<%=total_question%>+1))
                            break
                        if(i+1!=j){
                            i=i-1
                            continue
                        }
                    arr[i]=no

                }
                qset=new Array();
                <%while(rs.next()){%>
                    qset[<%=++i%>]=<%=rs.getInt(1)%>
                <%}%>
                                             
            }

  function CheckExpire(){
                if(periods[4] +periods[5] +periods[6] ==0){
                    alert("time up!");
                    window.location="GQuestEndExam.jsp?exam_id=<%=request.getParameter("exam_id")%>";
                }
            }
            function qdisplay(no){                
                $('#timer').countdown('pause');
                
                url="exam_id="+exam_id+"&no="+no+"&actno="+qset[arr[no]]+"&rand="+Math.random();
                $.ajax({
                            type: "POST",
                            url: "questiondisplayAjax.jsp",
                            data: url,
                            success: function(msg){                                
                                $("#result").html(msg)
                                $('#timer').countdown('resume');
                            }
                        });
            }
            function clientanswer(cnt,no){
                $('#timer').countdown('pause');
                var ans=""
                for(var i=1;i<=parseInt(cnt);i++){
                    if(document.getElementById(i).checked==true)
                        ans+=i+"#"
                }
                url="qno="+qset[arr[no]]+"&ans="+ans+"&rand="+Math.random()+"&exam_id="+exam_id
                //alert(url);
                $('#change').html("Please Wait..")
                        $.ajax({
                            type: "POST",
                            url: "addclientansAjax.jsp",
                            data: url,
                            success: function(msg){
                                //alert(msg)
                                qdisplay(parseInt(no)+1)
                            }
                        });
            }

<%connection.close(); %>