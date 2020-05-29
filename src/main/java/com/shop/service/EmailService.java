package com.shop.service;

import java.util.List;

import com.shop.domain.MailVO;
import com.shop.domain.UserVO;

public interface EmailService {

	public String mailAuth(String email)throws Exception;
	
	public void find_id(String email,List<String> ids)throws Exception;
	
	public void find_pw(String email,String pw)throws Exception;

	void sendMails(MailVO vo, List<UserVO> mails) throws Exception;
}
