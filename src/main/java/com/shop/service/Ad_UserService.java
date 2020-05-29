package com.shop.service;

import java.util.List;

import com.shop.domain.UserListVO;
import com.shop.domain.UserVO;
import com.shop.util.Criteria;

public interface Ad_UserService {

	public List<UserListVO> userList(Criteria cri)throws Exception;
	
	public UserVO userdetail(String user_id)throws Exception;
	
	public List<UserVO> getEmail(List<String> ids)throws Exception;
	
	public List<UserVO> allEmail()throws Exception;
	
	public void userDelete(String ids)throws Exception;
	
	public void checkDelete(List<String> ids)throws Exception;
	
	public int countUser()throws Exception;
}
