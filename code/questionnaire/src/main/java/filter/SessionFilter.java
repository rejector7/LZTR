package filter;

import java.io.IOException;
import java.util.List;

import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.FilterConfig;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpServletResponseWrapper;

import model.User;

public class SessionFilter implements Filter{
	
	public FilterConfig config;
	
	public void destroy(){
		this.config = null;
	}
	
	public static boolean isContains(String container, String[] regx){
		boolean result = false;
		
		for(int i = 0; i < regx.length; i++){
			if(container.indexOf(regx[i]) != -1){
				return true;
			}
		}
		return result;
	}
	
	public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain) throws IOException,
		ServletException{
		HttpServletRequest hrequest = (HttpServletRequest)request;
		HttpServletResponseWrapper wrapper = new HttpServletResponseWrapper((HttpServletResponse) response);
		
		String loginStrings = config.getInitParameter("loginStrings");
		String diabletestfilter = config.getInitParameter("diabletestfilter");
		String adminStrings = config.getInitParameter("adminStrings");
		String redirectPath = hrequest.getContextPath() + config.getInitParameter("redirectPath");
		if(diabletestfilter.toUpperCase().equals("Y")){
			chain.doFilter(request,  response);
			return;
		}
		String[] loginList = loginStrings.split(";");
		String[] adminList = adminStrings.split(";");
		if(this.isContains(hrequest.getRequestURI(), loginList)){
			chain.doFilter(request, response);
			return;
		}
		User user = (User)hrequest.getSession().getAttribute("user");
		
		if(user == null){
			wrapper.sendRedirect(redirectPath);
			return;
		}else if(user.getRole().equals("user") && this.isContains(hrequest.getRequestURI(), adminList)){
			wrapper.sendRedirect("index.jsp");
			return;
		}
		else{
			chain.doFilter(request,  response);
			return;
		}
	}
	
	public void init(FilterConfig filterConfig) throws ServletException{
		config = filterConfig;
	}
}



















