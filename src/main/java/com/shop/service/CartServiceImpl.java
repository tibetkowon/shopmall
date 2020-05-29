package com.shop.service;

import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.shop.domain.CartListVO;
import com.shop.domain.CartVO;
import com.shop.persistence.CartDAO;

@Service
public class CartServiceImpl implements CartService {
	
	@Autowired
	private CartDAO dao;

	@Override
	public void addCart(CartVO vo) throws Exception {
		// TODO Auto-generated method stub
		dao.addCart(vo);
	}

	@Override
	public List<CartListVO> cartList(String user_id) throws Exception {
		// TODO Auto-generated method stub
		return dao.cartList(user_id);
	}

	@Override
	public void countUpdate(CartVO vo) throws Exception {
		// TODO Auto-generated method stub
		dao.countUpdate(vo);
	}

	@Override
	public void delete(int cart_code) throws Exception {
		// TODO Auto-generated method stub
		dao.delete(cart_code);
	}

	@Override
	public void deleteAll(String user_id) throws Exception {
		// TODO Auto-generated method stub
		dao.deleteAll(user_id);
	}

	@Override
	public List<CartListVO> checkList(List<Integer> cart_code) throws Exception {
		// TODO Auto-generated method stub
		List<CartListVO> list = new ArrayList<CartListVO>();
		
		for(int code : cart_code) {
			list.add(dao.checkList(code));	
		}
		return list;
	}
}
