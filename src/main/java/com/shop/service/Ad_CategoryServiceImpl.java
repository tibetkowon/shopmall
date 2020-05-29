package com.shop.service;

import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.shop.domain.CategoryVO;
import com.shop.persistence.CategoryDAO;
import com.shop.util.Criteria;

@Service
public class Ad_CategoryServiceImpl implements Ad_CategoryService {

	@Autowired
	private CategoryDAO dao;
	
	public List<CategoryVO> prt_list()throws Exception{
		return dao.prt_list();
	}
	
	public List<CategoryVO> cate_list(String prt_code) throws Exception{
		return dao.cate_list(prt_code);
	}

	@Override
	public void insert_prtCategory(CategoryVO vo) throws Exception {
		// TODO Auto-generated method stub
		dao.insert_prtCategory(vo);
	}

	@Override
	public void insert_subCategory(CategoryVO vo) throws Exception {
		// TODO Auto-generated method stub
		dao.insert_subCategory(vo);
	}

	@Override
	public List<CategoryVO> all_list(Criteria cri) throws Exception {
		// TODO Auto-generated method stub
		return dao.all_Category(cri);
	}

	@Override
	public int count_category() throws Exception {
		// TODO Auto-generated method stub
		return dao.count_category();
	}

	@Override
	public String modify_Category(CategoryVO vo) throws Exception {
		// TODO Auto-generated method stub
		String msg = "";
		
		if(dao.cate_list(vo.getCategory_code()).isEmpty()) {
			dao.modify_Category(vo);
			msg = "success";
		} else {
			msg = "isParents";
		}
		
		return msg;
	}

	@Override
	public String delete_Category(String category_code) throws Exception {
		// TODO Auto-generated method stub
		String msg = "";
		if(dao.cate_list(category_code).isEmpty()) {
			dao.delete_Category(category_code);
			msg = "success";
		} else {
			msg = "subExist";
		}
		
		return msg;
	}

	@Override
	@Transactional
	public String check_delete(List<String> codes) throws Exception {
		// TODO Auto-generated method stub
		String msg = "";
		List<String> prt = new ArrayList<String>();
		for(String code : codes) {
			if (!code.endsWith("00")) {
				dao.delete_Category(code);
			} else {
				prt.add(code);
			}
		}
		for(String code : prt) {
			if (dao.cate_list(code).isEmpty()) {
				dao.delete_Category(code);
				msg = "success";
			} else {
				msg = "subExist";
			}
		}
		return msg;
	}

	@Override
	public void check_modify(List<String> codes, List<String> names, List<String> prts) throws Exception {
		// TODO Auto-generated method stub
		CategoryVO vo = new CategoryVO();
		for(int i=0; i<codes.size(); i++) {
			if(dao.cate_list(codes.get(i)).isEmpty()) {				
			vo.setCategory_code(codes.get(i));
			vo.setCategory_name(names.get(i));
			vo.setParents_code(prts.get(i));
			dao.modify_Category(vo);
			} else {
				vo.setCategory_code(codes.get(i));
				vo.setParents_code("");
				vo.setCategory_name(names.get(i));
				dao.modify_Category(vo);
			}
		}
	}
}
