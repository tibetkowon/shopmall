package com.shop.service;

import javax.inject.Inject;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Service;

import com.shop.domain.AdminVO;
import com.shop.domain.LoginDTO;
import com.shop.persistence.AdminDAO;

@Service
public class AdminServiceImpl implements AdminService {

	@Autowired
	private AdminDAO dao;
	@Inject
	private BCryptPasswordEncoder crptPassEnc;
	
	@Override
	public AdminVO login(LoginDTO dto) throws Exception {
		// TODO Auto-generated method stub
		
		AdminVO vo = dao.login(dto);
		if(vo != null) {
			if(crptPassEnc.matches(dto.getPw(), vo.getAdmin_pw())) {
				
				dao.time_update(vo);
			} else {
				vo = null;
			}
			
		}
		
		return vo;
	}

	@Override
	public int pw_modify(String now_pw, String change_pw, String admin_id) throws Exception {
		// TODO Auto-generated method stub
		int num;
		AdminVO vo = dao.readAdmin(admin_id);
		
		if(crptPassEnc.matches(now_pw, vo.getAdmin_pw())) {
			vo.setAdmin_pw(crptPassEnc.encode(change_pw));
			
			dao.pw_modify(vo);
			num = 1;
		} else {
			num = 0;
		}
		
		return num;
	}

	@Override
	public int countQnA() throws Exception {
		// TODO Auto-generated method stub
		return dao.countQnA();
	}

	@Override
	public int countFAQ() throws Exception {
		// TODO Auto-generated method stub
		return dao.countFAQ();
	}

	@Override
	public int countOrder() throws Exception {
		// TODO Auto-generated method stub
		return dao.countOrder();
	}

}
