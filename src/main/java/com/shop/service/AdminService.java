package com.shop.service;

import com.shop.domain.AdminVO;
import com.shop.domain.LoginDTO;

public interface AdminService {

	public AdminVO login(LoginDTO dto)throws Exception;
	
	public int pw_modify(String now_pw, String change_pw, String user_id)throws Exception;
	
	public int countQnA()throws Exception;
	
	public int countFAQ()throws Exception;
	
	public int countOrder()throws Exception;
	
}
