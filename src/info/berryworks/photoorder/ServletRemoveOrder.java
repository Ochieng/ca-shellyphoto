package info.berryworks.photoorder;

import java.io.IOException;

import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import info.berryworks.photoorder.dao.Dao;


public class ServletRemoveOrder extends HttpServlet {
	private static final long serialVersionUID = 1L;

	public void doGet(HttpServletRequest req, HttpServletResponse resp)
	throws IOException {
		String id = req.getParameter("id");
		Dao.INSTANCE.removeOrder(Long.parseLong(id));
		
		resp.sendRedirect("/OrderApplication.jsp");
	}
}
