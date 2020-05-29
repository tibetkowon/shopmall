package com.shop.service;

import java.util.HashMap;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.shop.domain.CategoryVO;
import com.shop.domain.ProductDTO;
import com.shop.domain.ProductVO;
import com.shop.domain.QnADTO;
import com.shop.persistence.Ad_ProductDAO;
import com.shop.util.CategoryCriteria;
import com.shop.util.Criteria;

@Service
public class Ad_ProductServiceImpl implements Ad_ProductService {

	@Autowired
	private Ad_ProductDAO dao;
	
	@Override	
	public List<CategoryVO> categoryList() throws Exception {
		// TODO Auto-generated method stub
		return dao.categoryList();
	}

	@Override
	public List<CategoryVO> subCateList(String mainCate) throws Exception {
		// TODO Auto-generated method stub
		return dao.subCateList(mainCate);
	}

	@Override
	public void productInsert(ProductVO vo) throws Exception {
		// TODO Auto-generated method stub
		dao.productInsert(vo);
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
	public ProductVO proRead(int product_code) throws Exception {
		// TODO Auto-generated method stub
		return dao.proRead(product_code);
	}

	@Override
	public void proUpdate(ProductVO vo) throws Exception {
		// TODO Auto-generated method stub
		dao.proUpdate(vo);
	}

	@Override
	public String selectImage(int product_code) throws Exception {
		// TODO Auto-generated method stub
		return dao.selectImage(product_code);
	}

	@Override
	public void delete(int product_code) throws Exception {
		// TODO Auto-generated method stub
		dao.delete(product_code);
	}

	@Override
	public void quickModify(ProductDTO dto) throws Exception {
		// TODO Auto-generated method stub
		dao.quickModify(dto);
	}

	@Override
	public List<HashMap<String, Integer>> count_QnA() throws Exception {
		// TODO Auto-generated method stub
		return dao.count_QnA();
	}

	@Override
	public List<QnADTO> QnAList(Criteria cri) throws Exception {
		// TODO Auto-generated method stub
		return dao.QnAList(cri);
	}
	
	public int totalQnA()throws Exception{
		return dao.totalQnA();
	}

	@Override
	public QnADTO readQnA(int board_num) throws Exception {
		// TODO Auto-generated method stub
		return dao.readQnA(board_num);
	}

}
