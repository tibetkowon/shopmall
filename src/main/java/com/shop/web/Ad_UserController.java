package com.shop.web;

import java.util.List;

import javax.inject.Inject;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.shop.domain.MailVO;
import com.shop.domain.UserVO;
import com.shop.service.Ad_UserService;
import com.shop.service.EmailService;
import com.shop.util.Criteria;
import com.shop.util.PageMaker;

@Controller
@RequestMapping("/admin/user/*")
public class Ad_UserController {
	private static final Logger logger = LoggerFactory.getLogger(Ad_UserController.class);
	
	@Inject
	private Ad_UserService service;
	@Inject
	private EmailService m_service;
	
	@RequestMapping(value = "/list", method = RequestMethod.GET)
	public void userList(Model model,Criteria cri)throws Exception{
		model.addAttribute("userList", service.userList(cri));
		PageMaker pm = new PageMaker();
		
		pm.setCri(cri);
		pm.setTotalCount(service.countUser());
		
		model.addAttribute("pageMaker", pm);
	}
	
	@ResponseBody
	@RequestMapping(value = "/detail" , method = RequestMethod.POST)
	public ResponseEntity<UserVO> userdetail(String user_id)throws Exception{
		logger.info(user_id + " 세부사항");
	ResponseEntity<UserVO> entity = null;
	
	try {
		entity = new ResponseEntity<UserVO>(service.userdetail(user_id),HttpStatus.OK);
	} catch (Exception e) {
		// TODO: handle exception
		e.printStackTrace();
		entity = new ResponseEntity<UserVO>(HttpStatus.BAD_REQUEST);
	}
	return entity;
	}
	
	@ResponseBody
	@RequestMapping(value = "/sendMail" , method = RequestMethod.POST)
	public ResponseEntity<Integer> sendMail(@RequestParam("mail[]")List<String> ids,MailVO vo)throws Exception{
		logger.info(vo.toString());
		logger.info(ids.toString());
		ResponseEntity<Integer> entity = null;
		try {
			List<UserVO> mails = service.getEmail(ids);
			m_service.sendMails(vo, mails);
			entity = new ResponseEntity<Integer>(1,HttpStatus.OK);
		} catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
			entity = new ResponseEntity<Integer>(HttpStatus.BAD_REQUEST);
		}
		return entity;
	}
	
	@ResponseBody
	@RequestMapping(value = "/allMail" , method = RequestMethod.POST)
	public ResponseEntity<Integer> allMail(MailVO vo)throws Exception{
		logger.info(vo.toString());
		ResponseEntity<Integer> entity = null;
		try {
			List<UserVO> mails = service.allEmail();
			m_service.sendMails(vo, mails);
			entity = new ResponseEntity<Integer>(1,HttpStatus.OK);
		} catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
			entity = new ResponseEntity<Integer>(HttpStatus.BAD_REQUEST);
		}
		return entity;
	}
	
	@ResponseBody
	@RequestMapping(value = "/userDelete" , method = RequestMethod.POST)
	public ResponseEntity<Integer> userDelete(String id)throws Exception{
		ResponseEntity<Integer> entity = null;
		try {
			service.userDelete(id);
			entity = new ResponseEntity<Integer>(1,HttpStatus.OK);
		} catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
			entity = new ResponseEntity<Integer>(HttpStatus.BAD_REQUEST);
		}		
		return entity;
	}
	
	@ResponseBody
	@RequestMapping(value = "/checkDelete" , method = RequestMethod.POST)
	public ResponseEntity<Integer> checkDelete(@RequestParam("ids[]")List<String> ids)throws Exception{
		ResponseEntity<Integer> entity = null;
		try {
			service.checkDelete(ids);
			entity = new ResponseEntity<Integer>(1,HttpStatus.OK);
		} catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
			entity = new ResponseEntity<Integer>(HttpStatus.BAD_REQUEST);
		}		
		return entity;
	}
}
