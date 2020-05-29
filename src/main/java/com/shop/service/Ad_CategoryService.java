package com.shop.service;

import java.util.List;

import com.shop.domain.CategoryVO;
import com.shop.util.Criteria;

public interface Ad_CategoryService {
	
	public List<CategoryVO> all_list(Criteria Cri)throws Exception;

	public List<CategoryVO> prt_list()throws Exception;
	
	public List<CategoryVO> cate_list(String prt_code) throws Exception;
	
	public void insert_prtCategory(CategoryVO vo)throws Exception;
	
	public void insert_subCategory(CategoryVO vo)throws Exception;
	
	public int count_category()throws Exception;
	
	public String modify_Category(CategoryVO vo)throws Exception;
	
	public String delete_Category(String category_code)throws Exception;
	
	public String check_delete(List<String> codes)throws Exception;
	
	public void check_modify(List<String> codes,List<String> names,List<String> prts)throws Exception;
}
