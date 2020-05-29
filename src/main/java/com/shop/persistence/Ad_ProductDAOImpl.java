package com.shop.persistence;

import java.util.HashMap;
import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.shop.domain.CategoryVO;
import com.shop.domain.ProductDTO;
import com.shop.domain.ProductVO;
import com.shop.domain.QnADTO;
import com.shop.util.CategoryCriteria;
import com.shop.util.Criteria;

@Repository
public class Ad_ProductDAOImpl implements Ad_ProductDAO {

	private final static String namespace = "com.shop.mapper/Ad_ProductMapper";
	
	@Autowired
	SqlSession session;
	
	@Override
	public List<CategoryVO> categoryList() throws Exception {
		// TODO Auto-generated method stub
		return session.selectList(namespace+".categoryList");
	}

	@Override
	public List<CategoryVO> subCateList(String mainCate) throws Exception {
		// TODO Auto-generated method stub
		return session.selectList(namespace+ ".subCateList", mainCate);
	}

	@Override
	public void productInsert(ProductVO vo) throws Exception {
		// TODO Auto-generated method stub
		session.insert(namespace + ".productInsert", vo);
	}

	@Override
	public List<ProductVO> productList(CategoryCriteria cri) throws Exception {
		// TODO Auto-generated method stub
		return session.selectList(namespace+ ".productList", cri);
	}

	@Override
	public int productCount(CategoryCriteria cri) throws Exception {
		// TODO Auto-generated method stub
		return session.selectOne(namespace + ".proCount",cri);
	}

	@Override
	public ProductVO proRead(int product_code) throws Exception {
		// TODO Auto-generated method stub
		return session.selectOne(namespace + ".productRead", product_code);
	}

	@Override
	public void proUpdate(ProductVO vo) throws Exception {
		// TODO Auto-generated method stub
		session.update(namespace + ".modify", vo);
	}

	@Override
	public String selectImage(int product_code) throws Exception {
		// TODO Auto-generated method stub
		return session.selectOne(namespace + ".selectImage", product_code);
	}

	@Override
	public void delete(int product_code) throws Exception {
		// TODO Auto-generated method stub
		session.delete(namespace + ".delete", product_code);
		
	}

	@Override
	public void quickModify(ProductDTO dto) throws Exception {
		// TODO Auto-generated method stub
		session.update(namespace + ".quickModify", dto);
	}

	@Override
	public List<HashMap<String,Integer>> count_QnA() throws Exception {
		// TODO Auto-generated method stub
		return session.selectList(namespace + ".count_QnA");
	}

	@Override
	public List<QnADTO> QnAList(Criteria cri) throws Exception {
		// TODO Auto-generated method stub
		return session.selectList(namespace + ".QnAList" , cri);
	}
	
	public QnADTO readQnA(int board_num)throws Exception{
		return session.selectOne(namespace + ".readQnA", board_num);
	}

	@Override
	public int totalQnA() throws Exception {
		// TODO Auto-generated method stub
		return session.selectOne(namespace + ".totalQnA");
	}
}
