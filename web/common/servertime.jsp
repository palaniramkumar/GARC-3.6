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
    Document   : servertime
    Created on : Apr 3, 2009, 8:37:05 PM
    Author     : Ramkumar
--%>

<%
        java.util.Date d=new  java.util.Date();
%>

var montharray=new Array("January","February","March","April","May","June","July","August","September","October","November","December")
var currenttime =<%int hrs=((d.getHours()>12)?d.getHours()-12:(d.getHours()==0)?12:d.getHours());out.print("montharray["+d.getMonth()+"]+' "+d.getDate()+", "+(d.getYear()+1900)+" "+hrs+":"+d.getMinutes()+":"+d.getSeconds());%>'
var serverdate=new Date(currenttime)

function padlength(what){
var output=(what.toString().length==1)? "0"+what : what
return output
}

function displaytime(){
serverdate.setSeconds(serverdate.getSeconds()+1)
var datestring=montharray[serverdate.getMonth()]+" "+padlength(serverdate.getDate())+", "+serverdate.getFullYear()
var timestring=padlength(serverdate.getHours())+":"+padlength(serverdate.getMinutes())+":"+padlength(serverdate.getSeconds())
document.getElementById("servertime").innerHTML=datestring+" "+timestring
}


displaytime()
setInterval("displaytime()", 1000)



