package info.berryworks.photoorder;

import java.io.IOException;
import java.util.List;

import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import info.berryworks.photoorder.dao.Dao;

@SuppressWarnings("serial")
public class ServletAddurl extends HttpServlet {
	public void doPost(HttpServletRequest req, HttpServletResponse resp)
	throws IOException {
		String surl = checkNull(req.getParameter("url"));
		String albumid = checkNull(req.getParameter("albumid"));	
		String width = checkNull(req.getParameter("width"));	
	
		
		List<String> imgs =  info.berryworks.photoorder.dao.Net.getImages(surl);
		
		if ( width.compareTo("") == 0 ) {
			for (String img : imgs) Dao.INSTANCE.addPOPhoto(img, "", albumid);
			resp.sendRedirect("/POPhotoApplication.jsp");
			return;
		}
		
		
		int i,j;
		String f,g,h;
		
		for ( String img : imgs ) {
			i = img.lastIndexOf('/');
			j = img.lastIndexOf('/', i-1);
			f = img.substring(0,j+1);
			g = img.substring(i);
			Dao.INSTANCE.addPOPhoto(f + width + g,"",albumid);
		}
		
		resp.sendRedirect("/POPhotoApplication.jsp");
	}

	private String checkNull(String s) {
		if (s == null) {
			return "";
		}
		return s;
	}
}