<%-- 
    Document   : redirect
    Created on : Oct 22, 2009, 3:40:45 AM
    Author     : Ramkumar
--%>
<%
if(session.getAttribute("usertype")==null)
    response.sendRedirect("../");
else if(session.getAttribute("usertype").toString().equalsIgnoreCase("student"))
    response.sendRedirect("../Student");
else
    response.sendRedirect("../Faculty");
%>