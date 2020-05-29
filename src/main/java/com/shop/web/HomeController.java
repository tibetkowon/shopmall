package com.shop.web;

import javax.inject.Inject;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.shop.service.ProductService;
import com.shop.util.CategoryCriteria;
import com.shop.util.PageMaker;

@Controller
public class HomeController {
	private static final Logger logger = LoggerFactory.getLogger(HomeController.class);
	@Inject
	ProductService p_service;
	// 메인화면
	@RequestMapping("/")
	public String home(CategoryCriteria cri,Model model) throws Exception {
		logger.info("메인화면");
		PageMaker pm = new PageMaker();
		
		
		pm.setCri(cri);
		pm.setTotalCount(p_service.homeCount(cri));
		
		model.addAttribute("pageMaker", pm);
		model.addAttribute("ProductList",p_service.homeProList(cri));
		return "home";
	}
	
	
	@RequestMapping(value = "/search" , method = RequestMethod.GET)
	public String SearchList(CategoryCriteria cri,Model model)throws Exception{
		logger.info("홈검색");
		PageMaker pm = new PageMaker();
		
		pm.setCri(cri);
		pm.setTotalCount(p_service.homeCount(cri));
		
		model.addAttribute("ProductList", p_service.homeProList(cri));
		model.addAttribute("cri", cri);
		model.addAttribute("pageMaker", pm);
		
		return "home";
	}
}
