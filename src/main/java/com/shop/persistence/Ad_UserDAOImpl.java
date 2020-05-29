package com.shop.persistence;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.shop.domain.UserListVO;
import com.shop.domain.UserVO;
import com.shop.util.Criteria;

@Repository
public class Ad_UserDAOImpl implements Ad_UserDAO {

	@Autowired
	private SqlSession session;
	
	private static final String namespace = "com.shop.mapper/Ad_UserMapper";

	@Override
	public List<UserListVO> userList(Criteria cri) throws Exception {
		// TODO Auto-generated method stub
		System.out.println(cri.toString());
		return session.selectList(namespace + ".userList", cri);
	}

	@Override
	public UserVO userdetail(String user_id) throws Exception {
		// TODO Auto-generated method stub
		return session.selectOne(namespace + ".userdetail", user_id);
	}

	@Override
	public List<UserVO> getEmail(Map<String,List<String>> map) throws Exception {
		// TODO Auto-generated method stub
		return session.selectList(namespace + ".getEmail", map);
	}

	@Override
	public List<UserVO> allEmail() throws Exception {
		// TODO Auto-generated method stub
		return session.selectList(namespace + ".allEmail");
	}

	@Override
	public void userDelete(String id) throws Exception {
		// TODO Auto-generated method stub
		session.delete(namespace + ".userDelete", id);
	}
	@Override
	public void checkDelete(Map<String,List<String>> map) throws Exception {
		// TODO Auto-generated method stub
		session.delete(namespace + ".checkDelete", map);
	}

	@Override
	public int countUser() throws Exception {
		// TODO Auto-generated method stub
		return session.selectOne(namespace + ".countUser");
	}
}
