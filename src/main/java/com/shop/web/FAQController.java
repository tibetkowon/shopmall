package com.shop.web;

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

import com.shop.domain.FAQVO;
import com.shop.service.FAQService;

@Controller
@RequestMapping("/FAQ/*")
public class FAQController {
	private static final Logger logger = LoggerFactory.getLogger(FAQController.class);
	
	@Inject
	private FAQService service;
	
	
	@RequestMapping("/list")
	public void list(FAQVO vo,Model model)throws Exception{
		System.out.println(service.count_reply());
		model.addAttribute("faq_list", service.faq_list());
		model.addAttribute("reply_list",service.count_reply());
	}
	
	@RequestMapping(value = "/write_FAQ" , method = RequestMethod.POST)
	public ResponseEntity<String> write_FAQ(FAQVO vo)throws Exception{
		logger.info(vo.toString());
		ResponseEntity<String> entity = null;
		
		try {
			service.write_faq(vo);
			entity = new ResponseEntity<String>("success",HttpStatus.OK);
			
		} catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
			entity = new ResponseEntity<String>(HttpStatus.BAD_REQUEST);
		}
		
		return entity;
	}
	
	@RequestMapping(value = "/{number}" , method = RequestMethod.GET)
	public String read(@PathVariable(value = "number") int faq_num,Model model)throws Exception{
		model.addAttribute("faq",service.faq_read(faq_num));
		model.addAttribute("replys", service.reply_list(faq_num));
		
		return "/FAQ/read";
	}
	
	@ResponseBody
	@RequestMapping(value = "/write_Reply" , method = RequestMethod.POST)
	public ResponseEntity<String> write_reply(FAQVO vo)throws Exception{
		ResponseEntity<String> entity = null;
		
		try {
			service.write_reply(vo);
			
			entity = new ResponseEntity<String>("success",HttpStatus.OK);
		} catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
			entity = new ResponseEntity<String>(HttpStatus.BAD_REQUEST);
		}
		
		
		return entity;
	}
	@ResponseBody
	@RequestMapping(value = "/write_re_reply" , method = RequestMethod.POST)
	public ResponseEntity<String> write_re_reply(FAQVO vo)throws Exception{
		logger.info(vo.toString());
		ResponseEntity<String> entity = null;
		
		try {
			service.write_re_reply(vo);
			entity = new ResponseEntity<String>("success",HttpStatus.OK);
		} catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
			entity = new ResponseEntity<String>(HttpStatus.BAD_REQUEST);
			}
		
		return entity;
	}
	@ResponseBody
	@RequestMapping(value = "/del_faq" , method = RequestMethod.POST)
	public ResponseEntity<String> del_faq(int faq_num)throws Exception{
		ResponseEntity<String> entity = null;
		
		try {
			service.del_faq(faq_num);
			entity = new ResponseEntity<String>("success",HttpStatus.OK);
		} catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
			entity = new ResponseEntity<String>(HttpStatus.BAD_REQUEST);
		}
		
		return entity;
	}
	@ResponseBody
	@RequestMapping(value = "/del_reply" , method = RequestMethod.POST)
	public ResponseEntity<String> del_reply(int faq_num)throws Exception{
		ResponseEntity<String> entity = null;
		
		try {
			service.del_reply(faq_num);
			entity = new ResponseEntity<String>("success",HttpStatus.OK);
		} catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
			entity = new ResponseEntity<String>(HttpStatus.BAD_REQUEST);
		}
		
		return entity;
	}
	@ResponseBody
	@RequestMapping(value = "/modify_reply" , method = RequestMethod.POST)
	public ResponseEntity<String> modify_reply(FAQVO vo)throws Exception{
		logger.info(vo.toString());
		ResponseEntity<String> entity = null;
		
		try {
			service.modify_reply(vo);
			entity = new ResponseEntity<String>("success",HttpStatus.OK);
		} catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
			entity = new ResponseEntity<String>(HttpStatus.BAD_REQUEST);
		}
		
		return entity;
	}
	@ResponseBody
	@RequestMapping(value = "/modify_FAQ" , method = RequestMethod.POST)
	public ResponseEntity<String> modify_FAQ(FAQVO vo)throws Exception{
		logger.info(vo.toString());
		ResponseEntity<String> entity = null;
		
		try {
			service.modify_faq(vo);
			entity = new ResponseEntity<String>("success",HttpStatus.OK);
		} catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
			entity = new ResponseEntity<String>(HttpStatus.BAD_REQUEST);
		}
		
		return entity;
	}
}
