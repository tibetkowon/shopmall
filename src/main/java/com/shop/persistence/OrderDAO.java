package com.shop.persistence;

import java.util.List;
import java.util.Map;

import com.shop.domain.OrderDTO;
import com.shop.domain.OrderListVO;
import com.shop.domain.OrderVO;
import com.shop.domain.Order_detailVO;
import com.shop.domain.ProductVO;

public interface OrderDAO {
	
	public void insertOrder(OrderVO vo)throws Exception;
	
	public void insertDetail(Map<String,Object> map)throws Exception;
	
	public List<OrderListVO> orderList(Map<String,Object> map)throws Exception;
	
	public void quickOrder(Order_detailVO vo)throws Exception;
	
	public int getCode()throws Exception;
	
	public ProductVO getOrderName(int order_code)throws Exception;
	
	public List<OrderDTO> detail(int order_code)throws Exception;
	
	public OrderVO order(int order_code)throws Exception;
	
	public void orderDel(int order_code)throws Exception;
	
	public void detailDel(int order_code)throws Exception;
	
	public int orderListCount(String user_id)throws Exception;
}
