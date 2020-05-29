package com.shop.persistence;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.shop.domain.LoginDTO;
import com.shop.domain.UserVO;

@Repository
public class UserDAOImpl implements UserDAO {

	@Autowired
	SqlSession session;
	
	private final static String namespace = "com.shop.mapper/UserMapper";

	@Override
	public void register(UserVO vo) throws Exception {
		// TODO Auto-generated method stub
		session.insert(namespace + ".register", vo);
	}

	@Override
	public UserVO login(LoginDTO dto) throws Exception {
		// TODO Auto-generated method stub
		return session.selectOne(namespace + ".login", dto);
	}

	@Override
	public int check_id(String user_id) throws Exception {
		// TODO Auto-generated method stub
		return session.selectOne(namespace + ".check_id", user_id);
	}

	@Override
	public UserVO readUser(String user_id) throws Exception {
		// TODO Auto-generated method stub
		return session.selectOne(namespace + ".login", user_id);
	}

	@Override
	public void modify(UserVO vo) throws Exception {
		// TODO Auto-generated method stub
		session.update(namespace + ".modify", vo);
	}

	@Override
	public void pw_modify(Map<String,String> map) throws Exception {
		// TODO Auto-generated method stub
		session.update(namespace + ".pw_modify", map);
	}

	@Override
	public void delete(String id) throws Exception {
		// TODO Auto-generated method stub
		session.delete(namespace + ".delete", id);
	}

	@Override
	public List<String> find_id(UserVO vo) throws Exception {
		// TODO Auto-generated method stub
		return session.selectList(namespace + ".find_id", vo);
	}
	
}
