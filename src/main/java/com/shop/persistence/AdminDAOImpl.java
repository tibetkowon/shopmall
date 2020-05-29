package com.shop.persistence;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.shop.domain.AdminVO;
import com.shop.domain.LoginDTO;

@Repository
public class AdminDAOImpl implements AdminDAO {

	public final static String namespace = "com.shop.mapper/AdminMapper";
	
	@Autowired
	private SqlSession session;
	
	@Override
	public AdminVO login(LoginDTO dto) throws Exception {
		// TODO Auto-generated method stub
		return session.selectOne(namespace + ".login",dto);
	}

	@Override
	public void time_update(AdminVO vo) throws Exception {
		// TODO Auto-generated method stub
		session.update(namespace + ".time_update", vo);
	}

	@Override
	public void pw_modify(AdminVO vo) throws Exception {
		// TODO Auto-generated method stub
		session.update(namespace + ".pwModify", vo);
	}

	@Override
	public AdminVO readAdmin(String admin_id) throws Exception {
		// TODO Auto-generated method stub
		return session.selectOne(namespace + ".readAdmin", admin_id);
	}

	@Override
	public int countQnA() throws Exception {
		// TODO Auto-generated method stub
		return session.selectOne(namespace + ".countQnA");
	}

	@Override
	public int countFAQ() throws Exception {
		// TODO Auto-generated method stub
		return session.selectOne(namespace + ".countFAQ");
	}
	
	public int countOrder()throws Exception{
		return session.selectOne(namespace + ".countOrder");
		
	}

}
