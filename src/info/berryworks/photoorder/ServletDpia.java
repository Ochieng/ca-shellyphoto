package info.berryworks.photoorder;

import java.io.IOException;

import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.google.appengine.api.users.User;
import com.google.appengine.api.users.UserService;
import com.google.appengine.api.users.UserServiceFactory;

import info.berryworks.photoorder.dao.Dao;
import java.util.List;
import info.berryworks.photoorder.model.POPhoto;

public class ServletDpia extends HttpServlet {
	private static final long serialVersionUID = 1L;

	public void doPost(HttpServletRequest req, HttpServletResponse resp)
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
		
		
		
		String albumid = req.getParameter("albumid");
		List<POPhoto> photos = Dao.INSTANCE.getPOPhotos(albumid);
		for ( POPhoto photo : photos) Dao.INSTANCE.removePOPhoto(photo.getId());
		resp.sendRedirect("/POPhotoApplication.jsp");
	}
}
