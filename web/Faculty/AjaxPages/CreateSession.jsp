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
    Document   : CreateSession
    Created on : Jul 30, 2009, 10:37:57 PM
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
<%

session.setAttribute("subject_id", request.getParameter("subject_id"));
session.setAttribute("elective",  request.getParameter("elective"));
session.setAttribute("section",  request.getParameter("section"));
session.setAttribute("semester",  request.getParameter("semester"));
session.setAttribute("subject_name",  request.getParameter("subject_name"));

out.print("Created");
%>