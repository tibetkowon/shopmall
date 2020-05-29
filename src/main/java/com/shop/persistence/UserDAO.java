package com.shop.persistence;

import java.util.List;
import java.util.Map;

import com.shop.domain.LoginDTO;
import com.shop.domain.UserVO;

public interface UserDAO {

	public void register(UserVO vo)throws Exception;
	
	public UserVO login(LoginDTO dto)throws Exception;
	
	public int check_id(String user_id)throws Exception;
	
	public UserVO readUser(String user_id)throws Exception;
	
	public void modify(UserVO vo)throws Exception;
	
	public void pw_modify(Map<String, String> map)throws Exception;
	
	public void delete(String id)throws Exception;
	
	public List<String> find_id(UserVO vo)throws Exception;
}
