package com.shop.persistence;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.shop.domain.ProductVO;
import com.shop.util.CategoryCriteria;

@Repository
public class ProductDAOImpl implements ProductDAO {

	private final static String namespace = "com.shop.mapper/ProductMapper";
	
	@Autowired
	private SqlSession session;

	@Override
	public ProductVO productSelect(int code) throws Exception {
		// TODO Auto-generated method stub
		return session.selectOne(namespace +".productSelect", code);
	}

	@Override
	public List<ProductVO> productList(CategoryCriteria cri) throws Exception {
		// TODO Auto-generated method stub
		return session.selectList(namespace + ".productList",cri);
	}

	@Override
	public int productCount(CategoryCriteria cri) throws Exception {
		// TODO Auto-generated method stub
		return session.selectOne(namespace + ".proCount", cri);
	}

	@Override
	public List<ProductVO> homeProList(CategoryCriteria cri) throws Exception {
		// TODO Auto-generated method stub
		return session.selectList(namespace + ".homeProList", cri);
	}

	@Override
	public int homeCount(CategoryCriteria cri) throws Exception {
		// TODO Auto-generated method stub
		return session.selectOne(namespace + ".homeCount", cri);
	}
	
	
}
