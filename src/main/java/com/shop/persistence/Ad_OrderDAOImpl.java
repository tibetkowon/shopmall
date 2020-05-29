package com.shop.persistence;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.shop.domain.OrderDTO;
import com.shop.domain.OrderListVO;
import com.shop.domain.OrderVO;
import com.shop.util.OrderCriteria;

@Repository
public class Ad_OrderDAOImpl implements Ad_OrderDAO {

	@Autowired
	private SqlSession session;
	
	private static final String namespace = "com.shop.mapper/Ad_OrderMapper";

	@Override
	public List<OrderListVO> orderList(OrderCriteria cri) throws Exception {
		// TODO Auto-generated method stub
		return session.selectList(namespace + ".orderList", cri);
	}

	@Override
	public int orderCount(OrderCriteria cri) throws Exception {
		// TODO Auto-generated method stub
		return session.selectOne(namespace + ".orderCount", cri);
	}

	@Override
	public void update_status(OrderVO vo) throws Exception {
		// TODO Auto-generated method stub
		session.update(namespace + ".update_status", vo);
	}

	@Override
	public void check_update(Map<String, Object> map) throws Exception {
		// TODO Auto-generated method stub
		session.update(namespace + ".check_update", map);
	}

	@Override
	public OrderVO getOrder(int order_code) throws Exception {
		// TODO Auto-generated method stub
		return session.selectOne(namespace + ".getOrder", order_code);
	}

	@Override
	public List<OrderDTO> getOrder_detail(int order_code) throws Exception {
		// TODO Auto-generated method stub
		return session.selectList(namespace + ".getOrder_detail", order_code);
	}

}
