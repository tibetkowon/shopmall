package com.shop.util;

import java.util.Enumeration;
import java.util.Hashtable;

import javax.servlet.http.HttpSession;
import javax.servlet.http.HttpSessionBindingEvent;
import javax.servlet.http.HttpSessionBindingListener;

public class SessionListener implements HttpSessionBindingListener {

	private static SessionListener sessionListener = null;

	private static Hashtable<HttpSession, String> loginUsers = new Hashtable<HttpSession, String>();

	public static synchronized SessionListener getInstance() {
		if (sessionListener == null) {
			sessionListener = new SessionListener();
		}
		return sessionListener;
	}

	@Override
	public void valueBound(HttpSessionBindingEvent event) {
		// TODO Auto-generated method stub
		loginUsers.put(event.getSession(), event.getName());
	}

	@Override
	public void valueUnbound(HttpSessionBindingEvent event) {
		// TODO Auto-generated method stub
		loginUsers.remove(event.getSession());

	}

	public boolean isUsing(String userId) {
		return loginUsers.containsValue(userId);
	}

	public void removeSession(String userId) {
		Enumeration<HttpSession> e = loginUsers.keys();
		HttpSession session = null;
		while (e.hasMoreElements()) {
			session = e.nextElement();
			if (loginUsers.get(session).equals(userId)) {
				session.invalidate();
			}
		}
	}

	public void setSession(HttpSession session, String userId) {
		session.setAttribute(userId, this);
	}

	public String getUserID(HttpSession session) {
		return (String) loginUsers.get(session);
	}

	// 현재 접속자수 확인
	public int getUserCount() {
		return loginUsers.size();
	}
}
