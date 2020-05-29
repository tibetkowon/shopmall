package com.shop.service;

import java.util.List;
import java.util.Map;

import com.shop.domain.OrderListVO;
import com.shop.domain.OrderVO;
import com.shop.domain.Order_detailVO;
import com.shop.util.Criteria;

public interface OrderService {

	public void insertOrder(List<Integer> cart_code, OrderVO vo)throws Exception;
	
	public List<OrderListVO> orderList(String user_id,Criteria cri)throws Exception;
	
	public void quickOrder(OrderVO vo,Order_detailVO d_vo)throws Exception;
	
	public Map<String,Object> detail(int order_code , String user_id)throws Exception;
	
	public void delete (int order_code)throws Exception;
	
	public int orderListCount(String user_id)throws Exception;
	
}
