package com.shop.persistence;

import com.shop.domain.AdminVO;
import com.shop.domain.LoginDTO;

public interface AdminDAO {
	//로그인
	public AdminVO login(LoginDTO dto)throws Exception;
	//접속시간 업데이트
	public void time_update(AdminVO vo)throws Exception;
	
	public void pw_modify(AdminVO vo)throws Exception;
	
	public AdminVO readAdmin(String admin_id)throws Exception;
	
	public int countQnA()throws Exception;
	
	public int countFAQ()throws Exception;
	
	public int countOrder()throws Exception;
}
