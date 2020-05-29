package com.shop.persistence;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.shop.domain.OrderDTO;
import com.shop.domain.OrderListVO;
import com.shop.domain.OrderVO;
import com.shop.domain.Order_detailVO;
import com.shop.domain.ProductVO;

@Repository
public class OrderDAOImpl implements OrderDAO {

	@Autowired
	SqlSession session;
	
	private static final String namespace = "com.shop.mapper/OrderMapper";


	@Override
	public void insertOrder(OrderVO vo) throws Exception {
		// TODO Auto-generated method stub
		session.insert(namespace + ".insertOrder" , vo);
	}


	@Override
	public void insertDetail(Map<String,Object>map) throws Exception {
		// TODO Auto-generated method stub
		session.insert(namespace + ".insertDetail" , map);
	}


	@Override
	public List<OrderListVO> orderList(Map<String,Object> map) throws Exception {
		// TODO Auto-generated method stub
		return session.selectList(namespace + ".orderList", map);
	}


	@Override
	public void quickOrder(Order_detailVO vo) throws Exception {
		// TODO Auto-generated method stub
		session.insert(namespace + ".quickOrder", vo);
	}


	@Override
	public int getCode() throws Exception {
		// TODO Auto-generated method stub
		return session.selectOne(namespace + ".getCode");
	}


	@Override
	public ProductVO getOrderName(int order_code) throws Exception {
		// TODO Auto-generated method stub
		return session.selectOne(namespace + ".getOrderName", order_code);
	}


	@Override
	public List<OrderDTO> detail(int order_code) throws Exception {
		// TODO Auto-generated method stub
		return session.selectList(namespace + ".detail", order_code);
	}


	@Override
	public OrderVO order(int order_code) throws Exception {
		// TODO Auto-generated method stub
		return session.selectOne(namespace + ".order", order_code);
	}


	@Override
	public void orderDel(int order_code) throws Exception {
		// TODO Auto-generated method stub
		session.delete(namespace + ".orderDel", order_code);
	}


	@Override
	public void detailDel(int order_code) throws Exception {
		// TODO Auto-generated method stub
		session.delete(namespace + ".detailDel", order_code);
	}


	@Override
	public int orderListCount(String user_id) throws Exception {
		// TODO Auto-generated method stub
		return session.selectOne(namespace + ".orderListCount", user_id);
	}
	
	
}
