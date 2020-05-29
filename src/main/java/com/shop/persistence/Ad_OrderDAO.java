package com.shop.persistence;

import java.util.List;
import java.util.Map;

import com.shop.domain.OrderDTO;
import com.shop.domain.OrderListVO;
import com.shop.domain.OrderVO;
import com.shop.util.OrderCriteria;

public interface Ad_OrderDAO {
	
	public List<OrderListVO> orderList(OrderCriteria cri)throws Exception;
	
	public int orderCount(OrderCriteria cri)throws Exception;
	
	public void update_status(OrderVO vo)throws Exception;
	
	public void check_update(Map<String,Object> map)throws Exception;
	
	public OrderVO getOrder (int order_code)throws Exception;
	
	public List<OrderDTO> getOrder_detail(int order_code)throws Exception;

}
