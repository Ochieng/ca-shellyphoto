package info.berryworks.photoorder;

import java.io.IOException;

import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.google.appengine.api.users.User;
import com.google.appengine.api.users.UserService;
import com.google.appengine.api.users.UserServiceFactory;

import info.berryworks.photoorder.dao.Dao;


public class ServletRemovePOPhoto extends HttpServlet {
	private static final long serialVersionUID = 1L;

	public void doGet(HttpServletRequest req, HttpServletResponse resp)
	throws IOException {
		UserService userService = UserServiceFactory.getUserService();
		User user = userService.getCurrentUser();

		boolean lock = true;

		if (user == null) {
			resp.sendRedirect("/index.html");
			return;
		}

		if ( 0 == user.getEmail().compareTo("dirtslayer@gmail.com") ) lock = false;
		if ( 0 == user.getEmail().compareTo("spriestphoto@gmail.com") ) lock = false;

		if (lock) {
			resp.sendRedirect("/index.html");
			return;
		}
		String id = req.getParameter("id");
		Dao.INSTANCE.removePOPhoto(Long.parseLong(id));
		resp.sendRedirect("/POPhotoApplication.jsp");
	}
}
