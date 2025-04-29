package com.vroomnzoom.interceptor;

import org.springframework.stereotype.Component;
import org.springframework.web.servlet.HandlerInterceptor;

import com.vroomnzoom.dao.UserDAO;
import com.vroomnzoom.model.User;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@Component
public class LoginInterceptor implements HandlerInterceptor {
	
	private final UserDAO userDAO;
	
	public LoginInterceptor(UserDAO userDAO) {
		this.userDAO = userDAO;
	}

	@Override
	public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler) throws Exception {
		HttpSession session = request.getSession();
		User sessionUser = (User) session.getAttribute("user");
		String path = request.getRequestURI().substring(request.getContextPath().length() + 1);
		
		if(path.startsWith("admin/")) {
			if(sessionUser == null) {
				response.sendError(401);
				return false;
			} else if(!sessionUser.getRole().equals("admin")) {
				response.sendError(403);
				return false;
			}
			return true;
		}
		
		if (sessionUser != null) {
			User currentUser = userDAO.getUserById(sessionUser.getUserId());
			session.setAttribute("user", currentUser);
			
			if(currentUser == null || !currentUser.isActive()) {
				session.removeAttribute("user");
				response.sendRedirect(request.getContextPath() + "/logout");
				return false;
			}

			if(path.equals("sign-in") || path.equals("sign-up")) {
				String source = request.getParameter("source");
		        response.sendRedirect(request.getContextPath() + "/" + (source != null ? source : ""));
		        return false;
			}
	    }
		
        if (sessionUser == null && (path.startsWith("bookings/") || path.equals("my-profile"))) {
            response.sendRedirect(request.getContextPath() + "/sign-in?source=" + path);
            return false;
        }
        return true; 
	}
}
