package info.berryworks.photoorder;

import java.io.IOException;

import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.google.appengine.api.users.User;
import com.google.appengine.api.users.UserService;
import com.google.appengine.api.users.UserServiceFactory;

import info.berryworks.photoorder.dao.Dao;
//String customerid,  String name, String email,String telephone,
//String mobile,	String address,String notes, Long groupid 

@SuppressWarnings("serial")
public class ServletCreatePOUser extends HttpServlet {
	public void doPost(HttpServletRequest req, HttpServletResponse resp)
	throws IOException {
		User user = (User) req.getAttribute("user");
		if (user == null) {
			UserService userService = UserServiceFactory.getUserService();
			user = userService.getCurrentUser();
		}

		
		String name = checkNull(req.getParameter("name"));
		String email = checkNull(req.getParameter("email"));
		String groupid  = checkNull( req.getParameter("groupid"));
		String mobile = checkNull(req.getParameter("mobile"));
		String notes = checkNull(req.getParameter("notes"));
		String telephone = checkNull(req.getParameter("telephone"));
		String address = checkNull(req.getParameter("address"));
		Dao.INSTANCE.addPOUser( name, email, telephone, mobile, address, notes, groupid);
		
		resp.sendRedirect("/POUserApplication.jsp");
	}

	private String checkNull(String s) {
		if (s == null) {
			return "";
		}
		return s;
	}
}
