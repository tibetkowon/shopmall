package com.shop.web;

import java.util.List;

import javax.inject.Inject;

import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.shop.domain.CategoryVO;
import com.shop.service.Ad_CategoryService;
import com.shop.util.Criteria;
import com.shop.util.PageMaker;

@Controller
@RequestMapping("/admin/category/*")
public class Ad_CategoryController {

	@Inject
	private Ad_CategoryService service;
	
	@RequestMapping("/list")
	public void list(Model model,Criteria cri)throws Exception{
		PageMaker pm = new PageMaker();
		
		pm.setCri(cri);
		pm.setTotalCount(service.count_category());
		
		model.addAttribute("pageMaker", pm);
		model.addAttribute("all_list", service.all_list(cri));
		model.addAttribute("prt_list", service.prt_list());
	}

	@ResponseBody
	@RequestMapping(value = "/insert" , method=RequestMethod.POST)
	public ResponseEntity<String> insert_cate(CategoryVO vo)throws Exception{
		ResponseEntity<String> entity = null;
		
		try {
			if(vo.getParents_code().equals("0")) {
				service.insert_prtCategory(vo);
			} else {
				service.insert_subCategory(vo);
			}
			entity =  new ResponseEntity<String>("success",HttpStatus.OK);
		} catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
			entity = new ResponseEntity<String>(HttpStatus.BAD_REQUEST);
		}
		
		return entity;
	}
	
	@ResponseBody
	@RequestMapping(value = "/modify" , method=RequestMethod.POST)
	public ResponseEntity<String> modify_Category(CategoryVO vo)throws Exception{
		ResponseEntity<String> entity = null;
		
		try {
			entity = new ResponseEntity<String>(service.modify_Category(vo),HttpStatus.OK);
		} catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
			entity = new ResponseEntity<String>(HttpStatus.BAD_REQUEST);
		}
		
		return entity;
	}
	
	@ResponseBody
	@RequestMapping(value = "/delete" , method=RequestMethod.POST)
	public ResponseEntity<String> delete_Category(String category_code)throws Exception{
		ResponseEntity<String> entity = null;
		
		try {
			
			entity = new ResponseEntity<String>(service.delete_Category(category_code),HttpStatus.OK);
		} catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
			entity = new ResponseEntity<String>(HttpStatus.BAD_REQUEST);
		}
		
		return entity;
	}
	
	@ResponseBody
	@RequestMapping(value = "/checkDelete" , method=RequestMethod.POST)
	public ResponseEntity<String> check_delete(@RequestParam(value = "codes[]")List<String> codes)throws Exception{
		ResponseEntity<String> entity = null;
		
		try {
			entity = new ResponseEntity<String>(service.check_delete(codes),HttpStatus.OK);
		} catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
			entity = new ResponseEntity<String>(HttpStatus.BAD_REQUEST);
		}
		
		return entity;
	}
	@ResponseBody
	@RequestMapping(value = "/checkModify" , method=RequestMethod.POST)
	public ResponseEntity<String> checkModify(@RequestParam(value = "codes[]")List<String> codes,
			@RequestParam(value = "prts[]")List<String> prts,@RequestParam(value = "names[]")List<String> names)throws Exception{
		ResponseEntity<String> entity = null;
		
		try {
			service.check_modify(codes, names, prts);
			entity = new ResponseEntity<String>("success",HttpStatus.OK);
		} catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
			entity = new ResponseEntity<String>(HttpStatus.BAD_REQUEST);
		}
		
		return entity;
	}
}
