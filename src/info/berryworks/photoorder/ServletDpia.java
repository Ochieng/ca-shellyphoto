package info.berryworks.photoorder;

import java.io.IOException;

import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import info.berryworks.photoorder.dao.Dao;
import java.util.List;
import info.berryworks.photoorder.model.POPhoto;

public class ServletDpia extends HttpServlet {
	private static final long serialVersionUID = 1L;

	public void doPost(HttpServletRequest req, HttpServletResponse resp)
	throws IOException {
		String albumid = req.getParameter("albumid");
		List<POPhoto> photos = Dao.INSTANCE.getPOPhotos(albumid);
		for ( POPhoto photo : photos) Dao.INSTANCE.removePOPhoto(photo.getId());
		resp.sendRedirect("/POPhotoApplication.jsp");
	}
}
