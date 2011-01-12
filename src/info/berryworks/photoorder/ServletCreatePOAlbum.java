package info.berryworks.photoorder;

import java.io.IOException;

import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import info.berryworks.photoorder.dao.Dao;

@SuppressWarnings("serial")
public class ServletCreatePOAlbum extends HttpServlet {
	public void doPost(HttpServletRequest req, HttpServletResponse resp)
	throws IOException {
		System.out.println("Creating new album ");
		
		String groupid =checkNull(req.getParameter("groupid"));
		String name = checkNull(req.getParameter("name"));
		String notes = checkNull(req.getParameter("notes"));
		
		Dao.INSTANCE.addPOAlbum(name, notes, groupid);
		resp.sendRedirect("/POAlbumApplication.jsp");
	}

	private String checkNull(String s) {
		if (s == null) {
			return "";
		}
		return s;
	}
}
