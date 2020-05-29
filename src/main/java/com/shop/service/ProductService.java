package com.shop.service;

import java.util.List;

import com.shop.domain.ProductVO;
import com.shop.util.CategoryCriteria;

public interface ProductService {

	public ProductVO productSelect(int code) throws Exception;
	
	public List<ProductVO> productList(CategoryCriteria cri)throws Exception;
	
	public int productCount(CategoryCriteria cri)throws Exception;
	
	public List<ProductVO> homeProList(CategoryCriteria cri)throws Exception;
	
	public int homeCount(CategoryCriteria cri)throws Exception;
}
