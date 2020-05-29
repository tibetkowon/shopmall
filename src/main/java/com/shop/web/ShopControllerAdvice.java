package com.shop.web;

import javax.inject.Inject;

import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ControllerAdvice;
import org.springframework.web.bind.annotation.ModelAttribute;

import com.shop.service.CategoryService;
import com.shop.util.SessionListener;

@ControllerAdvice(basePackages = {"com.shop.web"})
public class ShopControllerAdvice {
	
	@Inject
	private CategoryService cate_service;
	
	static 	SessionListener listener =  SessionListener.getInstance();
	
	@ModelAttribute
	public void prt_list(Model model) throws Exception{
		model.addAttribute("prt_cateCode", cate_service.prt_list());
	}
}
