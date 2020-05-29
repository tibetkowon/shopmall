package com.shop.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.shop.domain.CategoryVO;
import com.shop.persistence.CategoryDAO;

@Service
public class CategoryServiceImpl implements CategoryService {

	@Autowired
	private CategoryDAO dao;

	@Override
	public List<CategoryVO> prt_list() throws Exception {
		// TODO Auto-generated method stub
		return dao.prt_list();
	}

	@Override
	public List<CategoryVO> cate_list(String prt_code) throws Exception {
		// TODO Auto-generated method stub
		return dao.cate_list(prt_code);
	}

	@Override
	public CategoryVO cate_Name(String sub_code) throws Exception {
		// TODO Auto-generated method stub
		return dao.cate_Name(sub_code);
	}
}
