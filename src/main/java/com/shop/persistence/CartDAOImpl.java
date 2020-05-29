package com.shop.persistence;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.shop.domain.CartListVO;
import com.shop.domain.CartVO;

@Repository
public class CartDAOImpl implements CartDAO {
	
	@Autowired
	private SqlSession session;
	
	private static final String namespace = "com.shop.mapper/CartMapper";

	@Override
	public void addCart(CartVO vo) throws Exception {
		// TODO Auto-generated method stub
		session.insert(namespace + ".addCart", vo);
	}

	@Override
	public List<CartListVO> cartList(String user_id) throws Exception {
		// TODO Auto-generated method stub
		return session.selectList(namespace + ".cartList", user_id);
	}

	@Override
	public void countUpdate(CartVO vo) throws Exception {
		// TODO Auto-generated method stub
		session.update(namespace + ".countUpdate", vo);
	}

	@Override
	public void delete(int cart_code) throws Exception {
		// TODO Auto-generated method stub
		session.delete(namespace + ".delete", cart_code);
	}

	@Override
	public void deleteAll(String user_id) throws Exception {
		// TODO Auto-generated method stub
		session.delete(namespace + ".deleteAll", user_id);
	}

	@Override
	public CartListVO checkList(int cart_code) throws Exception {
		// TODO Auto-generated method stub
		return session.selectOne(namespace + ".checkCartList", cart_code);
	}
	
}
