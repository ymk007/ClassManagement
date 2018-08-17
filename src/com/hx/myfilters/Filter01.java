package com.hx.myfilters;

import java.io.IOException;

import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.FilterConfig;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

public class Filter01 implements Filter{

	@Override
	public void destroy() {
		
	}

	@Override
	public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain)
			throws IOException, ServletException {
		System.out.println("正在进行doFilter过滤");
		HttpServletRequest Hrequest = (HttpServletRequest)request;
		HttpSession session  = Hrequest.getSession();
		if(session.getAttribute("user")==null) {
			HttpServletResponse hresponse = (HttpServletResponse)response;
			hresponse.sendRedirect(Hrequest.getContextPath()+"/login.html");
		}else {
			chain.doFilter(request, response);
		}
	}

	@Override
	public void init(FilterConfig filterConfig) throws ServletException {
		
	}

}
