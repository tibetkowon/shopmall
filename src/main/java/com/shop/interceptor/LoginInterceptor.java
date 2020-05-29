package com.shop.interceptor;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;

public class LoginInterceptor extends HandlerInterceptorAdapter {
	private static final Logger logger = LoggerFactory.getLogger(LoginInterceptor.class);

	@Override
	public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler)
			throws Exception {
		HttpSession session = request.getSession();
		String dest = (String)session.getAttribute("dest");
		if(dest == null) {		
		saveDest(request);
		}
		return true;
	}

	private void saveDest(HttpServletRequest req) {
		String uri = req.getHeader("Referer");
		System.out.println(uri);

		String query = req.getQueryString();

		if (query == null || query.equals("null")) {
			query = "";
		} else {
			query = "?" + query;
		}

		if (req.getMethod().equals("GET")) {
			logger.info("dest: " + (uri + query)); // 원래 요청한 uri 출력
			// 세션형태로 원래 요청한 uri를 dest 키로 저장
			req.getSession().setAttribute("dest", uri + query);
		}
	}

}
