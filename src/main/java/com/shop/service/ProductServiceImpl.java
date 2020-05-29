package com.shop.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.shop.domain.ProductVO;
import com.shop.persistence.ProductDAO;
import com.shop.util.CategoryCriteria;

@Service
public class ProductServiceImpl implements ProductService {

	@Autowired
	ProductDAO dao;

	@Override
	public ProductVO productSelect(int code) throws Exception {
		// TODO Auto-generated method stub
		return dao.productSelect(code);
	}

	@Override
	public List<ProductVO> productList(CategoryCriteria cri) throws Exception {
		// TODO Auto-generated method stub
		return dao.productList(cri);
	}

	@Override
	public int productCount(CategoryCriteria cri) throws Exception {
		// TODO Auto-generated method stub
		return dao.productCount(cri);
	}

	@Override
	public List<ProductVO> homeProList(CategoryCriteria cri) throws Exception {
		// TODO Auto-generated method stub
		return dao.homeProList(cri);
	}

	@Override
	public int homeCount(CategoryCriteria cri) throws Exception {
		// TODO Auto-generated method stub
		return dao.homeCount(cri);
	}
}
