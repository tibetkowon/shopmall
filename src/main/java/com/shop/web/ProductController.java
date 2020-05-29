package com.shop.web;

import java.util.List;

import javax.inject.Inject;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.shop.domain.CategoryVO;
import com.shop.domain.ReviewVO;
import com.shop.service.BoardService;
import com.shop.service.CategoryService;
import com.shop.service.ProductService;
import com.shop.service.ReviewService;
import com.shop.util.CategoryCriteria;
import com.shop.util.PageMaker;

@Controller
@RequestMapping("/product/*")
public class ProductController {
	private static final Logger logger = LoggerFactory.getLogger(ProductController.class);
	
	@Inject
	private ProductService service;
	@Inject
	private CategoryService cate_service;
	@Inject
	private ReviewService r_service;
	@Inject
	private BoardService b_service;
	
	@RequestMapping(value = "/{code}" , method = RequestMethod.GET)
	public String selected(@PathVariable("code")int code, Model model)throws Exception{
		logger.info("상품 화면");
		model.addAttribute("productVO", service.productSelect(code));
		model.addAttribute("boardList",b_service.boardList(code));
		return "/product/select";
	}
	@RequestMapping(value = "/list/{code}" , method = RequestMethod.GET)
	public String productList(@PathVariable("code")String cate_code,CategoryCriteria cri ,Model model)throws Exception{
		logger.info(cate_code + " 상품 리스트 " + cri.toString());
		cri.setSubCategory(cate_code);
		
		model.addAttribute("ProductList", service.productList(cri));
		PageMaker pm = new PageMaker();
		
		pm.setCri(cri);
		pm.setTotalCount(service.productCount(cri));
		model.addAttribute("pageMaker", pm);
		model.addAttribute("cate_code", cate_code);
		model.addAttribute("cri",cri);
		
		return "/product/list";
	}
	
	
	@ResponseBody
	@RequestMapping(value = "/getCate/{prt_code}" , method = RequestMethod.GET)
	public ResponseEntity<List<CategoryVO>> cateList(@PathVariable("prt_code")String prt_code)throws Exception{
		logger.info(prt_code);
		ResponseEntity<List<CategoryVO>> entity = null;
		
		try {
			entity = new ResponseEntity<List<CategoryVO>>(cate_service.cate_list(prt_code),HttpStatus.OK);
		} catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
			entity = new ResponseEntity<List<CategoryVO>>(HttpStatus.BAD_REQUEST);
		}
		
		return entity;
	}
	
	@ResponseBody
	@RequestMapping(value = "/getName/{sub_code}" , method = RequestMethod.GET)
	public ResponseEntity<CategoryVO> cateName(@PathVariable("sub_code")String sub_code)throws Exception{
		logger.info(sub_code);
		ResponseEntity<CategoryVO> entity = null;
		
		try {
			entity = new ResponseEntity<CategoryVO>(cate_service.cate_Name(sub_code),HttpStatus.OK);
		} catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
			entity = new ResponseEntity<CategoryVO>(HttpStatus.BAD_REQUEST);
		}
		
		return entity;
	}
	//리뷰읽기
	@ResponseBody
	@RequestMapping(value = "/readReview/{code}" ,method = RequestMethod.GET)
	public ResponseEntity<List<ReviewVO>> readReview(@PathVariable("code")int product_code)throws Exception{
		ResponseEntity<List<ReviewVO>> entity = null;
		
		try {
			entity = new ResponseEntity<List<ReviewVO>>(r_service.readReview(product_code),HttpStatus.OK);
			
		} catch (Exception e) {
			e.printStackTrace();
			entity = new ResponseEntity<List<ReviewVO>>(HttpStatus.BAD_REQUEST);
		}
		
		return entity;
	}
	//리뷰 쓰기
	@ResponseBody
	@RequestMapping(value = "/writeReview", method = RequestMethod.POST)
	public ResponseEntity<Integer> writeReview(ReviewVO vo)throws Exception{
		ResponseEntity<Integer> entity = null;
		
		try {
			r_service.writeReview(vo);
			entity = new ResponseEntity<Integer>(1,HttpStatus.OK);
		} catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
			entity = new ResponseEntity<Integer>(HttpStatus.BAD_REQUEST);
		}
		
		return entity;
	}
	
	//리뷰 수정
	@ResponseBody
	@RequestMapping(value = "/modifyReview" , method = RequestMethod.POST)
	public ResponseEntity<Integer> modifyReview(ReviewVO vo)throws Exception{
		ResponseEntity<Integer> entity = null;
		logger.info(vo.toString());
		try {
			r_service.modifyReview(vo);
			entity = new ResponseEntity<Integer>(1,HttpStatus.OK);
		} catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
			entity = new ResponseEntity<Integer>(HttpStatus.BAD_REQUEST);
		}
		
		return entity;
		
	};
	
	//리뷰삭제
	@ResponseBody
	@RequestMapping(value = "/deleteReview" , method = RequestMethod.POST)
	public ResponseEntity<Integer> deleteReview(int review_id)throws Exception{
		ResponseEntity<Integer> entity = null;
		
		try {
			r_service.deleteReview(review_id);
			entity = new ResponseEntity<Integer>(1,HttpStatus.OK);
		} catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
			entity = new ResponseEntity<Integer>(HttpStatus.BAD_REQUEST);
		}
		
		return entity;
		
	}
	
}
