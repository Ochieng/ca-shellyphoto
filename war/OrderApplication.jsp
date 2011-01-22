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
<script type='text/javascript'>
  //<![CDATA[ 
             
  function setscroll() { 
	  setCookie('scrollpos',pageYOffset,1);
  }
             
  function scroll() {
	  	window.scrollTo(0,getCookie('scrollpos'));
  }
  
  // taken from w3schools javascript cookie reference
  function getCookie(c_name)
  {
  if (document.cookie.length>0)
    {
    c_start=document.cookie.indexOf(c_name + "=");
    if (c_start!=-1)
      {
      c_start=c_start + c_name.length+1;
      c_end=document.cookie.indexOf(";",c_start);
      if (c_end==-1) c_end=document.cookie.length;
      return unescape(document.cookie.substring(c_start,c_end));
      }
    }
  return "0";
  }

  function setCookie(c_name,value,expiredays)
  {
  var exdate=new Date();
  exdate.setDate(exdate.getDate()+expiredays);
  document.cookie=c_name+ "=" +escape(value)+
  ((expiredays==null) ? "" : ";expires="+exdate.toUTCString());
  }
  
  //]]> 
  </script>

</head>
<body onload='scroll()' onunload="setscroll()">
<%
	List<POOrder> orders = null;
	List<POAlbum> albums = null;
	List<POPhoto> photos = null;
	POUser pouser = null;
	POPhoto pophoto = null;
	
	UserService userService = UserServiceFactory.getUserService();
	User user = userService.getCurrentUser();
	
	if (user == null) { %>
		<a href="<%=userService.createLoginURL(request.getRequestURI())%>">login</a>
		</body>
		</html>
<%
	return;
	}
%>
<%	
	try {
	pouser = Dao.INSTANCE.getPOUser(user.getEmail());
	} catch ( Exception e) {;}
	
	if (pouser == null) {
		Dao.INSTANCE.addPOUser(user.getNickname(),user.getEmail(),"","","","","");
		try {
			pouser = Dao.INSTANCE.getPOUser(user.getEmail());
		} catch ( Exception e) {;}
	}
%>
	 <div id="debug"></div>		 
<a href="<%=userService.createLogoutURL(request.getRequestURI())%>" >
Logout 
<%=pouser.getGroupid()%>
<%=(user.getEmail())%>

</a>
<br/>
<br/>
<a href="/OrderAdd.jsp">add to order ...</a>
<br/>
<br/>
<a href="/Confirm.jsp">confirm order ...</a>
<br/>
<%
orders = Dao.INSTANCE.getPOOrders(user.getEmail());
if (orders == null) {
%>
</body>
</html>
<%
return;
}
%>

<%	

Double total = 0.0;
for ( POOrder o : orders) {
	if ( o.getStatusInt() > 1 ) continue;
	total +=  Double.parseDouble(o.getPrice());
}
%>

<h1> total = $<%=new java.text.DecimalFormat("0.00").format(total) %></h1>
<br/>	
	<%
	
// this totally sucks, jpa has a problem with the order by clause, i have
// left the order by clause in Dao.INSTANCE.getPOOrders(user.getEmail());
// because it works in datanucleus at home, run from eclise, 

// but when this same app is hosted by google the order by clause does not work
// so now i have to write a fricken inner class Comaritor and pass it to Sort fuck
// it might be easier to switch to jdo


	
	
	
	
orders = Dao.INSTANCE.getPOOrders(user.getEmail());
	
//POOrder order = null;
//java.util.ListIterator<POOrder> iter = orders.listIterator(orders.size());
//while (iter.hasPrevious()) {
//	order = (POOrder) iter.previous();	
for (POOrder order : orders)	 {
	if ( order.getStatusInt() > 1 ) continue;
	
%>
	<div class="card">	
	<div class="cardhead">
	<img class="cardimg" src="<%=order.getPhotoid()%>" />
	</div>
	<div class="cardbody" >	
	<%=order.getAlbumid() %> <br />
	<%=order.getType()%> <br />
	<%if ( order.getType().compareTo("add to cd") != 0 ) {
		%> <%=order.getQuantity()%>, 
	<% } %>
	$ <%=order.getPrice()%> <br />
	<a class="done" href="/done?id=<%=order.getId()%>">remove</a>
	</div>
	</div>
<%
}
%>	
<br/>
<br/>
<br/>
<br/>
<br/>
<br/>
<br/>
<br/><br/>
<br/><br/>
<br/><br/><br/>
<br/><br/>
    <div class="smallfont">
    <a href="/Admin.jsp"><h1>shelly photo 2011</h1></a>
    </div>
    
</body>
</html>

