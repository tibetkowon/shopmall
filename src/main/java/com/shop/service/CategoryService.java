package com.shop.service;

import java.util.List;

import com.shop.domain.CategoryVO;

public interface CategoryService {

	public List<CategoryVO> prt_list()throws Exception;
	
	public List<CategoryVO> cate_list(String prt_code)throws Exception;
	
	public CategoryVO cate_Name(String sub_code) throws Exception;
}
