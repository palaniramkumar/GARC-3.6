/*
 *        Copyright (C) 2010  Palani Ramkumar.K

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
 

 *
 */




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

function FacultyProfile(){
url="AjaxPages/FacultyProfile.jsp"
//alert("hi")
$.ajax({
                type: "POST",
                url: url,
                data:"action=none&rand="+Math.random(),
                success: function(msg){
                        //alert("hi")
                        $('#status').html("<center>Loaded Successful</center>");
                        //alert(msg)
                        $('#top_div').html(msg)
                        $('#bottom_div').html("");


                   }
 });
}


