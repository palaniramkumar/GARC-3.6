   <!--
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
  -->

<jsp:directive.page import="java.sql.*"  errorPage="../exception.jsp" />
<%
try {
        Class.forName("org.gjt.mm.mysql.Driver");
        Connection connection = DriverManager.getConnection("jdbc:mysql://localhost:3306/garc?user=root&password=garc@somca");
        Statement statement = connection.createStatement();
        ResultSet rs;
        
        if(request.getParameter("action")!=null && request.getParameter("action").equals("execute")){
            if(!(request.getParameter("sql").startsWith("select") || request.getParameter("sql").trim().startsWith("show") || request.getParameter("sql").startsWith("desc"))){
               int no=statement.executeUpdate(request.getParameter("sql"));
               out.print(no + " Row(s) Affected");
               connection.close();
               return;
            }
            boolean desc=(request.getParameter("sql").trim().startsWith("desc"))?true:false;
            rs=statement.executeQuery(request.getParameter("sql"));
            ResultSetMetaData header = rs.getMetaData();
            int totalfield=header.getColumnCount();
            %>
            <table>
            <tr>
            <%
            for(int i=1;i<=totalfield;i++){
                %>
                <td ><%= header.getColumnName(i) %></td>
                <%
                }
            %></tr>
                <%
            while(rs.next()){
                %>
                <tr>
            <%
                for(int i=1;i<=totalfield;i++){
                    %>
                    <td <%=(desc)?"":" onclick= showDesc('"+rs.getString(i)+"')"%>><%=rs.getString(i)%></td>
                <%
                }
                %></tr><%
            }
            %></table><%
            return;
        }
        connection.close();

    }
catch(Exception e){
    out.print(e.toString());
    return;
    }


%>

<head>
    <script src="js/jquery.js"></script>
    <script>
        $(function(){
                   showTables();
                });
         function encodeMyHtml(url) {
                encodedHtml = escape(url);
                encodedHtml = encodedHtml.replace(/\//g,"%2F");
                encodedHtml = encodedHtml.replace(/\?/g,"%3F");
                encodedHtml = encodedHtml.replace(/=/g,"%3D");
                encodedHtml = encodedHtml.replace(/&/g,"%26");
                encodedHtml = encodedHtml.replace(/@/g,"%40");
                encodedHtml = encodedHtml.replace(/\+/g,"%2B");
                return encodedHtml;
}
        function executeQuery(){
              $.ajax({
                type: "POST",
                url: "QueryBrowser.jsp",
                data: "action=execute&sql="+encodeMyHtml($('#query').val()),
                success: function(msg){
                    $('#resultset').html(msg);
                }
            });
        }
        function showTables(){
              $.ajax({
                type: "POST",
                url: "QueryBrowser.jsp",
                data: "action=execute&sql="+encodeMyHtml("show tables"),
                success: function(msg){
                    $('#schema').html(msg);
                }
            });
        }
         function showDesc(tablename){
           
              $.ajax({
                type: "POST",
                url: "QueryBrowser.jsp",
                data: "action=execute&sql="+encodeMyHtml("desc "+tablename),
                success: function(msg){
                    $('#resultset').html(msg);
                }
            });
        }
    </script>
    <title></title>
</head>

<body style="width:100%">
    <table  width="95%">
        <tr valign="top">
        <td colspan="2" style="border:1px black dashed;padding:5px;margin:5px;">
            <textarea id="query" style="width:100%;height:100px;"> </textarea>
            <input type="button" value="Execute" onclick="executeQuery()">
        </td>
    </tr>
    <tr valign="top">
        <td><div id="resultset"></div></td>
        <td width="200px;"><div id="f5schema"><a href="#" onclick="showTables()">Refresh</a></div><div id="schema"></div></td>
    </tr>
    <tr>
        <td colspan="2"></td>
    </tr>

</table>
</body>
