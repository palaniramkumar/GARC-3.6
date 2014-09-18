<%-- 
    Document   : newUser
    Created on : Jun 16, 2012, 3:33:38 PM
    Author     : Ramkumar
--%>
<%--
 Copyright (C) 2012  GARC

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
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ include file="/common/pageConfig.jsp" %>

<html xmlns="http://www.w3.org/1999/xhtml">
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
        <link type="text/css" rel="stylesheet" href="css/style.css" />
        <link type="text/css" rel="stylesheet" href="css/table-style.css" />
        <script src="js/jquery.js"></script>
        <script src="js/login.js"></script>
        <script src="js/garcEssentials.js"></script>
        <script>
            function changePassword(){
                if($('#pass1').val()!=$('#pass2').val())
                    alert("Password Doesn't Match");
                else{
                    var new_pass = encodeMyHtml($('#pass1').val());
                    var old_pass =encodeMyHtml($('#pass2').val());
                    url="AjaxPages/changeProfile.jsp";
                    $('#status').show();
                    $('#status').html("<center><img src='./images/loading.gif'/>Loading ...</center>");

                    $.ajax({
                        type: "POST",
                        url: url,
                        data:"action=changePass&oldpass="+old_pass+"&newpass="+new_pass+"&rand="+Math.random(),
                        success: function(msg){
                            $('#status').html("<center>"+msg+"</center>");
                            $('#password').val("");
                            $('#oldpass').val("");
                            $('#confirmpassword').val("");
                            t=setTimeout("clearmsg()",3000);
                        }
                    });
                }
            }

        function passwordStrength(password)
        {
            var desc = new Array();
            desc[0] = "Very Weak";
            desc[1] = "Weak";
            desc[2] = "Better";
            desc[3] = "Medium";
            desc[4] = "Strong";
            desc[5] = "Strongest";

            var score   = 0;

            //if password bigger than 6 give 1 point
            if (password.length > 6) score++;

            //if password has both lower and uppercase characters give 1 point	
            if ( ( password.match(/[a-z]/) ) && ( password.match(/[A-Z]/) ) ) score++;

            //if password has at least one number give 1 point
            if (password.match(/\d+/)) score++;

            //if password has at least one special caracther give 1 point
            if ( password.match(/.[!,@,#,$,%,^,&,*,?,_,~,-,(,)]/) )	score++;

            //if password bigger than 12 give another 1 point
            if (password.length > 12) score++;

            document.getElementById("passwordDescription").innerHTML = desc[score];
            document.getElementById("passwordStrength").className = "strength" + score;
        }
        </script>

        <style type="text/css">
            @import url(css/scrolling_table.css);
            @import url(css/credit-styles.css);
            #user_registration
            {
                border:1px solid #cccccc;
                margin:auto auto;
                margin-top:100px;
                width:400px;
            }


            #user_registration label
            {
                display: block;  /* block float the labels to left column, set a width */
                float: left; 
                width: 70px;
                margin: 0px 10px 0px 5px; 
                text-align: right; 
                line-height:1em;
                font-weight:bold;
            }

            #user_registration input
            {
                width:250px;
            }

            #user_registration p
            {
                clear:both;
            }

            #submit
            {
                border:1px solid #cccccc;
                width:150px !important;
                margin:10px;
            }

            h1
            {
                text-align:center;
            }

            #passwordStrength
            {
                height:10px;
                display:block;
                float:left;
            }

            .strength0
            {
                width:100%;
                background:#cccccc;
            }

            .strength1
            {
                width:15%;
                background:#ff0000;
            }

            .strength2
            {
                width:30%;	
                background:#ff5f5f;
            }

            .strength3
            {
                width:60%;
                background:#56e500;
            }

            .strength4
            {
                background:#4dcd00;
                width:75%;
            }

            .strength5
            {
                background:#399800;
                width:100%;
            }


        </style>
        <!--[if IE]>
            <style type="text/css">
                @import url(css/scrolling_table.ie.css);
            </style>
        <![endif]-->

        <title>Garc</title>
    </head>
    <body>
        <div id="status" class="status">Loading ...</div>
        <div id="top_wrapper">
            <div id="banner">


                <div id="logo">
                    <div class="logo1"><img src="./images/garc.png" height="80px" width="150px;"/></div>
                </div>
                <div id="Search_box"><center><%=college%></center></div>
                <div class="logo2" align="right"><%=dept%></div>
                <div id="servertime" align="right">Retriving Server Time...</div>

            </div>
            <div id="menu">
                <div id="hovermenu" class="hovermenu">
                    <ul>
                        <li><a href="common/logoutvalidation.jsp">Logout</a></li>
                    </ul> 

                    <div align="right" style="color:gray;margin-top:-5px;"><%@ include file="./common/SemesterSwich.jsp" %></div>
                    <div style="clear:both"></div>

                </div>

            </div>
            <div style="clear:both"></div>
        </div>

        <div id="content_wrapper">
            <div id="top_div">
                <p><h1>Secure Password </h1></p>
                <table width="50%" style="margin: auto">
                    <tr><td>	
                            <label for="pass">Password</label></td><td><input type="password" name="pass" id="pass1" onkeyup="passwordStrength(this.value)"/>

                        </td></tr>
                    <tr><td>	
                            <label for="pass2">Confirm Password</label></td><td><input type="password" name="pass2" id="pass2" onkeyup="passwordStrength(this.value)"/>
                        </td></tr>
                    <tr><td colspan="2" align="center">	

                            <div id="passwordDescription">Password not entered</div>
                            <div id="passwordStrength" class="strength0"></div>
                        </td></tr>

                    <tr><td colspan="2" align="center">		
                            <input type="submit" name="submit" id="submit" value="Change Password" onclick="changePassword()">
                        </td></tr>
                </table>
            </div>
            <div id="bottom_div">

            </div>
            <div style="clear:both"></div>
        </div>

        <div id="footer_div" class="footer">
            <br />
            <span class="copyright">Visitor Number:<%@ include file="/common/hitcount.jsp" %></span> |
            <span class="copyright">Copyright 2008-<%=new java.util.Date().getYear() - 100%> GARC </span></div>


    </body>
</html>