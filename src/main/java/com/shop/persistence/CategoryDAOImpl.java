package com.shop.persistence;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.shop.domain.CategoryVO;
import com.shop.util.Criteria;

@Repository
public class CategoryDAOImpl implements CategoryDAO {

	@Autowired
	private SqlSession session;
	
	private static final String namespace = "com.shop.mapper/CategoryMapper";

	@Override
	public List<CategoryVO> prt_list() throws Exception {
		// TODO Auto-generated method stub
		return session.selectList(namespace + ".prt_cateCode");
	}

	@Override
	public List<CategoryVO> cate_list(String prt_code) throws Exception {
		// TODO Auto-generated method stub
		return session.selectList(namespace + ".cateCode", prt_code);
	}

	@Override
	public CategoryVO cate_Name(String sub_code) throws Exception {
		// TODO Auto-generated method stub
		return session.selectOne(namespace + ".cateName", sub_code);
	}

	@Override
	public void insert_prtCategory(CategoryVO vo) throws Exception {
		// TODO Auto-generated method stub
		session.insert(namespace + ".insert_prtCategory", vo);
	}

	@Override
	public void insert_subCategory(CategoryVO vo) throws Exception {
		// TODO Auto-generated method stub
		session.insert(namespace + ".insert_subCategory", vo);
	}

	@Override
	public List<CategoryVO> all_Category(Criteria cri) throws Exception {
		// TODO Auto-generated method stub
		return session.selectList(namespace + ".all_category" ,cri);
	}

	@Override
	public int count_category() throws Exception {
		// TODO Auto-generated method stub
		return session.selectOne(namespace + ".count_category");
	}

	@Override
	public void modify_Category(CategoryVO vo) throws Exception {
		// TODO Auto-generated method stub
		session.update(namespace + ".modify_Category", vo);
	}

	@Override
	public void delete_Category(String category_code) throws Exception {
		// TODO Auto-generated method stub
		session.delete(namespace +".delete_Category", category_code);
	}

}
