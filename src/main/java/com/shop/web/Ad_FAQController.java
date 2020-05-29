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
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.shop.domain.FAQVO;
import com.shop.service.Ad_FAQService;
import com.shop.util.Criteria;
import com.shop.util.PageMaker;

@Controller
@RequestMapping("/admin/FAQ/*")
public class Ad_FAQController {
	private static final Logger logger = LoggerFactory.getLogger(Ad_FAQController.class);
	
	@Inject
	private Ad_FAQService service;
	
	@RequestMapping(value = "/list")
	public void faqList(Criteria cri,Model model)throws Exception{
		logger.info("faqList");
		PageMaker pm = new PageMaker();
		pm.setCri(cri);
		pm.setTotalCount(service.totalFAQ());
		
		
		model.addAttribute("faqList", service.faqList(cri));
		model.addAttribute("replyList", service.replyCount());
		model.addAttribute("pageMaker", pm);
	}
	
	@RequestMapping(value = "/read/{num}" , method = RequestMethod.GET)
	public String readFAQ(@PathVariable(value = "num")int num,Model model)throws Exception{
		
		model.addAttribute("faq", service.readFAQ(num));
		model.addAttribute("replys", service.readReply(num));
		
		return "/admin/FAQ/read";
	}
	@ResponseBody
	@RequestMapping(value = "/writeReply" , method=RequestMethod.POST)
	public ResponseEntity<String> write_Reply(FAQVO vo)throws Exception{
		ResponseEntity<String>entity = null;
		
		try {
			service.write_reply(vo);
			entity = new ResponseEntity<String>("success",HttpStatus.OK);
		} catch(Exception e) {
			e.printStackTrace();
			entity = new ResponseEntity<String>(HttpStatus.BAD_REQUEST);
		}
		
		return entity;
	}
	@ResponseBody
	@RequestMapping(value = "/write_re_Reply" , method=RequestMethod.POST)
	public ResponseEntity<String> write_re_Reply(FAQVO vo)throws Exception{
		ResponseEntity<String>entity = null;
		
		try {
			service.write_re_reply(vo);
			entity = new ResponseEntity<String>("success",HttpStatus.OK);
		} catch(Exception e) {
			e.printStackTrace();
			entity = new ResponseEntity<String>(HttpStatus.BAD_REQUEST);
		}
		
		return entity;
	}
	@ResponseBody
	@RequestMapping(value = "/deleteFAQ" , method=RequestMethod.GET)
	public ResponseEntity<String> deleteFAQ(int num)throws Exception{
		ResponseEntity<String>entity = null;
		
		try {
			service.deleteFAQ(num);
			entity = new ResponseEntity<String>("success",HttpStatus.OK);
		} catch(Exception e) {
			e.printStackTrace();
			entity = new ResponseEntity<String>(HttpStatus.BAD_REQUEST);
		}
		
		return entity;
	}
	@ResponseBody
	@RequestMapping(value = "/deleteList" , method=RequestMethod.POST)
	public ResponseEntity<String> deleteList(@RequestParam(value = "checkarr[]")List<Integer> num)throws Exception{
		logger.info(num.toString());
		ResponseEntity<String>entity = null;
		try {
			service.deleteList(num);
			entity = new ResponseEntity<String>("success",HttpStatus.OK);
		} catch(Exception e) {
			e.printStackTrace();
			entity = new ResponseEntity<String>(HttpStatus.BAD_REQUEST);
		}
		
		return entity;
	}
	@ResponseBody
	@RequestMapping(value = "/deleteReply" , method=RequestMethod.GET)
	public ResponseEntity<String> deleteReply(int faq_num)throws Exception{
		ResponseEntity<String>entity = null;
		try {
			service.delReply(faq_num);
			entity = new ResponseEntity<String>("success",HttpStatus.OK);
		} catch(Exception e) {
			e.printStackTrace();
			entity = new ResponseEntity<String>(HttpStatus.BAD_REQUEST);
		}
		
		return entity;
	}
	@ResponseBody
	@RequestMapping(value = "/deleteReplyList" , method=RequestMethod.POST)
	public ResponseEntity<String> deleteReplyList(@RequestParam(value = "list[]")List<Integer> list)throws Exception{
		ResponseEntity<String>entity = null;
		try {
			service.deleteReplyList(list);
			entity = new ResponseEntity<String>("success",HttpStatus.OK);
		} catch(Exception e) {
			e.printStackTrace();
			entity = new ResponseEntity<String>(HttpStatus.BAD_REQUEST);
		}
		
		return entity;
	}
}
