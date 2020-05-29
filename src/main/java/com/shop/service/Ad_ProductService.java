package com.shop.service;

import java.util.HashMap;
import java.util.List;

import com.shop.domain.CategoryVO;
import com.shop.domain.ProductDTO;
import com.shop.domain.ProductVO;
import com.shop.domain.QnADTO;
import com.shop.util.CategoryCriteria;
import com.shop.util.Criteria;

public interface Ad_ProductService {
	//1차 카테고리
	public List<CategoryVO> categoryList() throws Exception;
	//2차 카테고리
	public List<CategoryVO> subCateList(String mainCate) throws Exception;
	//상품 등록
	public void productInsert(ProductVO vo)throws Exception;
	//상품목록
	public List<ProductVO> productList(CategoryCriteria cri)throws Exception;
	//상품수(페이징)
	public int productCount(CategoryCriteria cri)throws Exception;
	//상품 읽기
	public ProductVO proRead(int product_code)throws Exception;
	//상품 수정
	public void proUpdate(ProductVO vo)throws Exception;
	//이미지 받아오기
	public String selectImage(int product_code) throws Exception;
	//상품 삭제
	public void delete(int product_code)throws Exception;
	//빠른 수정
	public void quickModify(ProductDTO dto)throws Exception;
	
	public List<HashMap<String,Integer>> count_QnA()throws Exception;
	
	public List<QnADTO> QnAList(Criteria cri)throws Exception;
	
	public int totalQnA()throws Exception;
	
	public QnADTO readQnA(int board_num)throws Exception;

}
