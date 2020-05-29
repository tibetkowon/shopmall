package com.shop.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.shop.domain.OrderListVO;
import com.shop.domain.OrderVO;
import com.shop.domain.Order_detailVO;
import com.shop.domain.ProductVO;
import com.shop.persistence.OrderDAO;
import com.shop.util.Criteria;

@Service
public class OrderServiceImpl implements OrderService {

	@Autowired
	OrderDAO dao;

	@Override
	@Transactional
	public void insertOrder(List<Integer> cart_code, OrderVO vo) throws Exception {
		// TODO Auto-generated method stub
		Map<String,Object> map = new HashMap<String,Object>();
		int order_code = dao.getCode();
		
		vo.setOrder_code(order_code);
		
		map.put("order_code", order_code); 
		map.put("cart_code", cart_code);
		
		dao.insertOrder(vo);
		dao.insertDetail(map);
		
	}

	@Override
	public List<OrderListVO> orderList(String user_id,Criteria cri) throws Exception {
		// TODO Auto-generated method stub
		Map<String,Object> map = new HashMap<String,Object>();
		map.put("user_id",user_id);
		map.put("Criteria", cri);
		List<OrderListVO> list = dao.orderList(map);
		OrderListVO vo = null;
		ProductVO p_vo = null;
		for(int i = 0 ; i< list.size(); i++) {
			vo = list.get(i);
			p_vo = dao.getOrderName(vo.getOrder_code());
			vo.setProduct_code(p_vo.getProduct_code());
			vo.setProduct_name(p_vo.getProduct_name());
			list.set(i, vo);
		}
		return list;
	}

	@Override
	@Transactional
	public void quickOrder(OrderVO vo, Order_detailVO d_vo) throws Exception {
		// TODO Auto-generated method stub
		vo.setOrder_code(dao.getCode());
		d_vo.setOrder_code(dao.getCode());
		dao.insertOrder(vo);
		dao.quickOrder(d_vo);
	}

	@Override
	public Map<String,Object> detail(int order_code , String user_id) throws Exception {
		// TODO Auto-generated method stub
		Map<String,Object> map = new HashMap<String,Object>();
		OrderVO vo = dao.order(order_code);
		
		if(vo.getUser_id().equals(user_id)) {
			map.put("order",vo);			
			map.put("productList", dao.detail(order_code));
		} else {
			map.put("order",null);
		}
		
		return map;
	}

	@Override
	@Transactional
	public void delete(int order_code) throws Exception {
		// TODO Auto-generated method stub
		dao.detailDel(order_code);
		dao.orderDel(order_code);
	}

	@Override
	public int orderListCount(String user_id) throws Exception {
		// TODO Auto-generated method stub
		return dao.orderListCount(user_id);
	}
}
