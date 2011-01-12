<%@ page language="java" contentType="text/xml; charset=UTF-8" pageEncoding="UTF-8"%><?xml version="1.0" ?>
<?xml-stylesheet type="text/xsl" href="photoorder.xsl"?>
<%@ page import="info.berryworks.photoorder.dao.Dao" %>
<%@ page import="com.google.appengine.api.users.User" %>
<%@ page import="com.google.appengine.api.users.UserService" %>
<%@ page import="com.google.appengine.api.users.UserServiceFactory" %>

<%
UserService userService = UserServiceFactory.getUserService();
User user = userService.getCurrentUser();

boolean lock = true;

if (user == null) {
	
	return;
}

if ( 0 == user.getEmail().compareTo("dirtslayer@gmail.com") ) lock = false;
if ( 0 == user.getEmail().compareTo("spriestphoto@gmail.com") ) lock = false;

if (lock) {

	return;
}

%><%=Dao.INSTANCE.xml() %>
