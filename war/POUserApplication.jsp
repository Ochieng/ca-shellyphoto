<%@ page language="java" contentType="text/html; charset=UTF-8"pageEncoding="UTF-8"%>
<%@ page import="java.util.List" %>
<%@ page import="com.google.appengine.api.users.User" %>
<%@ page import="com.google.appengine.api.users.UserService" %>
<%@ page import="com.google.appengine.api.users.UserServiceFactory" %>
<%@ page import="info.berryworks.photoorder.model.POUser" %>
<%@ page import="info.berryworks.photoorder.model.POGroup" %>
<%@ page import="info.berryworks.photoorder.dao.Dao" %>
<%@page import="java.util.ArrayList"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link rel="stylesheet" type="text/css" href="css/main.css"/>
<title>Users</title>
</head>
<body>
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
	<h1> not admin sorry </h1>
	</body>
	</html>
	<%
	return;
}


List< POUser> pousers = null;
List< POGroup> pogroups = null;

pousers = Dao.INSTANCE.listPOUsers(); 
    
%>
	Users
			

<table>
  <tr>
  	  <th> id </th>
      <th>name</th>
      <th>address</th>
      <th>email</th>
      <th>group</th>     
      <th>mobile</th>
      <th>telephone</th>
      <th>notes</th>
    </tr>

<%for (POUser pouser : pousers ){ %>
<tr> 
<td>
<%= pouser.getId() %>
</td>
<td>
<%= pouser.getName() %>
</td>
<td>
<%= pouser.getAddress() %>
<td>
<%= pouser.getEmail() %>
</td>
<td>
<%= pouser.getGroupid() %>
</td>
<td>
<%= pouser.getMobile() %>
</td>
<td>
<%= pouser.getTelephone() %>
</td>
<td>
<%= pouser.getNotes() %>
</td>

<td>
<a class="delpou" href="/delpou?id=<%=pouser.getId()%>" >del</a>
</td>
</tr> 
<%}
%>
</table>


<hr />

New User


<form action="/newpou" method="post" accept-charset="utf-8">
	<table>
		
		<tr>
			<td><label for="name">Name </label></td> <!--  will have a lookup and image here -->
			<td><input type="text" name="name" id="name" size="65"/></td>
		</tr>
		<tr>
			<td><label for="email">Email </label></td> <!--  will have a lookup and image here -->
			<td><input type="text" name="email" id="email" size="65"/></td>
		</tr>
		<tr>
			<td><label for="groupid">Group </label></td> 
			
			<td><select type="text" name="groupid" id="groupid" >
			<% pogroups = Dao.INSTANCE.listPOGroups();
			   for (POGroup group : pogroups) {%>
			<option value="<%= group.getName() %>"> <%= group.getName() %> </option> 
			<% } %>
			</td>
		</tr>
		<tr>
			<td><label for="mobile">Mobile </label></td> <!--  will have a lookup and image here -->
			<td><input type="text" name="mobile" id="mobile" size="65"/></td>
		</tr>
		<tr>
			<td><label for="telephone">Telephone </label></td> <!--  will have a lookup and image here -->
			<td><input type="text" name="telephone" id="telephone" size="65"/></td>
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


</div>
</body>
</html>