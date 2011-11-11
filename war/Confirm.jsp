<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%@ page import="java.util.List"%>
<%@ page import="info.berryworks.photoorder.model.POOrder"%>
<%@ page import="info.berryworks.photoorder.model.POUser"%>
<%@ page import="com.google.appengine.api.users.UserService"%>
<%@ page import="com.google.appengine.api.users.UserServiceFactory"%>
<%@ page import="com.google.appengine.api.users.User"%>
<%@ page import="info.berryworks.photoorder.dao.Dao"%>
<%@ page import="info.berryworks.photoorder.dao.EMFService"%>
<%@ page import="java.util.ArrayList"%>
<%@page import="java.util.GregorianCalendar"%>
<%@page import="javax.persistence.EntityManager"%>
<%@page import="javax.persistence.Query"%>
<%@page import="javax.mail.Session"%>

<!DOCTYPE html>
<html>
<head>
<title>Confirm Orders</title>
<link rel="stylesheet" type="text/css" href="css/main.css" />
<meta charset="utf-8">
</head>
<body>
	<%
List<POOrder> orders = null;
ArrayList<POOrder> conforders = null;
POUser pouser = null;
UserService userService = UserServiceFactory.getUserService();
User user = userService.getCurrentUser();
EntityManager em = null;
String ftotal = null;

if (user == null) {
%>
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
} catch (Exception e) {;}

if (pouser == null) {
%>
email admistrator to be granted access
</body>
</html>
<%
	return;
	}
%>
<%
// get orders, display total
try {
	//orders = Dao.INSTANCE.getOrders(user.getEmail());
	em = EMFService.get().createEntityManager();
	Query q = em
			.createQuery("select t from POOrder t where t.customeremail = :customeremail");
	q.setParameter("customeremail", pouser.getEmail());
	orders = q.getResultList();
	
	
	
	
	
	Double total = 0.0;
	for (POOrder o : orders) {
		if (o.getStatusInt() == 1)
			total += Double.parseDouble(o.getPrice());
	}
	ftotal = new java.text.DecimalFormat("0.00").format(total);
%>
<h1>
	Total $
	<%=ftotal%></h1>
<%
} catch(Exception e) {;}
%>
<br />
<br />
<h2>pay with paypal</h2>
<form name="_xclick" action="https://www.paypal.com/cgi-bin/webscr"
	method="post">
	<input type="hidden" name="cmd" value="_xclick"> <input
		type="hidden" name="business" value="spriest@mcsnet.ca"> <input
		type="hidden" name="currency_code" value="CAD"> <input
		type="hidden" name="amount" value="<%=ftotal %>"> <input
		type="hidden" name="item_name" value="shelly photo payment"> <input
		type="image" src="http://www.paypal.com/en_US/i/btn/btn_buynow_LG.gif"
		border="0" name="submit"
		alt="Make payments with PayPal - it's fast, free and secure!">
</form>
</br>
</br>
<%
try {
//move orders to confirm status
// holding conforders aside and creating duplicates if i 
// could figure out how to get the database objects entity
// manager so that i coudl persist it, but the entity manager
// for that object is not at hand
POOrder order = null;
 conforders = new ArrayList<POOrder>();
java.util.ListIterator<POOrder> iter = orders.listIterator(orders.size());
while (iter.hasPrevious()) {
	order = (POOrder) iter.previous();
	if (order.getStatusInt() == 1) {
		conforders.add(order);
	}
}
} catch(Exception e) {;}
%>


<% 

// get time
java.util.TimeZone edmontontz = java.util.TimeZone.getTimeZone("Canada/Mountain");  
java.util.Calendar calendar = new GregorianCalendar(edmontontz);

java.util.Date n = new java.util.Date();
java.text.SimpleDateFormat df = new java.text.SimpleDateFormat("MMM dd, hh:mm:ss");
df.setTimeZone(edmontontz);
String confdate = df.format(n); 
%>


<br />
<br />

An email has been sent to you to confirm your order.
<br />
<%=confdate %>

<br />
<br />

<a href="/">start new order ...</a>

<%
// move orders to confirm status
POOrder ox = null;

for ( POOrder o : conforders)  {
		
		o.setConfirmeddate(confdate);
	
		em = EMFService.get().createEntityManager();
		ox = em.find(POOrder.class,o.getId());
		
		ox.setConfirmeddate(confdate);
		
		em.close();	
}


javax.mail.Address[] addresses = new javax.mail.Address[4];
	addresses[3] = new javax.mail.internet.InternetAddress(
			"spriestphoto@gmail.com",
			"spriestphoto@gmail.com shelly");
	addresses[1] = new javax.mail.internet.InternetAddress(
			"dirtslayer@gmail.com",
			"dirtslayer@gmail.com dirtslayer");
	addresses[2] = new javax.mail.internet.InternetAddress(
			"spriest@mcsnet.ca",
			"spriest@mcsnet.ca shelly");
	addresses[0] = new javax.mail.internet.InternetAddress(user.getEmail(), user.getNickname());
%>

<% 
String htmlmail = "Shelly Photo Order Confirmation Receipt";
htmlmail += "\n";
htmlmail += "\n";
htmlmail += "Pay online or contact Shelly to arrange for payment";
htmlmail += "\n";
htmlmail += "\n";
htmlmail += "Keep this email as a record of the order";
htmlmail += "\n";
htmlmail += "\n";
htmlmail += "Make online payments at https://ca-shellyphoto.appspot.com";
htmlmail += "\n";
htmlmail += "\n";
htmlmail += "Thank You!";
htmlmail += "\n";
htmlmail += "\n";
htmlmail += "the total for this order is: $" + ftotal;
htmlmail += "\n";
htmlmail += "\n";
htmlmail += "\n";
htmlmail += "\n";


for ( POOrder o : conforders)  {
	htmlmail += "\n" + o.getPhotoid();
	htmlmail += "\n" + o.getAlbumid();
	htmlmail += "\n" + o.getOrderdate();
	htmlmail += "\n" + o.getQuantity();
	htmlmail += "\n" + o.getPrice();
	htmlmail += "\n" + o.getType();	
	htmlmail += "\n";
	htmlmail += "\n" ;
	htmlmail += "\n" ;
	
}


htmlmail += "\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n<xml><!-- ---------------- debug --------------------  -->\n\n";

for ( POOrder o : conforders)  {
	htmlmail += "\n\n" + o.toString();
}
htmlmail +="</xml>";%>
<% 
java.util.Properties props = new java.util.Properties();
javax.mail.Session msession = javax.mail.Session.getDefaultInstance(props, null);
	javax.mail.Message msg = new javax.mail.internet.MimeMessage(msession);
	msg.setFrom(new javax.mail.internet.InternetAddress("dirtslayer@gmail.com","dirtslayer@gmail.com dirtslayer"));
	msg.setSubject("$" + ftotal + " Shelly Photo Order confirmation");
	msg.setText(htmlmail);
	msg.setDescription("html/txt");
	
	msg.addRecipient(javax.mail.Message.RecipientType.TO,addresses[0]);
	msg.addRecipient(javax.mail.Message.RecipientType.TO,addresses[1]);
	msg.addRecipient(javax.mail.Message.RecipientType.TO,addresses[2]);
	msg.addRecipient(javax.mail.Message.RecipientType.TO,addresses[3]);

	javax.mail.Transport.send(msg);

	
	
%>


</head>
</body>
