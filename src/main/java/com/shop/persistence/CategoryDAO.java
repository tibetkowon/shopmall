package com.shop.persistence;

import java.util.List;

import com.shop.domain.CategoryVO;
import com.shop.util.Criteria;

public interface CategoryDAO {

	public List<CategoryVO> prt_list()throws Exception;
	
	public List<CategoryVO> cate_list(String prt_code) throws Exception;
	
	public List<CategoryVO> all_Category(Criteria cri)throws Exception;
	
	public CategoryVO cate_Name(String sub_code) throws Exception;
	
	public void insert_prtCategory(CategoryVO vo)throws Exception;
	
	public void insert_subCategory(CategoryVO vo)throws Exception;
	
	public int count_category()throws Exception;
	
	public void modify_Category(CategoryVO vo)throws Exception;
	
	public void delete_Category(String category_code)throws Exception;

}