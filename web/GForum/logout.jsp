<%--
    Document   : logout
    Created on : unknown
    Author     : Rankumar
--%>
<%
session.removeAttribute("name");
session.removeAttribute("id");
%>
<script>
window.location="index.jsp";
</script>