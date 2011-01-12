package info.berryworks.photoorder;

import java.io.IOException;
import java.util.List;

import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;



import info.berryworks.photoorder.dao.Dao;

// todo put user check on admin servlets, so that i can post the code and not have
// to worry about people guessing urls and fucking up our data
@SuppressWarnings("serial")
public class ServletCreatePOPhoto extends HttpServlet {
	
	public void doGet(HttpServletRequest req, HttpServletResponse resp)
	throws IOException {
		String photourl = checkNull(req.getParameter("photourl"));
		String notes = checkNull(req.getParameter("notes"));		
		String albumid = checkNull(req.getParameter("albumid"));	
		Dao.INSTANCE.addPOPhoto(photourl, notes, albumid);
		resp.sendRedirect("/POPhotoApplication.jsp");
	}
	private String checkNull(String s) {
		if (s == null) {
			return "";
		}
		return s;
	}

}
