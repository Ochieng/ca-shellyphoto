<%@page import="java.net.CookieManager"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.util.List" %>
<%@ page import="com.google.appengine.api.users.User" %>
<%@ page import="com.google.appengine.api.users.UserService" %>
<%@ page import="com.google.appengine.api.users.UserServiceFactory" %>
<%@ page import="info.berryworks.photoorder.model.POAlbum" %>
<%@ page import="info.berryworks.photoorder.model.POGroup" %>
<%@ page import="info.berryworks.photoorder.dao.Dao" %>
<%@page import="java.util.ArrayList"%>
    
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link rel="stylesheet" type="text/css" href="css/main.css"/>
<title>Albums</title>
</head>
<body>
<%


Dao dao = Dao.INSTANCE;

UserService userService = UserServiceFactory.getUserService();
User user = userService.getCurrentUser();

boolean lock = true;

if (user == null) {
	%>
	</body>
	</html>
	<%
	return;
}



if ( 0 == user.getEmail().compareTo("dirtslayer@gmail.com") ) lock = false;
if ( 0 == user.getEmail().compareTo("spriestphoto@gmail.com") ) lock = false;

if (lock) {

	%>
	</body>
	</html>
	<%
	return;
}

List< POAlbum > poalbums = null;
List< POGroup > pogroups = null;
poalbums = dao.listPOAlbums();
 
    
%>
	Albums

<table>
  <tr>
  	  <th> id </th>
      <th>name</th>
      <th>groupid</th>     
      <th>notes</th>
    </tr>

<%for (POAlbum poalbum : poalbums ){ %>
<tr> 
<td>
<%= poalbum.getId() %>
</td>
<td>
<%= poalbum.getName() %>
</td>
<td>
<%= poalbum.getGroupid() %>
</td>
<td>
<%= poalbum.getNotes() %>
</td>

<td>
<a class="delpoa" href="/delpoa?id=<%=poalbum.getId()%>" >del</a>
</td>
</tr> 
<%}
%>
</table>


<hr />

<div class="main">

<div class="headline">New Album</div>

<% if (user != null){ %> 
<!--



 <th> id </th>
    
      <th>name</th>
      <th>groupid</th>     
     
      <th>notes</th>


<br>-->
<!--Userid <%= user.getUserId() %> -->
<!--<br>-->
<!--Email <%= user.getEmail() %> -->
<form action="/newpoa" method="post" accept-charset="utf-8">
	<table>
		<tr>
			<td><label for="name">Name </label></td> <!--  will have a lookup and image here -->
			<td><input type="text" name="name" id="name" size="65"/></td>
		</tr>
		
		<tr>
			<td><label for="groupid">Group </label></td> <!--  will have a lookup and image here -->
			<td><select type="text" name="groupid" id="groupid" >
			<% pogroups = dao.listPOGroups();
			   for (POGroup group : pogroups) {%>
			<option value="<%= group.getName() %>"> <%= group.getName() %> </option> 
			<% } %>
			</td>
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