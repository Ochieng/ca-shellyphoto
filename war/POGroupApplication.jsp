<%@page import="java.net.CookieManager"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.util.List" %>
<%@ page import="com.google.appengine.api.users.User" %>
<%@ page import="com.google.appengine.api.users.UserService" %>
<%@ page import="com.google.appengine.api.users.UserServiceFactory" %>
<%@ page import="info.berryworks.photoorder.model.POGroup" %>
<%@ page import="info.berryworks.photoorder.dao.Dao" %>
<%@page import="java.util.ArrayList"%>
    
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link rel="stylesheet" type="text/css" href="css/main.css"/>
<title>Groups</title>
</head>
<body>
<%

String albumid = "use cookie";

Dao dao = Dao.INSTANCE;

UserService userService = UserServiceFactory.getUserService();
User user = userService.getCurrentUser();

String url = userService.createLoginURL(request.getRequestURI());
String urlLinktext = "Login";
List< POGroup > groups = new ArrayList< POGroup >();
            
if (user != null){
    url = userService.createLogoutURL(request.getRequestURI());
    urlLinktext = "Logout";
    System.out.print("getting groups");
    System.out.print("before listPOGroups");
    groups = dao.listPOGroups();
    System.out.print("after listPOGroups");
    System.out.print(" size " + groups.size());
}
    
%>
	<div style="width: 100%;">
		<div class="line"></div>
		<div class="topLine">
		<!-- <div style="float: left;"><img src="images/todo.png" /></div>
			 -->	<div style="float: left;" class="headline">Groups</div>
			<div style="float: right;"><a href="<%=url%>"><%=urlLinktext%></a> <%=(user==null? "" : user.getNickname())%></div>
		</div>
	</div>

<div style="clear: both;">	 </div>
You have a total number of <%= groups.size() %>  groups.


<table>
  <tr>
  	  <th> id </th>
      <th>name</th>
      <th>notes</th>     
      </tr>

<%for (POGroup pogroup : groups ){ %>
<tr> 
<td>
<%= pogroup.getId() %>
</td>
<td>
<%= pogroup.getName() %>
</td><td>
<%= pogroup.getNotes() %>
</td>
<td>
<a class="delpog" href="/delpog?id=<%=pogroup.getId()%>" >del</a>
</td>
</tr> 
<%}
%>
</table>


<hr />

<div class="main">

<div class="headline">New Group</div>

<% if (user != null){ %> 
<!--<br>-->
<!--Userid <%= user.getUserId() %> -->
<!--<br>-->
<!--Email <%= user.getEmail() %> -->
<form action="/newpog" method="post" accept-charset="utf-8">
	<table>
	
		<tr>
			<td><label for="name">Name </label></td> <!--  will have a lookup and image here -->
			<td><input type="text" name="name" id="name" size="65"/></td>
		</tr>
		<tr>
			<td><label for="notes">Notes </label></td> <!--  -->
			<td><input type="text" name="notes" id="notes" size="65"/></td>
			</tr>
	
	<tr>
			<td colspan="2" align="right"><input type="submit" value="Create"/></td>
		</tr>
	</table>
</form>

<% }else{ %>

Please login with your Google account

<% } %>
</div>
</body>
</html>