package com.shop.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.shop.domain.UserListVO;
import com.shop.domain.UserVO;
import com.shop.persistence.Ad_UserDAO;
import com.shop.util.Criteria;

@Service
public class Ad_UserServiceImpl implements Ad_UserService {

	@Autowired
	private Ad_UserDAO dao;

	@Override
	public List<UserListVO> userList(Criteria cri) throws Exception {
		// TODO Auto-generated method stub
		return dao.userList(cri);
	}

	@Override
	public UserVO userdetail(String user_id) throws Exception {
		// TODO Auto-generated method stub
		return dao.userdetail(user_id);
	}

	@Override
	public List<UserVO> getEmail(List<String> ids) throws Exception {
		// TODO Auto-generated method stub
		Map<String,List<String>> map = new HashMap<String,List<String>>();
		
		map.put("ids", ids);
		return dao.getEmail(map);
	}

	@Override
	public List<UserVO> allEmail() throws Exception {
		// TODO Auto-generated method stub
		return dao.allEmail();
	}

	@Override
	public void userDelete(String id) throws Exception {
		// TODO Auto-generated method stub
		dao.userDelete(id);
	}
	@Override
	public void checkDelete(List<String> ids) throws Exception {
		// TODO Auto-generated method stub
		Map<String,List<String>> map = new HashMap<String,List<String>>();
		map.put("ids",ids);
		dao.checkDelete(map);
	}

	@Override
	public int countUser() throws Exception {
		// TODO Auto-generated method stub
		return dao.countUser();
	}
}
