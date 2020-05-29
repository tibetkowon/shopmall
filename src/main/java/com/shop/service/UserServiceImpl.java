package com.shop.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.inject.Inject;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Service;

import com.shop.domain.LoginDTO;
import com.shop.domain.UserVO;
import com.shop.persistence.UserDAO;

@Service
public class UserServiceImpl implements UserService {

	@Autowired
	UserDAO dao;

	@Inject
	private BCryptPasswordEncoder crptPassEnc;

	@Override
	public void register(UserVO vo) throws Exception {
		// TODO Auto-generated method stub
		vo.setUser_pw(crptPassEnc.encode(vo.getUser_pw()));

		dao.register(vo);
	}

	@Override
	public UserVO login(LoginDTO dto) throws Exception {
		// TODO Auto-generated method stub
		UserVO vo = dao.login(dto);
		if (vo != null) {

			if (crptPassEnc.matches(dto.getPw(), vo.getUser_pw())) {
			} else {
				vo = null;
			}
		}
		return vo;
	}

	@Override
	public int check_id(String user_id) throws Exception {
		// TODO Auto-generated method stub
		return dao.check_id(user_id);
	}

	@Override
	public UserVO readUser(String user_id) throws Exception {
		// TODO Auto-generated method stub
		return dao.readUser(user_id);
	}

	@Override
	public void modify(UserVO vo) throws Exception {
		// TODO Auto-generated method stub
		dao.modify(vo);
	}

	@Override
	public int pw_modify(String now_pw,String change_pw,String user_id) throws Exception {
		// TODO Auto-generated method stub
		UserVO vo = dao.readUser(user_id);
		int change = 0;
		Map<String,String> map = new HashMap<String,String>();
		
		if (crptPassEnc.matches(now_pw, vo.getUser_pw())) {
			String re_pw = (crptPassEnc.encode(change_pw));
			map.put("user_id", user_id);
			map.put("change_pw", re_pw);
			dao.pw_modify(map);
			change = 1;
		} else {
			change = 0;
		}
		return change;
	}

	@Override
	public int delete(LoginDTO dto) throws Exception {
		// TODO Auto-generated method stub
		UserVO vo = dao.readUser(dto.getId());
		int delete = 0;
		if(crptPassEnc.matches(dto.getPw(), vo.getUser_pw())) {
			dao.delete(dto.getId());
			delete = 1;
		} else {
			delete = 0;
		}
		return delete;
	}

	@Override
	public List<String> find_id(UserVO vo) throws Exception {
		// TODO Auto-generated method stub
		return dao.find_id(vo);
	}

	@Override
	public String find_pw(UserVO vo) throws Exception {
		// TODO Auto-generated method stub
		double random = Math.random();
		String number = Integer.toString((int)(random * 1000000) +1);
		String pass = "";
		Map<String,String> map = new HashMap<String,String>();
		
		for(String user_id : dao.find_id(vo)) {
			if(user_id.equals(vo.getUser_id())) {
				pass = crptPassEnc.encode(number);
				map.put("change_pw", pass);
				map.put("user_id", user_id);
				dao.pw_modify(map);
				break;
			} else {
				number = "";
			}
		}
		return number;
	}

}
