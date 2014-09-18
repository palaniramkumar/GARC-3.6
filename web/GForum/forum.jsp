<%--
    Document   : forum
    Created on : Unknown
    Author     : Rankumar
--%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
<title>FORUM</title>

<!--// SCRIPTS FOR DROPDOWN AND TABBED INTERFACE -->


<script type="text/javascript" src="js/jquery-1.2.6.min.js"></script>
<script type="text/javascript" src="js/jquery-ui-personalized-1.5.2.packed.js"></script>
<script type="text/javascript" src="js/sprinkle.js"></script>
<script type="text/javascript" src="js/js.js"></script>


<!--// FOLLOWING SCRIPT IS FOR PNG FIX IE5.5/IE6-->


<!--[if lt IE 7]>
<script defer type="text/javascript" src="js/pngfix.js"></script>
<![endif]-->


<link href="css/styles.css" rel="stylesheet" type="text/css" />
<link href="css/block.css" rel="stylesheet" type="text/css" />
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

<div id="content">
    <div style="background-color:White;padding:10px;">
        <ul>
         <li  onclick="animateload('showpost.jsp','major','5')"><table><td width="487"><h2> GARC Feed Back </h2><a href="#1" ></a>
	        <blockquote>
	          <p>Discussion Forum for further Development of GARC</p>
          </blockquote></td><td width="101"><div align="center"></div></td>
	</table>
	</li>
        <li onclick="animateload('showpost.jsp','major','1')"><table><td width="487"><h2>Latest Technology</h2>
		<a href="#"></a>
		<blockquote>
		  <p align="justify">Talk about any type of technology such as nanotechnology, windows surfaces</p>
		</blockquote></td>
        <td width="103"><div align="center"><img src="./images/tech.jpg" width="132" height="85" /></div></td>
	</table>
	</li>
        <li  onclick="animateload('showpost.jsp','major','2')"><table><td width="487"><h2>Programming</h2>
		<a href="showtopic.jsp?major=2"></a>
		<blockquote>
		  <p align="justify">Discussion forum for programming language and associated development environment </p>
		</blockquote></td>
        <td width="103"><div align="center"><img src="./images/prog.jpg" width="124" height="93" /></div></td>
	</table>
	</li>
        <li onclick="animateload('showpost.jsp','major','3')"><table><td width="487"><h2>Networking Forum </h2>
		<a href="addtopic.jsp?major=3"></a>
		<blockquote>
		  <p align="justify">Forum for discussing Network technology,Protocols and other network analysis</p>
		</blockquote></td>
        <td width="103"><div align="center"><img src="./images/network.jpg" width="127" height="100" /></div></td>
	</table>
	</li>
        <li onclick="animateload('showpost.jsp','major','4')"><table><td width="487"><h2>Design Forum </h2>
		<a href="./interface/index.html"></a>
		<blockquote>
		  <p align="justify">Forum for discussing flash, graphics, fonts, video and music! Have a question about how to implement something into your website? Ask here. 
</p>
		</blockquote></td>
        <td width="103"><div align="center"><img src="./images/design.jpg" width="118" height="118" /></div></td>
	</table>
	</li>
      <li  onclick="animateload('showpost.jsp','major','5')"><table><td width="487"><h2> Hardware Support </h2><a href="#1" ></a>
	        <blockquote>
	          <p>Issues with PC Hardware </p>
          </blockquote></td><td width="101"><div align="center"><img src="./images/hardware.jpg" width="116" height="116" /></div></td>
	</table>
	</li>
        <li  onclick="animateload('showpost.jsp','major','6')"><table><td width="487"><h2> Management </h2><a href="#1" ></a>
	        <blockquote>
	          <p>Issues with Management Studies</p>
          </blockquote></td><td width="101"><div align="center"><img src="./images/manag.jpg" width="113" height="117" /></div></td>
	</table>
	</li>
</ul>
    </div>
 </div>
	<!--// Buttons ends -->


<!--// Content ends -->
<!--// Searchbox starts -->



<!--// Searchbox ends -->


</body>
</html>
