<%@page import="java.net.CookieManager"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.util.List"%>
<%@ page import="com.google.appengine.api.users.User"%>
<%@ page import="com.google.appengine.api.users.UserService"%>
<%@ page import="com.google.appengine.api.users.UserServiceFactory"%>
<%@ page import="info.berryworks.photoorder.model.POUser"%>
<%@ page import="info.berryworks.photoorder.model.POGroup"%>
<%@ page import="info.berryworks.photoorder.dao.Dao"%>
<%@page import="java.util.ArrayList"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link rel="stylesheet" type="text/css" href="css/main.css" />
<title>Users</title>
</head>
<body>
	<a href="/"><img src="./img/shellyphoto.png" /> </a>
	<br />

	<%
UserService userService = UserServiceFactory.getUserService();
User user = userService.getCurrentUser();

boolean lock = true;

if (user == null) {
	%>
	<a href="<%=userService.createLoginURL(request.getRequestURI())%>">login</a>

</body>
</html>
<%
	return;
}

if ( 0 == user.getEmail().compareTo("dirtslayer@gmail.com") ) lock = false;
if ( 0 == user.getEmail().compareTo("spriestphoto@gmail.com") ) lock = false;

if (lock) {

	%>
<a href="http://berryworks.info">http://berryworks.info</a>
<br />
<a href="http://www.google.com/search?q=j2ee+java">made with java</a>
<br />
<a href="http://www.google.com/search?q=gae+appengine">made with
	google app engine</a>
<br />
<h1>not admin sorry</h1>
</body>
</html>
<%
	return;
}
%>
<a href="/xml.jsp">view all data</a>
<br />
<br />
<br />

<a href="/POGroupApplication.jsp">add / remove groups</a>
<br />
<br />
<br />

<a href="/POAlbumApplication.jsp">add / remove albums</a>
<br />
<br />
<br />

<a href="/POUserApplication.jsp">add / remove users</a>
<br />
<br />
<br />

<a href="/POPhotoApplication.jsp">add / remove photos</a>
<br />
<br />
<br />

<a href="/POOrderApplication.jsp">remove orders</a>
<br />
<br />
<br />

<a href="/clear">delete all orders</a>
<br />
<br />
<br />

<a href="http://berryworks.info">made by http://berryworks.info</a>
<br />
<img
	src="http://code.google.com/appengine/images/appengine-noborder-120x30.gif"
	alt="Powered by Google App Engine" />

</body>
</html>