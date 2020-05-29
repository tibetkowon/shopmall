package com.shop.persistence;

import java.util.List;
import java.util.Map;

import com.shop.domain.UserListVO;
import com.shop.domain.UserVO;
import com.shop.util.Criteria;

public interface Ad_UserDAO {

	public List<UserListVO> userList(Criteria cri)throws Exception;
	
	public UserVO userdetail(String user_id)throws Exception;
	
	public List<UserVO> getEmail(Map<String,List<String>> map)throws Exception;
	
	public List<UserVO> allEmail()throws Exception;
	
	public void userDelete(String id)throws Exception;
	
	public void checkDelete(Map<String,List<String>> map) throws Exception;
	
	public int countUser()throws Exception;
}
