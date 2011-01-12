package info.berryworks.photoorder;

import java.io.IOException;
import java.util.List;

import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.google.appengine.api.users.User;
import com.google.appengine.api.users.UserService;
import com.google.appengine.api.users.UserServiceFactory;

import info.berryworks.photoorder.dao.Dao;
import info.berryworks.photoorder.model.Order;

@SuppressWarnings("serial")
public class ServletClearOrders extends HttpServlet {
	
	public void doGet(HttpServletRequest req, HttpServletResponse resp)
	throws IOException {
	User user = (User) req.getAttribute("user");
		if (user == null) {
			UserService userService = UserServiceFactory.getUserService();
			user = userService.getCurrentUser();
		}
		List<Order> orders = Dao.INSTANCE.getOrders(user.getEmail());		
		for ( Order o : orders) {
			Dao.INSTANCE.removeOrder(o.getId());
		}
		
		resp.sendRedirect("/OrderApplication.jsp");
	}


}
