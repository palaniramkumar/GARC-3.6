<%-- 
    Document   : forum
    Created on : Oct 21, 2009, 12:17:11 PM
    Author     : Ramkumar
--%>
<%

    if(session.getAttribute("userid")==null){
        %>
        <script>
            alert("Session Expired");
            window.location="../";
        </script>
        <%
        return;
    }
 %>
    <%@ include file="../config/BBList.jsp" %>
    <div style="background-color:White;padding:10px;">
        <ul class="bblist">
            <%for(int i = 0 ;i<BBList.length;i++){%>
         <li  onclick="animateload('ShowPost.jsp','major','<%=i%>')"><table><td width="487"><h2> <%=BBList[i]%> </h2><a href="#1" ></a>
	        <blockquote>
	          <p><%=BBDesc[i]%></p>
          </blockquote></td><td width="103"><div align="center"><img src="./images/<%=icon%>.jpg" width="132" height="85" /></div></td>
	</table>
	</li>
        <%}%>
      </ul>
    </div>