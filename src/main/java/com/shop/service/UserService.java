package com.shop.service;

import java.util.List;

import com.shop.domain.LoginDTO;
import com.shop.domain.UserVO;

public interface UserService {

	public void register(UserVO vo)throws Exception;
	
	public UserVO login(LoginDTO dto)throws Exception;
	
	public int check_id(String user_id)throws Exception;
	
	public UserVO readUser(String user_id)throws Exception;
	
	public void modify(UserVO vo)throws Exception;

	public int pw_modify(String now_pw,String change_pw,String user_id)throws Exception;
	
	public int delete(LoginDTO dto)throws Exception;
	
	public List<String> find_id(UserVO vo)throws Exception;
	
	public String find_pw(UserVO vo)throws Exception;
}
