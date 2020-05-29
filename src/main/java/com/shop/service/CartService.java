package com.shop.service;

import java.util.List;

import com.shop.domain.CartListVO;
import com.shop.domain.CartVO;

public interface CartService {
	
	public void addCart(CartVO vo)throws Exception;

	public List<CartListVO> cartList(String user_id)throws Exception;
	
	public void countUpdate(CartVO vo)throws Exception;
	
	public void delete(int cart_code)throws Exception;
	
	public void deleteAll(String user_id)throws Exception;
	
	public List<CartListVO> checkList(List<Integer> cart_code)throws Exception;
}
