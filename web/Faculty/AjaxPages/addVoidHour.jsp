<%-- 
    Document   : addVoidHour
    Created on : Feb 11, 2011, 12:05:09 AM
    Author     : Ram
--%>
<%@ include file="../../common/pageConfig.jsp" %>
<%
Connection connection =null;
Statement statement = null;
try{
connection=DriverManager.getConnection(CONNECTION_URL,USER_NAME,PASSWORD);
statement=connection.createStatement();
if(request.getParameter("action").equals("none")){
String sql="SELECT year,semester FROM section;";
ResultSet rs=statement.executeQuery(sql);

%>
<table class="clienttable" cellspacing="0">
    <thead>
    <tr   cellpadding="1">
        <th>Year</th><th>
            <select id="semester">
            <%while(rs.next()){%>
            <option value="<%=rs.getString(2)%>"><%=rs.getString(1)%></option>
            <%}%>
        </select>
        </th> 
        <th>Section</th><th>
            <select id="section">
            <%for(int i=0;i<NO_OF_SECTIONS;i++){%>
            <option value="<%=i+1%>"><%=(char)( i+'A') %></option>
            <%}%>
        </select>
        </th> 
        <th>Type</th><th>
            <select id="type">
                <option value="1,Library">Library</option>
                <option value="2,Seminar">Seminar</option>
                <option value="3,Guest Lecture">Guest Lecture</option>
                <option value="4,Aptitude">Aptitude</option>
		    <option value="5,Class Cancelled">Class Cancelled</option>
                    <option value="0,Holiday">Public Holiday</option>
            </select>
        </th>        
        <th>Date</th><th><input type="Text" id="date" size="8" maxlength="8"/></th> 
        <th>Session #</th><th><input type="Text" id="hrs" size="1" maxlength="1"/></th>  
        <td colspan="2"><button onclick="saveVoidHr()">Mark</button></td>  
</thead>
    </tr>
   </table>
        
        <br/>
        <p align="center"><b>Blocked Sessions</b></p>
        <br/>
        
<div class="blockreport"></div>
<%
}
else if(request.getParameter("action").equals("save")){
    
    
    String semester=request.getParameter("semester");
    String hr=request.getParameter("hr");
    String section=request.getParameter("section");;
    String date=request.getParameter("date");
    String type=request.getParameter("type").split(",")[0];    
    String text=request.getParameter("type").split(",")[1];    
    String sql="insert into voidhours values(null,"+type+",'"+text+"',STR_TO_DATE('"+date+"', '%d/%m/%Y'),"+hr+","+semester+",'"+section+"',null,'"+session.getAttribute("userid")+"')";
    
    //out.println(sql);
    if(type.equals("0")){
        for(int i=1;i<=MAX_NO_OF_PERIODS;i++)
                   {
            sql="insert into voidhours values(null,"+type+",'"+text+"',STR_TO_DATE('"+date+"', '%d/%m/%Y'),"+i+","+semester+",'"+section+"',null,'"+session.getAttribute("userid")+"')";
            statement.executeUpdate(sql);
        }
        
    }
    else
        statement.executeUpdate(sql);
    
    out.print("Updated Successfully");
          
}
else if(request.getParameter("action").equals("showall")){
	String sql="select id,text ,hour,semester,section,DATE_FORMAT(day,'%d/%m/%Y') date from voidhours where facultyid='"+session.getAttribute("userid")+"'";
    //out.println(sql);
    ResultSet rs=statement.executeQuery(sql);
	%>
	<table class="clienttable" cellspacing="0"><thead>
	<tr cellpadding="1"><th>Desc</th><th>Session #</th><th>Year</th><th>Section</th><th>Date</th><th>Delete</th></tr>
            </thead>
	<%
	if(!rs.next())
		out.print("<td colspan=5>No Record Found!!!</td>");
	else
    do{
	%>
	<tr><td><%=rs.getString(2)%></td><td><%=rs.getString(3)%></td><td><%=rs.getString(4)%></td><td><%=(char)('A'+rs.getInt(5)-1)%></td><td><%=rs.getString(6)%></td><td><a href='#' onclick='RmBlock(<%=rs.getString(1)%>)'>Delete</a></td>
	<%
	}while(rs.next());
	%>
	</table>
	<%

}
else if(request.getParameter("action").equals("delete")){
	String sql="delete from voidhours where id="+request.getParameter("id");
    
    statement.executeUpdate(sql);
	out.println("Deleted");
	}
connection.close();
}
    catch(Exception e){
        out.println(e.toString());
    }
%>