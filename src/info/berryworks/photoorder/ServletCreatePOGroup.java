package info.berryworks.photoorder;

import java.io.IOException;

import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
/*
import com.google.appengine.api.users.User;
import com.google.appengine.api.users.UserService;
import com.google.appengine.api.users.UserServiceFactory;
*/
import info.berryworks.photoorder.dao.Dao;


@SuppressWarnings("serial")
public class ServletCreatePOGroup extends HttpServlet {
	public void doPost(HttpServletRequest req, HttpServletResponse resp)
	throws IOException {
		System.out.println("Creating new group ");
		
		String name = checkNull(req.getParameter("name"));
		String notes = checkNull(req.getParameter("notes"));
		
		Dao.INSTANCE.addPOGroup(name, notes);
		resp.sendRedirect("/POGroupApplication.jsp");
	}

	private String checkNull(String s) {
		if (s == null) {
			return "";
		}
		return s;
	}
}
