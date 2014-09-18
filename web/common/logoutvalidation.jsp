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
    Document   : logoutvalidation
    Created on : Apr 3, 2009, 8:20:32 PM
    Author     : Ramkumar
--%>
Please wait ...
<%
session.removeAttribute("staff_id");
session.removeAttribute("userid");
session.removeAttribute("dept");
session.removeAttribute("dept");
session.removeAttribute("class_incharge");
session.removeAttribute("subject_id");
session.removeAttribute("semester");
session.removeAttribute("section");
session.removeAttribute("elective");
session.removeAttribute("usertype");
response.sendRedirect("../index.jsp");
%>