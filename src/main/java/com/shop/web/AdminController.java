package com.shop.web;

import javax.inject.Inject;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.shop.domain.AdminVO;
import com.shop.domain.LoginDTO;
import com.shop.service.AdminService;
import com.shop.service.CategoryService;
import com.shop.util.SessionListener;

@Controller
@RequestMapping("/admin/*")
public class AdminController {
	private static final Logger logger = LoggerFactory.getLogger(AdminController.class);

	@Inject
	private AdminService service;
	@Inject
	private CategoryService cateService;

	// 기본주소 : 로그인 시 홈화면 , 비로그인 시 로그인화면
	@RequestMapping(value = "/", method = RequestMethod.GET)
	public String ad_home(HttpSession session,Model model) throws Exception {
		logger.info("관리자 메인화면 (/)");
		logger.info(cateService.prt_list().toString());
		Object login = null;
		String url = null;
		login = session.getAttribute("admin");

		if (login == null) {
			url = "/admin/login";
		} else {
			url = "/admin/home";
			model.addAttribute("prtList", cateService.prt_list());
			model.addAttribute("no_reply", service.countQnA());
			model.addAttribute("newFAQ", service.countFAQ());
			model.addAttribute("newOrder", service.countOrder());
		}
		return url;
		
	}

	// 로그인 페이지
	@RequestMapping(value = "/login", method = RequestMethod.GET)
	public void ad_loginPage() throws Exception {
		logger.info("관리자 로그인 페이지");
	}

	// 로그인 작업
	@RequestMapping(value = "/login", method = RequestMethod.POST)
	public String ad_login(LoginDTO dto, HttpSession session,RedirectAttributes rttr) throws Exception {
		SessionListener listener =  SessionListener.getInstance();
		logger.info("관리자 로그인 시도");
		AdminVO vo = service.login(dto);
		String url = null;

		if (vo == null) {
			url = "/admin/login";
			rttr.addFlashAttribute("msg", "log_fail");
		} else {
			if(listener.isUsing(dto.getId())) {
				url = "/admin/login";
				rttr.addFlashAttribute("msg", "log_used");				
			}else {
				listener.setSession(session, dto.getId());
			session.setAttribute("admin", vo);
			Object dest = session.getAttribute("dest"); // 원래 요쳥한 정보사용
		    url = (dest != null ? (String) dest : "/admin/");
		    session.removeAttribute("dest");
			}
		}

		return "redirect:" + url;
	}
	@RequestMapping(value = "/pw_modify", method = RequestMethod.GET)
	public void pw_modify()throws Exception{
	}
	
	// 비밀번호 변경
	@ResponseBody
	@RequestMapping(value = "/pw_modify", method = RequestMethod.POST)
	public ResponseEntity<Integer> pw_modify(String now_pw, String change_pw, String admin_id,HttpSession session) throws Exception {
		ResponseEntity<Integer> entity = null;
		logger.info(now_pw,change_pw,admin_id);
		try {
			int answer = service.pw_modify(now_pw, change_pw, admin_id);
			if (answer == 1) {
				session.invalidate();
			}
			entity = new ResponseEntity<Integer>(answer, HttpStatus.OK);
		} catch (Exception e) {
			e.printStackTrace();
			entity = new ResponseEntity<Integer>(HttpStatus.BAD_REQUEST);
		}

		return entity;
	}
	
	// 로그아웃
	@RequestMapping(value = "logout" , method = RequestMethod.GET)
	public String ad_logout(HttpSession session,RedirectAttributes rttr)throws Exception{
		logger.info("로그아웃");
		
		session.invalidate();
		rttr.addFlashAttribute("msg", "log_out");
		return "redirect:/admin/";
	}

}
