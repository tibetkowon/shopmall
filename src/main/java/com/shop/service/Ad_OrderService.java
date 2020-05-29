package com.shop.service;

import java.util.List;
import java.util.Map;

import com.shop.domain.OrderListVO;
import com.shop.domain.OrderVO;
import com.shop.util.OrderCriteria;

public interface Ad_OrderService {
	
	public List<OrderListVO> orderList(OrderCriteria cri)throws Exception;
	
	public int orderCount(OrderCriteria cri)throws Exception;
	
	public void update_status(OrderVO vo)throws Exception;
	
	public void check_update(List<Integer> codes,char status)throws Exception;
	
	public Map<String,Object> getOrder(int order_code)throws Exception;

}
