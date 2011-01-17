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
		UserService userService = UserServiceFactory.getUserService();
		User user = userService.getCurrentUser();

		boolean lock = true;

		if (user == null) {
			resp.sendRedirect("/");
			return;
		}

		if ( 0 == user.getEmail().compareTo("dirtslayer@gmail.com") ) lock = false;
		if ( 0 == user.getEmail().compareTo("spriestphoto@gmail.com") ) lock = false;

		if (lock) {
			resp.sendRedirect("/");
			return;
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
