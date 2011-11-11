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
<title>Orders</title>
<link rel="stylesheet" type="text/css" href="css/main.css" />
<meta charset="utf-8">
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
<h1>not admin sorry</h1>
</body>
</html>
<%
	return;
}

%>
<%
List<POOrder> orders = null;
POUser pouser = null;
	
orders = Dao.INSTANCE.listPOOrders();
if (orders == null) {

%>
</body>
</html>
<%
return;
}
%>

<%	


double [] total = new double[5];

for ( POOrder o : orders) {
	total[o.getStatusInt()-1] += Double.parseDouble(o.getPrice());	
}
%>
<h2>totals</h2>
<% 
for ( double d : total) {
%>
$
<%=new java.text.DecimalFormat("0.00").format(d)%>
<%
 }
%>
<%
POOrder order = null;
java.util.ListIterator<POOrder> iter = orders.listIterator(orders.size());
while (iter.hasPrevious()) {
	order = (POOrder) iter.previous();	
	
%>
<div class="card">
	<div class="cardhead">
		<img class="cardimg" src="<%=order.getPhotoid()%>" />
	</div>
	<div class="cardbody">
		<%=order.getCustomeremail() %>
		<%=order.getStatusString()%>
		<br />
		<%=order.getAlbumid() %>
		<br />
		<%=order.getOrderdate()%><br />
		<%=order.getType()%>
		<br />
		<%=order.getQuantity()%>, $
		<%=order.getPrice()%>
		<br /> <a class="done" href="/d?id=<%=order.getId()%>">del</a>
	</div>
</div>
<%
}
%>
</body>
</html>

