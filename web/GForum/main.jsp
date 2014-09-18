<%--
    Document   : main
    Created on : apr 08, 2009, 11:17:33 PM
    Author     : Rankumar
--%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd"> 
<html xmlns="http://www.w3.org/1999/xhtml"> 
<head> 
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" /> 
<title>HOME</title>
 
<!--// SCRIPTS FOR DROPDOWN AND TABBED INTERFACE --> 
 
 
<script type="text/javascript" src="js/jquery-1.2.6.min.js"></script> 
<script type="text/javascript" src="js/jquery-ui-personalized-1.5.2.packed.js"></script> 
<script type="text/javascript" src="js/sprinkle.js"></script> 
<script type="text/javascript" src="js/js.js"></script>  


<!--// FOLLOWING SCRIPT IS FOR PNG FIX IE5.5/IE6--> 
    
 
<!--[if lt IE 7]>
<script defer type="text/javascript" src="js/pngfix.js"></script> 
<![endif]--> 
 
 <link href="css/block.css" rel="stylesheet" type="text/css" />
<link href="css/styles.css" rel="stylesheet" type="text/css" /> 
 
</head> 
<body> 
 
<!--// Horisontal submenu edit starts --> 
 
<div class="bodytext" id="submenu">
  <ul id="nav">
        <li><a href="main.jsp">HOME</a></li>
        <li><a href="forum.jsp">FORUM</a></li>
        <li><a href="post.jsp">POST</a></li>
        <li><a href="feedback.jsp">FEEDBACK</a></li>
    </ul>
</div> 
 
<!--// Horisontal submenu edit ends --> 
<!--// Logo edit starts --> 
 
<div id="logo"> 
  <div align="center"><br /> 
    <img src="images/logo.png" alt="logo" width="116" height="34" /><br /> 
  </div> 
</div> 
 
<!--// logo edit ends --> 
<!--// Arrows edit starts --> 
 
<div id="arrows"></div> 
<div class="bodytext" id="hello">Hello <a href="#"><%=session.getAttribute("name")%>, <img src="images/icons/user.png" alt="user_icon" width="22" height="25" border="0" /></a><br />
</div> 

<!--// Logout edit starts -->

<div id="logout">
  <div align="center">
    <div id="logout_icon"><a href="logout.jsp"><img src="images/icons/big_logout.png" alt="big_logout" width="25" height="25" border="0" /></a></div>
<span class="toplinks"><br />
      <br />
      <a href="logout.jsp"><span class="toplinks">LOG OUT</span></a></span><br />
  </div>
</div>

<!--// logout edit ends --> 
 <div id="poll">Loading ...</div>
<div id="content"> 
    <div style="background-color:White;padding:10px;width:600px;">
 
   <h2>Welcome!</h2>
        <p>Hi, welcome to the GForum.People participating in an Intranet forum can build bonds with each other and interest groups will easily form around a topic's discussion, subjects dealt with in or around sections in the forum.

</p>
        <p></p>
    </div>
  
 </div>
	<!--// Buttons ends --> 
 
 
<!--// Content ends --> 
<!--// Searchbox starts --> 
 

 
<!--// Searchbox ends --> 
 
 
</body> 
</html> 
 