<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%@ page import="java.util.List"%>
<%@ page import="com.google.appengine.api.users.User"%>
<%@ page import="com.google.appengine.api.users.UserService"%>
<%@ page import="com.google.appengine.api.users.UserServiceFactory"%>
<%@ page import="info.berryworks.photoorder.model.POOrder"%>
<%@ page import="info.berryworks.photoorder.model.POUser"%>
<%@ page import="info.berryworks.photoorder.model.POAlbum"%>
<%@ page import="info.berryworks.photoorder.model.POPhoto"%>
<%@ page import="info.berryworks.photoorder.dao.Dao"%>
<%@page import="java.util.ArrayList"%>

<!DOCTYPE html>
<html>
<head>
<title>Order Add</title>
<link rel="stylesheet" type="text/css" href="css/main.css" />
<meta charset="utf-8">
</head>
<body>
<%
List<POOrder> orders = null;
List<POAlbum> albums = null;
List<POPhoto> photos = null;
POUser pouser = null;
POPhoto pophoto = null;
String albumid = "";
String photourl = "";

UserService userService = UserServiceFactory.getUserService();
User user = userService.getCurrentUser();
	
if (user == null) { %>
	
	</body>
	</html>
<%	return;
}
%>
<%	
	try {
	pouser = Dao.INSTANCE.getPOUser(user.getEmail());
	} catch ( Exception e) {;}
	
	if (pouser == null) {
		
		%>
		<a href="<%=userService.createLoginURL(request.getRequestURI())%>">login</a>
		email admistrator to be granted access
		</body>
		</html>
		<%
		return;
	}
%>
	 		 

<%
albumid = request.getParameter("albumid");
if (albumid == null) { 
	albums = Dao.INSTANCE.getGroupPOAlbums(pouser.getGroupid());
	if (albums == null) return;
	%>
	<h1>Select Album </h1>
<% 	
	for ( POAlbum album : albums ){
%>
	<div class="flowlayout" >
		<form action="/OrderAdd.jsp" method="post" accept-charset="utf-8">
			<input type="hidden" name="albumid" id="albumid" value="<%=album.getName()%>" />	
			<input type="image" src="<%=album.getNotes()%>" name="submit" />
		</form>
		<%=album.getName()%>
	</div>	
<%	
	}
%>
	</body>
	</html>
<%	return;
}
%>
<% 
photourl = request.getParameter("photourl");
if (photourl == null) {
		photos = Dao.INSTANCE.getPOPhotos(albumid);
		if (photos==null){
			return;
		}
	%>

<h1>Select Photo from <%=albumid %></h1>	


<%
	for (POPhoto photo : photos) {
		%>
		<div class="flowlayout" >
		<form action="/OrderAdd.jsp" method="post" accept-charset="utf-8">
			<input type="hidden" name="albumid" id="albumid" value="<%=albumid%>" />
			<input type="hidden" name="photourl" id="photourl" value="<%=photo.getPhotourl()%>" />
			<input type="image" src="<%=photo.getPhotourl()%>" name="submit" />
		</form>
		</div>
		<%
	}
	%>
	</body>
	</html>
	<%
	return;
	
}
%>
<% 	

java.util.Date n = new java.util.Date();


/* 
//i had a human readable date but opted for a more computer managable representation
java.util.TimeZone edmontontz = java.util.TimeZone.getTimeZone("Canada/Mountain");  
java.util.Calendar calendar = new java.util.GregorianCalendar(edmontontz);
java.text.SimpleDateFormat df = new java.text.SimpleDateFormat("MMM dd, hh:mm:ss");
df.setTimeZone(edmontontz);
String orderdate = df.format(n); 
*/

String printtype = request.getParameter("type");

if ( printtype == null ) {
%>
<img src="<%=photourl%>" />
<h1>Choose Format</h1>
<br/>
<br />
<form action="/new" method="post" accept-charset="utf-8">
<input type="hidden" name="photourl" id="photourl" value="<%=photourl%>"  />
<input type="hidden" name="albumid" id="albumid" value="<%=albumid%>"  />
<input type="hidden" name="type" id="type" value="add to cd" />
<input type="hidden" name="orderdate" id="orderdate" value="<%=n.getTime() %>" />
<input  type="hidden" name="quantity" id="quantity" value="1"/>
<input type="submit" name="type" id="type" value="add to cd" />
</form>
<br/><br/><br/>
<form action="/OrderAdd.jsp" method="post" accept-charset="utf-8">
<input type="hidden" name="photourl" id="photourl" value="<%=photourl%>"  />
<input type="hidden" name="albumid" id="albumid" value="<%=albumid%>"  />
<input  type="submit" name="type" id="type" value="16 x 20 wall portrait"/>
<input  type="submit" name="type" id="type" value="8 x 10"/>
<input  type="submit" name="type" id="type" value="5 x 7"/>
<input  type="submit" name="type" id="type" value="4 x 6"/>
<input  type="submit" name="type" id="type" value="3.5 x 5"/>
<input  type="submit" name="type" id="type" value="wallets (8)"/>
	
</form>

<br/><br/>
<pre>
16 x 20 wall portrait		$30.00						
11x14 wall portrait		$20.00						
8x10				$10.00						
5x7				$ 5.00						
4x6				$ 3.00				
3.5x5				$ 2.50						
wallets (8)			$10.00	
add to cd			$ 0.50	
</pre>


</body>
</html>
<%
return;
}
%>
<%

String quantity = request.getParameter("quantity");
if ( quantity == null ) {

%>
<img src="<%=photourl%>" />
<h1>How many <%=printtype %>'s?</h1>
<form action="/new" method="post" accept-charset="utf-8">
<input type="hidden" name="photourl" id="photourl" value="<%=photourl%>"  />
<input type="hidden" name="albumid" id="albumid" value="<%=albumid%>"  />
<input type="hidden" name="type" id="type" value="<%=printtype %>" />
<input type="hidden" name="orderdate" id="orderdate" value="<%=n.getTime() %>" />
<input  type="submit" name="quantity" id="quantity" value="1"/>
<input  type="submit" name="quantity" id="quantity" value="2"/>
<input  type="submit" name="quantity" id="quantity" value="3"/>
<input  type="submit" name="quantity" id="quantity" value="4"/>
<input  type="submit" name="quantity" id="quantity" value="5"/>
<input  type="submit" name="quantity" id="quantity" value="6"/>
<input  type="submit" name="quantity" id="quantity" value="7"/>
<input  type="submit" name="quantity" id="quantity" value="8"/>
<input  type="submit" name="quantity" id="quantity" value="9"/>
<input  type="submit" name="quantity" id="quantity" value="10"/>

	
</form>
</body>
</html>
<%
return;
}
%>



</body>
</html>




