package com.shop.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.shop.domain.OrderListVO;
import com.shop.domain.OrderVO;
import com.shop.persistence.Ad_OrderDAO;
import com.shop.util.OrderCriteria;

@Service
public class Ad_OrderServiceImpl implements Ad_OrderService {
	
	@Autowired
	private Ad_OrderDAO dao;

	@Override
	public List<OrderListVO> orderList(OrderCriteria cri) throws Exception {
		// TODO Auto-generated method stub
		return dao.orderList(cri);
	}

	@Override
	public int orderCount(OrderCriteria cri) throws Exception {
		// TODO Auto-generated method stub
		return dao.orderCount(cri);
	}

	@Override
	public void update_status(OrderVO vo) throws Exception {
		// TODO Auto-generated method stub
		dao.update_status(vo);
		
	}

	@Override
	public void check_update(List<Integer> codes, char status) throws Exception {
		// TODO Auto-generated method stub
		Map<String,Object> map = new HashMap<String,Object>();
		map.put("codes", codes);
		map.put("status", status);
		
		dao.check_update(map);
	}

	@Override
	public Map<String, Object> getOrder(int order_code) throws Exception {
		// TODO Auto-generated method stub
		Map<String,Object> map = new HashMap<String,Object>();
		
		map.put("vo", dao.getOrder(order_code));
		map.put("dto", dao.getOrder_detail(order_code));
		return map;
	}

}
